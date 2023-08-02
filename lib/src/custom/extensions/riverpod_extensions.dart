
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension RiverpodExtensions<T> on AsyncValue<T> {
  R whenDefault<R>(
      R Function(T data) data,
      {
        R Function()? loading,
        R Function(Object, StackTrace)? error,
        
        bool skipLoadingOnReload = false,
      bool skipLoadingOnRefresh = true,
      bool skipError = false}) {
    return when<R>(skipLoadingOnReload: skipLoadingOnReload, skipLoadingOnRefresh: skipLoadingOnRefresh, skipError: skipError,
      data: data, 
      error: error ?? (e,_) => Text(e.toString() + _.toString()) as R, 
      loading: loading ?? () => 
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
