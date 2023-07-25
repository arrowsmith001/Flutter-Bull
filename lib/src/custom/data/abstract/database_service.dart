import 'entity.dart';


abstract class DatabaseService<T extends Entity> {

  Future<T> create(T item);
  Future<T> read(String id);
  Future<void> update(String itemId, String fieldName, dynamic value);
  Future<void> delete(String itemId);

  Future<List<T>> readMultiple(Iterable<String> ids);
  Future<List<T>> readWhere(String field, dynamic value);

  Future<int> countWhere(String fieldName, dynamic value);
}

class EmptyDatabaseService<T extends Entity> extends DatabaseService<T> {

  @override
  Future<T> create(T item, {String? idOverride}) {
    throw UnimplementedError();
  }

  @override
  Future<void> delete(String itemId) {
    throw UnimplementedError();
  }

  @override
  Future<List<T>> readAll() {
    throw UnimplementedError();
  }

  @override
  Future<T> read(String id) {
    throw UnimplementedError();
  }

  @override
  Future<List<T>> readMultiple(Iterable<String> ids) {
    throw UnimplementedError();
  }

  @override
  Future<List<T>> readWhere(String field, dynamic value) {
    throw UnimplementedError();
  }


  @override
  Future<void> update(String itemId, String fieldName, value) {
    throw UnimplementedError();
  }
  @override
  Future<int> countWhere(String fieldName, value) {
    // TODO: implement countByEqualsCondition
    throw UnimplementedError();
  }
}
