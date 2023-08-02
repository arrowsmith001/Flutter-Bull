import 'package:flutter/material.dart';
import 'package:flutter_bull/src/navigation/navigation_controller.dart';
import 'package:flutter_bull/src/notifiers/states/signed_in_player_status_notifier_state.dart';

class ControlledNavigator<T> extends StatelessWidget {
  const ControlledNavigator({required this.controller, required this.data});

  final NavigationController<T> controller;
  final T data;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      observers: [HeroController()],
      key: controller.navigatorKey,
      onGenerateRoute: controller.onGenerateRoute,
      initialRoute: controller.getInitialRoute(data),
    );
  }
}
