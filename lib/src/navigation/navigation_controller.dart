import 'package:flutter/material.dart';
import 'package:flutter_bull/src/navigation/animated_routes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

abstract class NavigationController<T> {

  String? _initialRoute;
  String? _currentRouteName;
  Iterator<String>? _routeIterator;
  BuildContext? get _navigatorContext => navigatorKey.currentContext;


  final navigatorKey = GlobalKey<NavigatorState>();
  bool get canNavigate => _navigatorContext != null;


  Route onGenerateRoute(RouteSettings settings) {
    final routeNameIterable = settings.name!.split('/');
    _routeIterator = routeNameIterable.iterator;

    PageRoute? route = generateRoute();

    setCurrentRouteName = routeNameIterable.first;

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
  String get nextRoutePath => (_routeIterator!..moveNext()).current;

  @protected
  String get getCurrentRouteName => _currentRouteName ?? '';

  @protected
  set setCurrentRouteName(String s) => _currentRouteName = s;
  

  @protected
  ProviderScope scoped(Widget child, {List<Override> overrides = const <Override>[]}) =>
      ProviderScope(child: child, overrides: overrides);


}
