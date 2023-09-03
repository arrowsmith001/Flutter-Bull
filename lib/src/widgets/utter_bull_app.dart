
import 'package:flutter/material.dart';
import 'package:flutter_bull/src/style/utter_bull_theme.dart';
import 'package:flutter_bull/src/views/0_app/auth_container.dart';
import 'package:flutter_bull/src/widgets/utter_bull_master_background.dart';

class UtterBullApp extends StatelessWidget {
  const UtterBullApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: UtterBullTheme.theme,
              home: const UtterBullMasterBackground(
                child: AuthContainer()
              ));
  }
}