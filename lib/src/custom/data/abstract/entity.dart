import 'package:freezed_annotation/freezed_annotation.dart';

abstract class Entity {
  String? get id;
  Map<String, dynamic> toJson();
}

