import 'package:coordinated_page_route/coordinated_page_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bull/src/notifiers/states/auth_notifier_state.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/views/new/home/bar/auth_bar.dart';
import 'package:flutter_bull/src/views/new/auth_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthBarContainer extends ConsumerStatefulWidget {
  const AuthBarContainer({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthBarContainerState();
}

class _AuthBarContainerState extends ConsumerState<AuthBarContainer> with Auth {
  final _navKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    ref.listen(
        authNotifierProvider.select((value) => value.valueOrNull?.authBarState),
        (prev, next) {
      if (next != null) {
          _navKey.currentState?.pushNamed(next.name);
      }
    });

    ref.listen(
        authNotifierProvider.select((value) => value.valueOrNull?.signUp),
        (prev, next) {
      if (next != null) {
        if (next == true) {
          setInfoText('Signing up');
        } else {
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
