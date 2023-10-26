import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transparent_pointer/transparent_pointer.dart';

class NotificationCenter extends ConsumerStatefulWidget {
  const NotificationCenter({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NotificationCenterState();
}

class _NotificationCenterState extends ConsumerState<NotificationCenter> {
  @override
  Widget build(BuildContext context) {
    return TransparentPointer(
      child: Container(),
    );
  }
}
