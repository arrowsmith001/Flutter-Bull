
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension RiverpodExtensions<T> on AsyncValue<T> {
  R whenDefault<R>(
      R Function(T data) data,
      {bool skipLoadingOnReload = false,
      bool skipLoadingOnRefresh = true,
      bool skipError = false}) {
    return when<R>(skipLoadingOnReload: skipLoadingOnReload, skipLoadingOnRefresh: skipLoadingOnRefresh, skipError: skipError,
      data: data, error: (e,_) => Text(e.toString()) as R, loading: () => 
      Center(
        child: Column(
          children: [
            Spacer(),
            Flexible(child: AspectRatio(aspectRatio: 1.0, child: CircularProgressIndicator())),
            Spacer(),
          ],
        )) as R);
  }
}
