import 'dart:async';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:coordinated_page_route/coordinated_page_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bull/src/custom/extensions/riverpod_extensions.dart';
import 'package:flutter_bull/src/custom/widgets/rounded_border.dart';
import 'package:flutter_bull/src/style/utter_bull_theme.dart';
import 'package:flutter_bull/src/views/2_main/game_view.dart';
import 'package:flutter_bull/src/views/2_main/join_game_view.dart';
import 'package:flutter_bull/src/views/3_game/2_game_round_view.dart';
import 'package:flutter_bull/src/views/new/home/bar/auth_bar_container.dart';
import 'package:flutter_bull/src/views/new/notification_center.dart';
import 'package:flutter_bull/src/views/new/notifiers/notification_notifier.dart';
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
import 'package:flutter_bull/src/views/new/notifiers/states/notification_notifier_state.dart'
    as notifs;
import 'package:http/http.dart';
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

class _UtterBullState extends ConsumerState<UtterBull>
    with MediaDimensions, UserID {
  String errorText = '';

  // SignedInPlayerStatusNotifier get signedInPlayerNotifier =>
  //     ref.read(signedInPlayerStatusNotifierProvider(userId).notifier);

  // late final _animController =
  //     AnimationController(vsync: this, duration: Duration(milliseconds: 500));

  void onCreateRoom() async {
    //signedInPlayerNotifier.createRoom();
    final String? userId = ref.read(authNotifierProvider).valueOrNull?.userId;
    if (userId == null) {
      Logger().e('Error: userId null when creating room');
    } else {
      setState(() {
        creatingRoom = true;
      });

      try {
        await ref.read(authNotifierProvider.notifier).createRoom(userId);
      } catch (e) {
        ref
            .read(authNotifierProvider.notifier)
            .pushError('Something went wrong: $e');
      } finally {
        setState(() {
          creatingRoom = false;
        });
      }
    }
  }

  bool creatingRoom = false;

  void onJoinRoomPressed() async {}

  void onJoinRoom() {
    // signedInPlayerNotifier
    //     .joinRoom(_roomCodeTextEditController.text.trim().toUpperCase());
  }

  final _outerNavKey = GlobalKey<NavigatorState>();
  final _innerNavKey = GlobalKey<NavigatorState>();

  //OverlayEntry? overlayEntry;

  // _getSignUpRoute(BuildContext context) {
  //   return ;
  // }

  bool isAuthBarShowing = true;

  @override
  Widget build(BuildContext context) {
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

        _innerNavKey.currentState?.pushNamed('signUp');
      }
      // else {
      //   _innerNavKey.currentState?.pop();
      // }
    });

    ref.listen(
        cameraNotifierProvider
            .select((value) => value.valueOrNull?.cameraState), (prev, next) {
      if (next == CameraState.open) {
        _innerNavKey.currentState?.pushNamed('camera');
        _toggleAuthBar(AuthBarState.hide);
      } else if (next == CameraState.closed) {
        _innerNavKey.currentState?.pop();
        _toggleAuthBar(AuthBarState.show);
      }
    });

    ref.listen(
        authNotifierProvider
            .select((data) => data.valueOrNull?.profilePhotoExists),
        (_, next) {});

    ref.listen(
        authNotifierProvider.select((data) => data.valueOrNull?.occupiedRoomId),
        (prev, next) {
      if (next != null) {
        _outerNavKey.currentState?.pushReplacementNamed('game/$next');
        _toggleAuthBar(AuthBarState.hide);
      } else if (prev != null && next == null) {
        _outerNavKey.currentState?.pushReplacementNamed('/');
        _toggleAuthBar(AuthBarState.show);
      }
    });

    ref.listen(
        authNotifierProvider.select((data) => data.requireValue.authBarState),
        (_, authState) {
      _toggleAuthBar(authState);
    });

    ref.listen(
        authNotifierProvider.select((data) => data.requireValue.signUpPage),
        (_, signUpPage) {
      if (signUpPage != null)
        _toggleAuthBar(signUpPage ? AuthBarState.hide : AuthBarState.show);
    });

    ref.listen(authNotifierProvider.select((data) => data.requireValue.error),
        (_, error) {
      if (error != null) {
        setState(() {
          errorText = error.message;
        });
      }
    });

    // ref.listen(
    //     authNotifierProvider.select((data) => data.requireValue.authBarState),
    //     (_, authState) {
    //   if (authState == AuthBarState.signedInNoName) {
    //     _navKey.currentState?.pushNamed(authState!.name);
    //   }
    // });

    final authBarTopPadding = MediaQuery.of(context).viewPadding.top;
    final authBarHeight = (height * 0.1) + authBarTopPadding;

    return WillPopScope(
      onWillPop: () async {
        if (_innerNavKey.currentState?.canPop() ?? false) {
          Logger().d('inner CAN pop');
          ref
              .read(authNotifierProvider.notifier)
              .onExitSignUpPage(); // TODO: Needs to be way more general
          return false;
        } else {
          Logger().d('inner CANNOT pop');
          return true;
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          alignment: Alignment.center,
          children: [
            Positioned.fill(
                child: Navigator(
              observers: [CoordinatedRouteObserver()],
              key: _outerNavKey,
              initialRoute: '/',
              onGenerateRoute: (settings) {
                if (settings.name == '/') {
                  return BackwardFadePushRoute((_) => WillPopScope(
                      onWillPop: () async {
                        Logger().d('HomeNavigator will pop');
                        return true;
                      },
                      child: HomeNavigator(navKey: _innerNavKey)));
                } else if (settings.name!.contains('game')) {
                  final roomId = settings.name!.split('/').last;
                  return ForwardFadePushRoute((_) => ProviderScope(overrides: [
                        getCurrentGameRoomIdProvider.overrideWithValue(roomId)
                      ], child: GameView()));
                }
              },
            )),
            Positioned(
              top: 0,
              child: AnimatedSwitcher(
                transitionBuilder: (child, animation) {
                  return AnimatedBuilder(
                    builder: (context, child) {
                      return Transform.translate(
                        offset:
                            Offset(0, -authBarHeight * (1 - animation.value)),
                        child: child,
                      );
                    },
                    child: child,
                    animation: animation,
                  );
                },
                duration: const Duration(milliseconds: 300),
                child: isAuthBarShowing
                    ? SizedBox.fromSize(
                        key: ValueKey(userId),
                        size: Size(width, authBarHeight),
                        child: AuthBar(
                            innerPadding:
                                EdgeInsets.only(top: authBarTopPadding)))
                    : SizedBox.shrink(key: ValueKey(0)),
              ),
            ),
            AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                top: height * 0.1 * (isAuthBarShowing ? 1 : 0.5),
                right: 0,
                height: height * 0.5,
                width: width * 0.7,
                child: FadingListNotificationCenter(
                    blockIf: () =>
                        ref.read(authNotifierProvider).valueOrNull?.route !=
                        '/')),
          ],
        ),
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

  void hideAuthBar() {
    _toggleAuthBar(AuthBarState.hide);
  }

  void showAuthBar() {
    _toggleAuthBar(AuthBarState.show);
  }

  void _toggleAuthBar(AuthBarState? authState) {
    if (authState == null) return;
    if (authState == AuthBarState.hide) {
      setState(() {
        isAuthBarShowing = false;
      });
    } else if (authState == AuthBarState.show) {
      setState(() {
        isAuthBarShowing = true;
      });
    }
  }
}

class HomeNavigator extends ConsumerWidget {
  HomeNavigator({required this.navKey});

  final GlobalKey<NavigatorState> navKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Navigator(
      observers: [CoordinatedRouteObserver(), HeroController()],
      key: navKey,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    HomeView());
          case 'signUp':
            return PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 750),
                pageBuilder: (context, animation, secondaryAnimation) {
                  return SlideTransition(
                      position: CurvedAnimation(
                              parent: animation, curve: Curves.easeInOut)
                          .drive(Tween(begin: Offset(0, 1), end: Offset.zero)),
                      child: Stack(children: [
                        GestureDetector(
                          onTap: () => ref
                              .read(authNotifierProvider.notifier)
                              .closeSignUpPage(),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 24.0, right: 24.0, top: 100.0),
                          child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(24.0),
                                  topRight: Radius.circular(24.0)),
                              child: SignUpEmailView()),
                        )
                      ]));
                });

          case 'camera':
            return PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 750),
                pageBuilder: (context, animation, secondaryAnimation) {
                  return SlideTransition(
                      position: CurvedAnimation(
                              parent: animation, curve: Curves.easeInOut)
                          .drive(Tween(begin: Offset(0, 1), end: Offset.zero)),
                      child: CameraView());
                });
        }
      },
    );
  }
}
