import 'dart:math';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:coordinated_page_route/coordinated_page_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bull/src/custom/extensions/riverpod_extensions.dart';
import 'package:flutter_bull/src/views/new/notifiers/states/auth_notifier_state.dart';
import 'package:flutter_bull/src/views/2_main/profile_setup_view.dart';
import 'package:flutter_bull/src/views/new/notifiers/auth_notifier.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/notifiers/signed_in_player_status_notifier.dart';
// ignore: unused_import
import 'package:flutter_bull/src/providers/app_services.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/views/new/home/buttons/name_form_view.dart';
import 'package:flutter_bull/src/views/new/home/auth/sign_up_email_view.dart';
import 'package:flutter_bull/src/views/new/notifiers/camera_notifier.dart';
import 'package:flutter_bull/src/views/new/notifiers/states/camera_notifier_state.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_button.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_player_avatar.dart';
import 'package:flutter_bull/src/widgets/utter_bull_title.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zwidget/zwidget.dart';
import 'package:logger/logger.dart';

import 'camera_view.dart';
import 'home/bar/auth_bar.dart';
import 'home/home_main_buttons.dart';
import 'home/home_view.dart';

class UtterBull extends ConsumerStatefulWidget {
  const UtterBull({super.key});

  @override
  ConsumerState<UtterBull> createState() => _UtterBullState();
}

class _UtterBullState extends ConsumerState<UtterBull> with MediaDimensions {
  // SignedInPlayerStatusNotifier get signedInPlayerNotifier =>
  //     ref.read(signedInPlayerStatusNotifierProvider(userId).notifier);

  void onCreateRoom() async {
    //signedInPlayerNotifier.createRoom();
  }

  void onJoinRoomPressed() async {
    Navigator.of(context).pushNamed('join');
  }

  void onJoinRoom() {
    // signedInPlayerNotifier
    //     .joinRoom(_roomCodeTextEditController.text.trim().toUpperCase());
  }

  final _navKey = GlobalKey<NavigatorState>();

  //OverlayEntry? overlayEntry;

  // _getSignUpRoute(BuildContext context) {
  //   return ;
  // }

  @override
  Widget build(BuildContext context) {
    // final userId = ref.watch(getSignedInPlayerIdProvider);
    // final playerNotifier = signedInPlayerStatusNotifierProvider(userId);

    // final avatarAsync = ref.watch(playerNotifierProvider(userId));
    // final playerAsync = ref.watch(playerNotifier);
/* 
    final userId = ref.watch(getSignedInPlayerIdProvider);
    final player = ref.watch(playerNotifierProvider(userId)).requireValue; */

    ref.listen(
        authNotifierProvider.select((data) => data.valueOrNull?.signUpPage),
        (_, signUpPage) {
      if (signUpPage == true) {
        // showModalBottomSheet(
        //     isScrollControlled: true,
        //     enableDrag: false,
        //     constraints: BoxConstraints(
        //         maxWidth: width * 0.9, maxHeight: height * 0.7),
        //     context: context,
        //     builder: (_) =>
        //         SignUpEmailView()).whenComplete(
        //     () {
        //     });

        _navKey.currentState?.pushNamed(
          'signUp',
        );
      } else {
        _navKey.currentState?.pop();
      }
    });

    ref.listen(
        authNotifierProvider
            .select((data) => data.valueOrNull?.profilePhotoExists), (_, next) {
      // if (next == false) {
      //   overlayEntry = OverlayEntry(
      //     builder: (context) {
      //       return Stack(
      //         children: [
      //           Positioned.fromRect(
      //               rect: Rect.fromLTWH(
      //                   width / 2, height * 0.1, width / 2, height * 0.2),
      //               child: Container(
      //                 color: Colors.green,
      //               ))
      //         ],
      //       );
      //     },
      //   );
      //   _navKey.currentState?.overlay?.insert(overlayEntry!);
      // } else {
      //   if (next == true) {
      //     overlayEntry?.remove();
      //   }
      // }
    });

    ref.listen(
        cameraNotifierProvider
            .select((value) => value.valueOrNull?.cameraState), (prev, next) {

      if (next == CameraState.open) {
        _navKey.currentState?.pushNamed('camera');
      } else if (next == CameraState.closed) {
        _navKey.currentState?.pop();
      }
    });

    // ref.listen(
    //     authNotifierProvider.select((data) => data.requireValue.authState),
    //     (_, authState) {
    //   if (authState == AuthState.signedInNoName) {
    //     _navKey.currentState?.pushNamed(authState!.name);
    //   }
    // });

    return Scaffold(
      body: Center(
        child: Navigator(
            key: _navKey,
            observers: [CoordinatedRouteObserver(), HeroController()],
            onGenerateRoute: (settings) {
              switch (settings.name) {
                case 'signUp':
                  return PageRouteBuilder(
                      transitionDuration: Duration(milliseconds: 750),
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return SlideTransition(
                            position: CurvedAnimation(
                                    parent: animation, curve: Curves.easeInOut)
                                .drive(Tween(
                                    begin: Offset(0, 1), end: Offset.zero)),
                            child: SignUpEmailView());
                      });

                case 'camera':
                  return PageRouteBuilder(
                      transitionDuration: Duration(milliseconds: 750),
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return SlideTransition(
                            position: CurvedAnimation(
                                    parent: animation, curve: Curves.easeInOut)
                                .drive(Tween(
                                    begin: Offset(0, 1), end: Offset.zero)),
                            child: CameraView());
                      });
              }
              return PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      HomeView());
            }),
      ),
    );
  }

  // Widget _buildSignOutButton() {
  //   // return TextButton(
  //   //     onPressed: () => authNotifier.signOut(), child: const Text('Sign out'));
  // }

  Widget _buildPlayerAvatar(AsyncValue<PublicPlayer> avatarAsync) {
    return SizedBox(
      height: 250,
      child: avatarAsync.whenDefault((avatar) {
        final data = avatar.avatarData;
        return Hero(
            tag: 'avatar',
            child: GestureDetector(
                onTap: () =>
                    Navigator.of(context).pushReplacementNamed('avatar'),
                child: UtterBullPlayerAvatar(null, data!)));
      }),
    );
  }
}
