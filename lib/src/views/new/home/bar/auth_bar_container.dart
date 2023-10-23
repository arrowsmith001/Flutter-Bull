import 'package:coordinated_page_route/coordinated_page_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bull/src/views/new/notifiers/camera_notifier.dart';
import 'package:flutter_bull/src/views/new/notifiers/states/auth_notifier_state.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/views/new/home/bar/auth_bar.dart';
import 'package:flutter_bull/src/views/new/notifiers/auth_notifier.dart';
import 'package:flutter_bull/src/views/new/notifiers/states/camera_notifier_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class AuthBarContainer extends ConsumerStatefulWidget {
  const AuthBarContainer({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AuthBarContainerState();
}

class _AuthBarContainerState extends ConsumerState<AuthBarContainer> with Auth {
  final _navKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    ref.listen(
        authNotifierProvider.select((value) => value.valueOrNull?.signUpPage),
        (prev, next) {
          if (next == true) {
        _navKey.currentState?.pushReplacementNamed('hide');
      } else if (next == false) {
        _navKey.currentState?.pushReplacementNamed('show');
      }
    });

    ref.listen(
        cameraNotifierProvider
            .select((value) => value.valueOrNull?.cameraState), (prev, next) {
      if (next == CameraState.ready) {
        _navKey.currentState?.pushReplacementNamed('hide');
      } else if (next == CameraState.closed) {
        _navKey.currentState?.pushReplacementNamed('show');
      }
    });

    ref.listen(
        authNotifierProvider
            .select((value) => value.valueOrNull?.occupiedRoomId), (prev, next) {
      if (next != null) {
        _navKey.currentState?.pushReplacementNamed('hide');
      } else if (prev != null && next == null) {
        _navKey.currentState?.pushReplacementNamed('show');
      }
    });


    return Navigator(
      clipBehavior: Clip.none,
      key: _navKey,
      observers: [CoordinatedRouteObserver()],
      initialRoute: AuthBarState.show.name,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case 'hide':
            return UpwardPushRoute((context) => SizedBox.shrink());
          case 'show':
            return DownwardPushRoute((context) => AuthBar());
        }
      },
    );
  }

  void setInfoText(String infoText) {
    if (mounted)
      setState(() {
        //this.infoText = infoText;
      });
  }
}
