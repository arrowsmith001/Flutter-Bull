import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:rxdart/rxdart.dart';

abstract class AuthService implements Listenable {
  String? get getUserId;
  bool get isSignedIn;

  Stream<String?> streamUserId();
  Future<void> signOut();

  Future<void> signInAnonymously();
  Future<void> signInWithEmailAndPassword(String email, String password);
  Future<void> signInWithGoogle();

  Future<void> createUserWithEmailAndPassword(String email, String password);

  final List<VoidCallback> _listeners = [];

  @override
  void addListener(VoidCallback listener) {
    _listeners.add(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    _listeners.remove(listener);
  }

  void invokeListeners() {
    for (final listener in _listeners) {
      listener.call();
    }
  }
}

class FakeAuthService extends AuthService {
  FakeAuthService(this._userId);

  final String _userId;

  final BehaviorSubject<bool> _subject = BehaviorSubject.seeded(false);
  late StreamSink<bool> sink = _subject.sink;

  @override
  Stream<String?> streamUserId() =>
      _subject.map((signedIn) => signedIn ? _userId : null);

  @override
  Future<void> signInAnonymously() async {
    assert(isSignedIn == false);
    _subject.add(true);
    invokeListeners();
  }

  @override
  Future<void> signOut() async {
    assert(isSignedIn == true);

    _subject.add(false);
    invokeListeners();
  }

  @override
  Future<void> signInWithGoogle() async {
    throw UnimplementedError();
  }

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) {
    throw UnimplementedError();
  }

  @override
  String? get getUserId => _subject.value ? _userId : null;

  @override
  bool get isSignedIn => _subject.value;
  
  @override
  Future<void> createUserWithEmailAndPassword(String email, String password) {
    // TODO: implement createUserWithEmailAndPassword
    throw UnimplementedError();
  }
}
