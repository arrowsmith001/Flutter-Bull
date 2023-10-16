import 'dart:math';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:coordinated_page_route/coordinated_page_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bull/src/custom/extensions/riverpod_extensions.dart';
import 'package:flutter_bull/src/notifiers/auth_notifier.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/notifiers/signed_in_player_status_notifier.dart';
// ignore: unused_import
import 'package:flutter_bull/src/providers/app_services.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/views/1_auth/sign_up_email_view.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_button.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_player_avatar.dart';
import 'package:flutter_bull/src/widgets/utter_bull_title.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zwidget/zwidget.dart';
import 'package:logger/logger.dart';

import 'auth_bar.dart';
import 'home_main_buttons.dart';

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

  @override
  Widget build(BuildContext context) {
    // final userId = ref.watch(getSignedInPlayerIdProvider);
    // final playerNotifier = signedInPlayerStatusNotifierProvider(userId);

    // final avatarAsync = ref.watch(playerNotifierProvider(userId));
    // final playerAsync = ref.watch(playerNotifier);
/* 
    final userId = ref.watch(getSignedInPlayerIdProvider);
    final player = ref.watch(playerNotifierProvider(userId)).requireValue; */


    ref.listen(authNotifierProvider.select((data) => data.requireValue.signUpEvent), (_, signUpEvent) {
      if(signUpEvent == true)
      {
        _navKey.currentState?.pushNamed('signUp');
      }
    });

    return Scaffold(
      body: Center(
        child: Navigator(
          key: _navKey,
            observers: [CoordinatedRouteObserver(), HeroController()],
            onGenerateRoute: (settings) {
              switch (settings.name) {
                case 'signUp':
                  return PageRouteBuilder(
                    transitionDuration: Duration(seconds: 1),
                      pageBuilder: (context, animation, secondaryAnimation) {
                    return SlideTransition(
                      
                        position: CurvedAnimation(parent: animation, curve: Curves.easeInOut).drive(
                            Tween(begin: Offset(0, 1), end: Offset.zero)),
                        child: SignUpEmailView());
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

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> with MediaDimensions {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(child: SizedBox.fromSize(size: Size(width, height * 0.1), child: AuthBar())),
        Expanded(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: UtterBullTitle(),
        )),
        Expanded(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: width * 0.1),
            child: Center(child: 
            HomeMainButtons()),
          ),
        )
      ],
    );
  }
}
