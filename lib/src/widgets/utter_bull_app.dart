
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bull/src/style/utter_bull_theme.dart';
import 'package:flutter_bull/src/views/0_app/auth_container.dart';
import 'package:flutter_bull/src/views/home/utter_bull.dart';
import 'package:flutter_bull/src/widgets/utter_bull_master_background.dart';

class UtterBullApp extends StatelessWidget {
  const UtterBullApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
            scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch, PointerDeviceKind.stylus, PointerDeviceKind.unknown},
      ),
              debugShowCheckedModeBanner: false,
              theme: UtterBullGlobal.theme,
              home: const UtterBullMasterBackground(
                child: UtterBull()
              ));
  }
}