import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class Loadable {

  final bool isLoading;

  Loadable({this.isLoading = false});
}
