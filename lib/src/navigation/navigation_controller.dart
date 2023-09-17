import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

abstract class NavigationController<T> {

  String? _initialRoute;
  String? _currentRouteName;
  Iterator<String>? _routePathIterator;
  BuildContext? get _navigatorContext => navigatorKey.currentContext;

  final navigatorKey = GlobalKey<NavigatorState>();
  bool get canNavigate => _navigatorContext != null;

  Route onGenerateRoute(RouteSettings settings) {
    final routePathIterable = settings.name!.split('/');
    final nextRoute = routePathIterable.first;
    _routePathIterator = routePathIterable.iterator;

    PageRoute? route = generateRoute();

    setCurrentRouteName = nextRoute;
    return route ?? defaultRoute;
  }

  @protected
  PageRoute? generateRoute();

  String getInitialRoute(T data) {
    if (_initialRoute != null) return _initialRoute!;
    _initialRoute = generateInitialRoute(data);
    return _initialRoute!;
  }

  @protected
  String generateInitialRoute(T data);

  @protected
  void navigateTo(String s) {
    if (canNavigate) {
      Navigator.of(_navigatorContext!).pushReplacementNamed(s);
      Logger().d('Navigated to: $s ${DateTime.now().toIso8601String()}');
    } else {
      Logger().d('Error navigating to: $s ${DateTime.now().toIso8601String()}');
    }
  }

  @protected
  Route get defaultRoute;

  @protected
  String get nextRoutePath => (_routePathIterator!..moveNext()).current;

  @protected
  String? get tryNextRoutePath {
    try {
      return nextRoutePath;
    } catch (e) {
      return null;
    }
  }

  @protected
  String get getCurrentRouteName => _currentRouteName ?? '';

  @protected
  set setCurrentRouteName(String s) => _currentRouteName = s;

  @protected
  ProviderScope scoped(Widget child,
          {List<Override> overrides = const <Override>[]}) =>
      ProviderScope(child: child, overrides: overrides);
}
