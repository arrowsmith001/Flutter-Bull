import 'dart:async';
import 'dart:typed_data';
import 'dart:math' as math;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bull/firebase/_bloc.dart';
import 'package:flutter_bull/gen/assets.gen.dart';
import 'package:flutter_bull/pages/0Loading/_bloc.dart';
import 'package:flutter_bull/pages/0Loading/_page.dart';
import 'package:flutter_bull/pages/1MainMenu/_bloc.dart';
import 'package:flutter_bull/pages/1MainMenu/_page.dart';
import 'package:flutter_bull/pages/2GameRoom/_bloc.dart';
import 'package:flutter_bull/particles.dart';
import 'package:flutter_bull/utilities/local_res.dart';
import 'package:flutter_bull/firebase/provider.dart';
import 'package:flutter_bull/utilities/repository.dart';
import 'package:flutter_bull/utilities/res.dart';
import 'package:flutter_bull/utilities/prefs.dart';
import 'package:flutter_bull/utilities/profile.dart';
import 'package:multiple_stream_builder/multiple_stream_builder.dart';
import 'package:prefs/prefs.dart';
import 'package:provider/provider.dart';
import 'classes/firebase.dart';
import 'extensions.dart';
import 'dart:ui' as ui;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

    @override
    Widget build(BuildContext context) {
      return _buildApp();
  }

  Widget _buildApp(){
      return RepositoryProvider(
        lazy: true,
        create: (_) => Repository(),
        child: MultiBlocProvider(
            providers: [
              BlocProvider<LoadingBloc>(lazy: true, create: (_) => LoadingBloc()),

              BlocProvider<FirebaseBloc>(lazy: true, create: (_) => FirebaseBloc(repo: RepositoryProvider.of<Repository>(_))),

              BlocProvider<MainMenuBloc>(lazy: true, create: (_)
              {
                var firebaseBloc = BlocProvider.of<FirebaseBloc>(_);
                return MainMenuBloc(new MainMenuModel(firebaseBloc.model), firebaseBloc: firebaseBloc);
              }),

              BlocProvider<GameRoomBloc>(lazy: true, create: (_)
              {
                var firebaseBloc = BlocProvider.of<FirebaseBloc>(_);
                return GameRoomBloc(new GameRoomModel(firebaseBloc.model), firebaseBloc: firebaseBloc);
              }),
            ],
            child: CupertinoApp(
                title: 'Utter Bull',
                theme: CupertinoThemeData(
                    scaffoldBackgroundColor: AppColors.MainColor,
                    primaryColor: AppColors.MainColor
                ),
                home: Loading(),
              onGenerateRoute: (settings) {

              },
            )),
      );
  }
}







