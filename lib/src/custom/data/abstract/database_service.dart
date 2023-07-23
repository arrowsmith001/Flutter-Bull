import 'dart:collection';

import 'entity.dart';

abstract class DatabaseService<T extends Entity> {
  Future<T> create(T item);
  Future<void> delete(String itemId);

  Future<List<T>> fetchAll();

  Future<T> fetchById(String id);
  Future<List<T>> fetchByIds(Iterable<String> ids);
  Future<List<T>> fetchWhere(String field, String value);
  Future<Map<String, List<T>>> fetchWhereMultiple(String field, Iterable<String> values);
  
  Future<void> setField(String itemId, String fieldName, value);

  // TODO: Remove?
  Stream<T>? streamById(String id);


  Future<int> countByEqualsCondition(String fieldName, value);
}

class EmptyDatabaseService<T extends Entity> extends DatabaseService<T> {
  @override
  Future<T> create(T item) {
    throw UnimplementedError();
  }

  @override
  Future<void> delete(String itemId) {
    throw UnimplementedError();
  }

  @override
  Future<List<T>> fetchAll() {
    throw UnimplementedError();
  }

  @override
  Future<T> fetchById(String id) {
    throw UnimplementedError();
  }

  @override
  Future<List<T>> fetchByIds(Iterable<String> ids) {
    throw UnimplementedError();
  }

  @override
  Future<List<T>> fetchWhere(String field, String value) {
    throw UnimplementedError();
  }

  @override
  Future<Map<String, List<T>>> fetchWhereMultiple(
      String field, Iterable<String> values) {
    throw UnimplementedError();
  }

  @override
  Future<void> setField(String itemId, String fieldName, value) {
    throw UnimplementedError();
  }

  @override
  Stream<T>? streamById(String id) {
    throw UnimplementedError();
  }
  
  @override
  Future<int> countByEqualsCondition(String fieldName, value) {
    // TODO: implement countByEqualsCondition
    throw UnimplementedError();
  }
}
