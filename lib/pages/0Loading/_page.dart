
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bull/pages/0Loading/_bloc_events.dart';
import 'package:flutter_bull/pages/1MainMenu/_bloc.dart';
import 'package:flutter_bull/pages/1MainMenu/_page.dart';
import 'package:flutter_bull/utilities/repository.dart';
import 'package:flutter_bull/widgets.dart';
import 'package:provider/provider.dart';

import 'package:extensions/extensions.dart';
import '../../routes.dart';
import '_bloc.dart';
import '_bloc_states.dart';

class Loading extends StatefulWidget {


  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  @override
  void initState() {
    super.initState();
    context.read<LoadingBloc>().add(StartLoading());
  }

  bool goingToMainMenu = false;
  void goToMainMenu() {
    print('goToMainMenu');
    if(goingToMainMenu) return;
    goingToMainMenu = true;
    Navigator.of(context).pushAndRemoveUntil(Routes.Loading_To_MainMenu(context), (route) => false);
  }

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<LoadingBloc, LoadingState>(
      builder: (context, state) {

        if(state is LoadingError) print(state.message);

        bool loading = false;
        String message = '';
        double? progress;

        if(state is LoadingProgress)
          {
            loading = true;
            message = state.message;
            progress = state.progress;
          }

        return SafeArea(
          child: Scaffold(
            body: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor
              ),
              child: Center(
                child: !loading ? EmptyWidget()
                    : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      backgroundColor: Colors.white,
                      value: progress,
                    ),
                    Text(message)
                  ],
                ),
              ),
            ),
          ),
        );

      },
      listener: (context, state){
        if(state is LoadingComplete)
          {
            goToMainMenu();
          }
      },
    );
  }

}


