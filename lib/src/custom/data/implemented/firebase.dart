import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bull/src/custom/data/abstract/auth_service.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';

import '../abstract/database_service.dart';
import '../abstract/entity.dart';

class FirebaseDatabaseService<T extends Entity> implements DatabaseService<T> {
  FirebaseDatabaseService(this.collectionName, this.deserializeDocument);

  final String collectionName;
  final T Function(Map<String, dynamic>) deserializeDocument;

  CollectionReference<Map<String, dynamic>> get collection =>
      FirebaseFirestore.instance.collection(collectionName);

  CollectionReference<T> get collectionWithConverter {
    return collection.withConverter(
        fromFirestore: _fromFirestore, toFirestore: _toFirestore);
  }

  T _fromFirestore(
          DocumentSnapshot<Map<String, dynamic>> d, SnapshotOptions? options) =>
      deserializeDocument(d.data()!..addAll({'id': d.id}));

  Map<String, Object?> _toFirestore(T value, SetOptions? options) =>
      value.toJson();

  @override
  Future<List<T>> fetchAll() async {
    final q = await collectionWithConverter.get();
    return q.docs.map((e) => e.data()).toList();
  }

  @override
  Future<T> fetchById(String id) async {
    return await collectionWithConverter
        .doc(id)
        .get()
        .then((value) => value.data()!);
  }

  @override
  Future<List<T>> fetchByIds(Iterable<String> ids) {
    return Future.wait(ids.map((id) => fetchById(id)));
  }

  // TODO: Consider separating IDed case and IDless case
  @override
  Future<T> create(T item) async {
    if (item.id == null) {
      final doc = await collectionWithConverter.add(item);
      await doc.update({'id': doc.id});
      return await doc.get().then((value) => value.data()!);
    } else {
      await collectionWithConverter.doc(item.id).set(item);
      return await collectionWithConverter
          .doc(item.id)
          .get()
          .then((value) => value.data()!);
    }
  }

  @override
  Future<List<T>> fetchWhere(String field, String value) async {
    final q =
        await collectionWithConverter.where(field, isEqualTo: value).get();
    return q.docs.map<T>((e) => e.data()).toList();
  }

  @override
  Future<Map<String, List<T>>> fetchWhereMultiple(
      String field, Iterable<String> values) async {
    final lists = await Future.wait(values.map((value) =>
        fetchWhere(field, value).then((results) => MapEntry(value, results))));
    return Map.fromEntries(lists);
  }

  @override
  Stream<T> streamById(String id) {
    return collectionWithConverter
        .doc(id)
        .snapshots()
        .map((event) => event.data()!);
  }

  @override
  Future<void> setField(String itemId, String fieldName, dynamic value) {
    return collection.doc(itemId).update({fieldName: value});
  }

  @override
  Future<void> delete(String itemId) {
    throw UnimplementedError();
  }

  @override
  Future<int> countByEqualsCondition(String fieldName, value) {
    return collection
        .where(fieldName, isEqualTo: value)
        .count()
        .get()
        .then((value) => value.count);
  }
}

// TODO: Test force logout - https://stackoverflow.com/questions/53087895/how-to-force-logout-firebase-auth-user-from-app-remotely
class FirebaseAuthService extends AuthService {

  FirebaseAuth get auth => FirebaseAuth.instance;

  FirebaseAuthService() {
    auth.authStateChanges().listen((event) {
      Logger().d('authStateChanges');
      invokeListeners();
    });
    auth.userChanges().listen((event) {
      Logger().d('userChanges');
    });

  }


  @override
  Stream<String?> streamUserId() {
    return auth.authStateChanges().map((event) => event?.uid); // auth.userChanges().map((user) => user?.uid);
  }

  @override
  bool get isSignedIn {
    return auth.currentUser != null;
  }

  @override
  Future<void> signInAnonymously() async {
    await auth.signInAnonymously();
  }

  @override
  Future<void> signOut() async {
    await auth.signOut();
  }

  @override
  Future<void> signInWithGoogle() async {}

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  String? get getUserId => auth.currentUser?.uid;

  @override
  void addListener(VoidCallback listener) {}

  @override
  void removeListener(VoidCallback listener) {}
}

class FirebaseLiteDatabaseService<T extends Entity>
    extends FirebaseDatabaseService<T> {
  FirebaseLiteDatabaseService(super.collectionName, super.deserializeDocument);

  @override
  Future<List<T>> fetchAll() async {
    final q = await collectionWithConverter.limit(10).get();
    return q.docs.map<T>((e) => e.data()).toList();
  }
}
