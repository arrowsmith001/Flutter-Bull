import 'package:flutter/material.dart';

extension BuildContextExtensions on BuildContext {

  void pop() {
    Navigator.of(this).pop();
  }
  
  void pushNamed(String routeName, {Object? arguments}) {
    Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }
}
