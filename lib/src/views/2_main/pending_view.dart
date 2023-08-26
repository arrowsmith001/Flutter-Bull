import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final int timeoutSeconds = 3;

class PendingView extends ConsumerStatefulWidget {
  const PendingView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PendingViewState();
}

class _PendingViewState extends ConsumerState<PendingView> {

  late Timer t = Timer(Duration(seconds: timeoutSeconds), onTimeout);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    t.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      children: [Text(message), CircularProgressIndicator()],
    )));
  }

  String message = '';

  void onTimeout() {
    _setMessage('This is taking a while. Our servers might be offline.');
  }

  void _setMessage(String s) {
    setState(() {
      message = s;
    });
  }
}
