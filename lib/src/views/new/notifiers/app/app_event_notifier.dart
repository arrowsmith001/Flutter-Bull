import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bull/src/custom/data/abstract/auth_service.dart';
import 'package:flutter_bull/src/views/new/notifiers/app/app_event_notifier.dart';
import 'package:flutter_bull/src/views/new/notifiers/app/app_events.dart';
import 'package:flutter_bull/src/views/new/notifiers/app/app_notifier.dart';
import 'package:flutter_bull/src/views/new/notifiers/app/app_state.dart';
import 'package:flutter_bull/src/views/new/notifiers/states/auth_notifier_state.dart';
import 'package:flutter_bull/src/providers/app_services.dart';
import 'package:flutter_bull/src/services/data_layer.dart';
import 'package:flutter_bull/src/services/data_stream_service.dart';
import 'package:flutter_bull/src/style/utter_bull_theme.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:logger/logger.dart';

part 'app_event_notifier.g.dart';

@Riverpod(keepAlive: true)
class AppEventNotifier extends _$AppEventNotifier {
  @override
  Stream<AppEvents> build() async* {

    ref.listen(
        appNotifierProvider.select((value) => value.valueOrNull?.authBarState),
        (_, next) {
          setData(AppEvents(newAuthBarState: next));
        });

    ref.listen(
        appNotifierProvider.select((value) => value.valueOrNull?.signUpPageState),
        (_, next) {
          setData(AppEvents(newSignUpPageState: next));
        });

    ref.listen(
        appNotifierProvider.select((value) => value.valueOrNull?.cameraViewState),
        (_, next) {
          setData(AppEvents(newCameraViewState: next));
        });

    ref.listen(
        appNotifierProvider.select((value) => value.valueOrNull?.nowBusy),
        (prev, next) {
          setData(AppEvents(newBusy: next));
        });

    ref.listen(
        appNotifierProvider.select((value) => value.valueOrNull?.nowNotBusy),
        (prev, next) {
          Logger().d('nowNotBusy changed from $prev to $next');
          setData(AppEvents(newNotBusy: next));
        });

    yield AppEvents();
  }

  // void addSignUpPageEvent(SignUpPageState state) {
  //   setData(AppEvents(newSignUpPageState: state));
  // }

  // void addAuthBarEvent(AuthBarState state) {
  //   setData(AppEvents(newAuthBarState: state));
  // }

  // void addBusyEvent(Busy busy) {
  //   setData(AppEvents(newBusy: busy));
  // }

  // void addCameraViewEvent(CameraViewState state) {
  //   setData(AppEvents(newCameraViewState: state));
  // }

  // void addNotBusyEvent(Busy notBusy) {
  //   setData(AppEvents(newNotBusy: notBusy));
  // }

  void setData(AppEvents newState) {
    Logger().d('setting new AppEvents: $newState');
    state = AsyncData(newState);
  }
}

enum HomePageState { home, creatingRoom, joiningRoom }
