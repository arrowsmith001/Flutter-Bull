import 'package:flutter/material.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_circular_progress_indicator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Loading extends ConsumerWidget {
  final double dim;

  const Loading({super.key, required this.dim});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return UtterBullCircularProgressIndicator(size: Size(dim, dim));
  }
}
