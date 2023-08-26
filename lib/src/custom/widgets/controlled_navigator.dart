import 'package:flutter/material.dart';
import 'package:flutter_bull/src/navigation/navigation_controller.dart';

class ControlledNavigator<T> extends StatelessWidget {

  const ControlledNavigator({required this.controller, required this.data, this.observers = const []});

  final NavigationController<T> controller;
  final T data;
  final List<NavigatorObserver> observers;
  
  @override
  Widget build(BuildContext context) {

    return Navigator(
      observers: observers,
      key: controller.navigatorKey,
      onGenerateRoute: controller.onGenerateRoute,
      initialRoute: controller.getInitialRoute(data),
    );
  }
}
