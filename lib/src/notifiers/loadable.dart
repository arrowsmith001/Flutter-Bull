import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class Loadable {

  // TODO: Clone
  AsyncValue<Loadable> loading() {
    isLoading = true;
    return AsyncValue.data(this);
  }

  bool isLoading = false;
}
