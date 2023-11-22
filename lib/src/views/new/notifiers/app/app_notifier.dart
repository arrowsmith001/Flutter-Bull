import 'dart:async';

import 'package:flutter_bull/src/custom/data/abstract/auth_service.dart';
import 'package:flutter_bull/src/views/new/notifiers/app/app_event_notifier.dart';
import 'package:flutter_bull/src/views/new/notifiers/app/app_state.dart';
import 'package:flutter_bull/src/views/new/notifiers/states/auth_notifier_state.dart';
import 'package:flutter_bull/src/providers/app_services.dart';
import 'package:flutter_bull/src/services/data_layer.dart';
import 'package:flutter_bull/src/services/data_stream_service.dart';
import 'package:flutter_bull/src/style/utter_bull_theme.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:logger/logger.dart';

part 'app_notifier.g.dart';


enum AuthBarState { hide, show }

enum SignUpPageState { open, valid, validating, invalid, closed }

enum CameraViewState { open, closed }

enum Busy { loggingIn, signingUp, creatingGame, joiningGame, signingOut }

@Riverpod(keepAlive: true)
class AppNotifier extends _$AppNotifier {
  
  AppEventNotifier get appEventNotifier =>
      ref.read(appEventNotifierProvider.notifier);

  @override
  Stream<AppState> build() async* {
    yield AppState(authBarState: AuthBarState.hide);
  }

  void setAuthBarState(AuthBarState desiredState) {
    setData(value.copyWith(authBarState: desiredState));
  }

  void setSignUpPageState(SignUpPageState desiredState) {
    setData(value.copyWith(signUpPageState: desiredState));
  }

  void setCameraViewState(CameraViewState desiredState) {
    setData(value.copyWith(cameraViewState: desiredState));
  }

  void addBusy(Busy busy) {
    final busies = state.valueOrNull?.busyWith ?? [];

    if (busies.contains(busy)) {
      Logger().d('App is already busy with ${busy.name}');
      return;
    }

    setData(value.copyWith(busyWith: [...busies, busy], nowBusy: busy));
  }

  void removeBusy(Busy busy) {
    final busies = state.valueOrNull?.busyWith ?? [];

    if (!busies.contains(busy)) {
      Logger().d('App was NOT already busy with ${busy.name}');
      return;
    }

    setData(value.copyWith(busyWith: busies.where((e) => e != busy).toList(), nowNotBusy: busy));
  }

  AppState get value => state.value ?? AppState();

  void setData(AppState newState) {
    state = AsyncData(newState);
  }
}
