
import 'package:flutter/material.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_circular_progress_indicator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension RiverpodExtensions<T> on AsyncValue<T> {
  R whenDefault<R>(
      R Function(T data) data,
      {
        R Function()? loading,
        R Function(Object, StackTrace)? error,
        
        bool skipLoadingOnReload = true,
      bool skipLoadingOnRefresh = true,
      bool skipError = false}) {
    return when<R>(skipLoadingOnReload: skipLoadingOnReload, skipLoadingOnRefresh: skipLoadingOnRefresh, skipError: skipError,
      data: data, 
      error: (error, stackTrace) => ErrorWidget(error) as R, 
      loading: loading ?? () => 
      Center(
        child: Column(
          children: [
            Spacer(),
            Flexible(child: AspectRatio(aspectRatio: 1.0, child: UtterBullCircularProgressIndicator())),
            Spacer(),
          ],
        )) as R);
  }
}
