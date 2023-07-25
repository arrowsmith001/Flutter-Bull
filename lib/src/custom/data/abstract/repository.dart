import 'dart:async';
import 'dart:collection';

import 'package:flutter_bull/src/model/game_room.dart';

import 'database_service.dart';
import 'entity.dart';

class Repository<T extends Entity> {
  Repository(this.databaseService, {Iterable<T>? initialItems}) {
    if (initialItems != null && initialItems.isNotEmpty) {
      cache.cacheAll(initialItems);
    }
  }

  // TODO: Use cache
  Cache<T> cache = EmptyCache<T>();
  int get cacheCount => cache.count;

  final DatabaseService<T> databaseService;

  Future<int> countByEqualsCondition(String field, dynamic value) {
    return databaseService.countWhere(field, value);
  }

/*   Stream<T>? streamItemById(String id) {
    return databaseService.streamById(id)?.map((item) {
      cache.cache(item);
      return item;
    });
  } */

  Future<void> deleteItem(String itemId) async {
    await databaseService.delete(itemId);
    cache.deleteById(itemId);
  }

  Future<T> getItemById(String id) async {
    if (cache.contains(id)) return cache.get(id)!;
    final T entity = await databaseService.read(id);
    cache.cache(entity);
    return entity;
  }

/*   Future<List<T>> getAll() async {
    final fetchedItems = await databaseService.readAll();
    cache.cacheAll(fetchedItems);
    /*   fetchedItems.forEach((element) {
      AppLogger.log(element.serialized().toString());
    }); */
    return fetchedItems;
  } */

  Future<List<T>> getItemsByField(String fieldName, String fieldValue) async {
    final fetchedItems =
        await databaseService.readWhere(fieldName, fieldValue);
    cache.cacheAll(fetchedItems);
    return fetchedItems;
  }

  Future<T> createItem(T item) async {
    try {
      final createdItem = await databaseService.create(item);
      //cache.cache(createdItem);
      return createdItem;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> setField(String itemId, String fieldName, dynamic value) async {
    await databaseService.update(itemId, fieldName, value);
    final updatedItem = await databaseService.read(itemId);
    cache.cache(updatedItem);
  }

  Future<List<T>> getItemsByIds(Iterable<String> itemIds) async {
    if (itemIds.isEmpty) return [];
    final cachedItems = cache.getAsMany(itemIds);
    final cachedItemIds = []; //cachedItems.map((e) => e.id);

    final uncachedItems = await databaseService.readMultiple(
        itemIds.where((element) => !cachedItemIds.contains(element)));
    cache.cacheAll(uncachedItems);
    cachedItems.addAll(uncachedItems);

    return cachedItems;
  }

  Future<bool> itemExists(String userId) async {
    try {
      await databaseService.read(userId);
      return true;
    } catch (e) {
      return false;
    }
  }

}

class EmptyCache<T extends Entity> implements Cache<T> {
  @override
  void cache(T? entity) {}

  @override
  void cacheAll(Iterable<T> entities) {}

  @override
  void clear() {}

  @override
  bool contains(String id) {
    return false;
  }

  @override
  get count => 0;

  @override
  void deleteById(String itemId) {}

  @override
  T? get(String id) {
    return null;
  }

  @override
  List<T> getAsMany(Iterable<String> itemIds) {
    return [];
  }

  @override
  HashMap<String, T> get itemIdsToItems => HashMap();
}

class Cache<T extends Entity> {
  final HashMap<String, T> itemIdsToItems = HashMap();

  get count => itemIdsToItems.length;

  T? get(String id) {
    return itemIdsToItems[id];
  }

  bool contains(String id) => itemIdsToItems.containsKey(id);

  void cache(T? entity) {
/*     if (entity == null || entity.id == null) return;
    if (contains(entity.id!))
      itemIdsToItems.update(entity.id!, (_) => entity);
    else
      itemIdsToItems.addAll({entity.id!: entity}); */
  }

  void cacheAll(Iterable<T> entities) {
    for (var entity in entities) {
      cache(entity);
    }
  }

  List<T> getAsMany(Iterable<String> itemIds) {
    return itemIds
        .where((element) => contains(element))
        .map((e) => get(e)!)
        .toList();
  }

  void deleteById(String itemId) {
    itemIdsToItems.removeWhere((key, value) => key == itemId);
  }

  void clear() {
    itemIdsToItems.clear();
  }
}
