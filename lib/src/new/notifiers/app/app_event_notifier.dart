import 'dart:async';

import 'package:flutter_bull/src/new/notifiers/app/app_events.dart';
import 'package:flutter_bull/src/new/notifiers/app/app_state_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:logger/logger.dart';

part 'app_event_notifier.g.dart';

@Riverpod(keepAlive: true)
class AppEventNotifier extends _$AppEventNotifier {
  @override
  Stream<AppEvents> build() async* {

    ref.listen(
        appStateNotifierProvider.select((value) => value.valueOrNull?.authBarState),
        (_, next) {
          setData(AppEvents(newAuthBarState: next));
        });

    ref.listen(
        appStateNotifierProvider.select((value) => value.valueOrNull?.signUpPageState),
        (_, next) {
          setData(AppEvents(newSignUpPageState: next));
        });

    ref.listen(
        appStateNotifierProvider.select((value) => value.valueOrNull?.cameraViewState),
        (_, next) {
          setData(AppEvents(newCameraViewState: next));
        });

    ref.listen(
        appStateNotifierProvider.select((value) => value.valueOrNull?.nowBusy),
        (prev, next) {
          setData(AppEvents(newBusy: next));
        });

    ref.listen(
        appStateNotifierProvider.select((value) => value.valueOrNull?.nowNotBusy),
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
