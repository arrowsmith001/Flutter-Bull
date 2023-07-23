import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bull/src/custom/data/abstract/database_service.dart';
import 'package:sqflite/sqflite.dart';
import 'package:logger/logger.dart';

import '../abstract/entity.dart';

class LocalJSONDatabaseService<T extends Entity> implements DatabaseService<T> {
  final Database database;
  final String tableName;
  final T Function(Map<String, dynamic>) deserializeDocument;

  LocalJSONDatabaseService(
      this.database, this.tableName, this.deserializeDocument);

  @override
  Future<T> create(T item) async {
    final id = await database.rawInsert(
        "INSERT INTO $tableName(json) VALUES('${jsonEncode(item.toJson())}')");
    final query =
        await database.rawQuery('SELECT * FROM $tableName WHERE id=$id');
    final single = query.single;
    final fullMap = <String, dynamic>{}
      ..addAll(jsonDecode(single['json'].toString()))
      ..addAll({'id': single['id'].toString()});
    return deserializeDocument(fullMap);
  }

  @override
  Future<List<T>> fetchAll() async {
    List<Map<String, dynamic>> queryList =
        await database.rawQuery('SELECT * FROM $tableName');
    try {
      List<Map<String, dynamic>> list = queryList
          .map((q) => (jsonDecode(q['json']) as Map<String, dynamic>)
            ..addAll({'id': q['id'].toString()}))
          .toList();

      return list.map<T>(deserializeDocument).toList();
    } catch (e) {
      Logger()..d(e);
    }

    return [];
  }

  @override
  Future<T> fetchById(String id) async {
    List<Map<String, dynamic>> queryList =
        await database.rawQuery('SELECT * FROM $tableName WHERE id = $id');

    try {
      Map<String, dynamic> q = queryList.single;
      final json = jsonDecode(q['json']) as Map<String, dynamic>;
      json.addAll({'id': q['id'].toString()});
      return deserializeDocument(json);
    } catch (e) {
      Logger()..d(e);
    }

    throw Exception();
  }

  @override
  Future<List<T>> fetchByIds(Iterable<String> ids) async {
    List<Map<String, dynamic>> queryList = await database
        .rawQuery('SELECT * FROM $tableName WHERE id in (${ids.join(',')})');

    try {
      List<Map<String, dynamic>> list = queryList
          .map((q) => (jsonDecode(q['json']) as Map<String, dynamic>)
            ..addAll({'id': q['id'].toString()}))
          .toList();
      return list.map<T>(deserializeDocument).toList();
    } catch (e) {
      Logger()..d(e);
    }

    return [];
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
  Future<void> setField(String itemId, String fieldName, value) async {
    List<Map<String, dynamic>> queryList = await database
        .rawQuery('SELECT * FROM $tableName WHERE id = "$itemId"');

    final q = jsonDecode(queryList.single['json'].toString());
    q[fieldName] = value;

    await database.rawQuery(
        "UPDATE $tableName SET json = '${jsonEncode(q)}' WHERE id = '$itemId'");
  }

  @override
  Stream<T>? streamById(String id) {
    return database
        .rawQuery('SELECT 1 FROM $tableName WHERE id = $id')
        .then((value) {
      List<String> jsonList = value.map((e) => e['json'].toString()).toList();
      List<Map<String, dynamic>> list =
          jsonList.map((e) => jsonDecode(e) as Map<String, dynamic>).toList();
      return list.map<T>(deserializeDocument).toList().single;
    }).asStream();
  }

  @override
  Future<void> delete(String itemId) async {
    final count =
        await database.rawDelete('DELETE FROM $tableName WHERE id = ${itemId}');
  }
  
  @override
  Future<int> countByEqualsCondition(String fieldName, value) {
    throw UnimplementedError();
  }
}
