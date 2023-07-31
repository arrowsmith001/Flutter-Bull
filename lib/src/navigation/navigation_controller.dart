import 'package:flutter/material.dart';
import 'package:flutter_bull/src/navigation/animated_routes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

abstract class NavigationController<T> {
  final navigatorKey = GlobalKey<NavigatorState>();
  BuildContext? get _navigatorContext => navigatorKey.currentContext;
  bool get canNavigate => _navigatorContext != null;

/*   @protected
  SlideRoute? prevRoute; */

  Route onGenerateRoute(RouteSettings settings) {
    final routeNameIterable = settings.name!.split('/');
    _routeIterator = routeNameIterable.iterator;

    PageRoute? route = resolveRoute();

/*     if (route is SlideRoute && prevRoute != null) {
      prevRoute!.exitOffset = -route.getInitialOffset;
      prevRoute = route;
    } */

    setCurrentRouteName = routeNameIterable.first;

    return route ?? defaultRoute;
  }

  @protected
  Widget scoped(Widget child, {overrides = const <Override>[]}) =>
      ProviderScope(child: child, overrides: overrides);

  @protected
  void navigateTo(String s) {
    if (canNavigate) {
      Navigator.of(_navigatorContext!).pushReplacementNamed(s);
      Logger().d('Navigated to: $s ${DateTime.now().toIso8601String()}');
    } else {
      //ogger().d('Error navigating to: $s ${DateTime.now().toIso8601String()}');
    }
  }

  @protected
  String get nextRoutePath => (_routeIterator!..moveNext()).current;

  @protected
  PageRoute? resolveRoute();

  @protected
  Route get defaultRoute;

  Iterator<String>? _routeIterator;
  String? _initialRoute;
  String? _currentRouteName;

  String initialRoute(T data) {
    if (_initialRoute != null) return _initialRoute!;
    _initialRoute = generateInitialRoute(data);
    return _initialRoute!;
  }

  String get getCurrentRouteName => _currentRouteName ?? '';

  set setCurrentRouteName(String s) => _currentRouteName = s;

  String generateInitialRoute(T data);
}
