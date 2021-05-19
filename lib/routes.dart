import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bull/pages/1MainMenu/_bloc.dart';
import 'package:flutter_bull/pages/1MainMenu/_page.dart';
import 'package:flutter_bull/pages/2GameRoom/_page.dart';
import 'package:flutter_bull/utilities/repository.dart';

class Routes {

  static Route<Object?> Loading_To_MainMenu(BuildContext context) {
    return CupertinoPageRoute(
        builder: (context){
          return MainMenu();

        });
  }

  static Route<Object?> MainMenu_To_GameRoom(BuildContext context) {
    return CupertinoPageRoute(
        builder: (context){
          return GameRoom();

        });

    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => GameRoom(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
    );
  }

}