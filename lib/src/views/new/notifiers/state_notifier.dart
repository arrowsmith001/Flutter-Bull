import 'dart:async';

import 'package:flutter_bull/src/custom/data/abstract/auth_service.dart';
import 'package:flutter_bull/src/views/new/notifiers/states/app_state.dart';
import 'package:flutter_bull/src/views/new/notifiers/states/auth_notifier_state.dart';
import 'package:flutter_bull/src/providers/app_services.dart';
import 'package:flutter_bull/src/services/data_layer.dart';
import 'package:flutter_bull/src/services/data_stream_service.dart';
import 'package:flutter_bull/src/style/utter_bull_theme.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:logger/logger.dart';

part 'state_notifier.g.dart';

@Riverpod(keepAlive: true)
class StateNotifier extends _$StateNotifier {
  AuthService get _authService => ref.read(authServiceProvider);

  @override
  Stream<AppState> build() async* {

    yield AppState();
  }


  void openSignUpPage(){
    setData(value.copyWith(signUpPageState: SignUpPageState.open, authBarState: AuthBarState.hide));
  }
  void validateSignUpPage(){
    setData(value.copyWith(signUpPageState: SignUpPageState.validating));
  }
  void closeSignUpPage(){
    setData(value.copyWith(signUpPageState: SignUpPageState.closed, authBarState: AuthBarState.show));
  }
  

  void addBusy(Busies busy) {
    final busies = state.valueOrNull?.busyWith ?? [];

    if (busies.contains(busy)) {
      Logger().d('App is already busy with ${busy.name}');
      return;
    }

    setData(value.copyWith(busyWith: busies..add(busy)));
  }


  void removeBusy(Busies busy) {
    
    final busies = state.valueOrNull?.busyWith ?? [];

    if (!busies.contains(busy)) {
      Logger().d('App was NOT already busy with ${busy.name}');
      return;
    }

    setData(value.copyWith(busyWith: busies..remove(busy)));
  }

  
  AppState get value => state.value ?? AppState();

  void setData(AppState newState) {
    Logger().d('setting new AppState: $newState');
    state = AsyncData(newState);
  }
}

enum HomePageState { home, creatingRoom, joiningRoom }
