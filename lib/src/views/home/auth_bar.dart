import 'package:coordinated_page_route/coordinated_page_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bull/src/views/home/auth_notifier.dart';
import 'package:flutter_bull/src/notifiers/states/auth_notifier_state.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/views/home/utter_bull.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_circular_progress_indicator.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_player_avatar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthBar extends ConsumerStatefulWidget {
  const AuthBar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthBarState();
}

class _AuthBarState extends ConsumerState<AuthBar> with Auth {
  final _navKey = GlobalKey<NavigatorState>();


  @override
  Widget build(BuildContext context) {

    ref.listen(
        authNotifierProvider.select((value) => value.valueOrNull?.signUpPage),
        (prev, next) {
      if (next != null) {
        if (next == true) {
          _navKey.currentState?.pushNamed('signUpEmail');
        } else {
          _navKey.currentState?.pushNamed('');
        }
      }
    });

    ref.listen(
        authNotifierProvider.select((value) => value.valueOrNull?.signUp),
        (prev, next) {
      if (next != null) {
        if (next == true) {
          setInfoText('Signing up');
        }
        else
        {
          setInfoText('Signing up');
        }
      }
    });

    ref.listen(
        authNotifierProvider.select((value) => value.valueOrNull?.userId),
        (prev, next) {
      if (next != null) {
        setInfoText('Hi $next');
      } else
        setInfoText('Not signed in');
    });

    return Navigator(
      key: _navKey,
      observers: [CoordinatedRouteObserver()],
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case 'signUpEmail':
            return UpwardPushRoute((context) => SizedBox.shrink());
        }

        return DownwardPushRoute((context) => Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).primaryColorDark
                  ])),
              child: ref.watch(authNotifierProvider).when(

                data: (AuthNotifierState state) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Spacer(),
                      Expanded(child: Text(state.userId.toString())),
                      Expanded(child: Text(state.toString())),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: UtterBullPlayerAvatar(null, null),
                      ))
                    ],
                  );
                },
                loading: () =>
                    UtterBullCircularProgressIndicator(size: Size(100, 100)),
                error: (e, st) => ErrorWidget(e),
              ),
            ));
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
