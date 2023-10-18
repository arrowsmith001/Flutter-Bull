import 'package:coordinated_page_route/coordinated_page_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bull/src/notifiers/states/auth_notifier_state.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/views/3_game/2_game_round_view.dart';
import 'package:flutter_bull/src/views/new/auth_notifier.dart';
import 'package:flutter_bull/src/views/new/home/buttons/name_form_view.dart';
import 'package:flutter_bull/src/views/new/home/buttons/photo_prompt_view.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_button.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_circular_progress_indicator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'buttons/home_auth_buttons.dart';
import 'buttons/home_signed_in_buttons.dart';
import '../loading.dart';

class HomeMainButtons extends ConsumerStatefulWidget {
  const HomeMainButtons({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _HomeMainButtonsState();
}

class _HomeMainButtonsState extends ConsumerState<HomeMainButtons>
    with MediaDimensions {
  final _navKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    ref.listen(
        authNotifierProvider.select((value) => value.valueOrNull?.authState),
        (prev, next) {
      if (next != null) {

        // // Only prompt for photo when first signing up
        // if (next == AuthState.signedInNoPic) {
        //   if(prev == AuthState.signedInNoName)
        //   {

        //   }
        // }

        _navKey.currentState?.pushNamed(next.name);
      }
    });

    return Center(
        child: Navigator(
      observers: [CoordinatedRouteObserver()],
      key: _navKey,
      initialRoute: 'signedOut',
      onGenerateRoute: (settings) {
        Widget? child;
        final padding = EdgeInsets.symmetric(horizontal: width * 0.1);
        switch (settings.name) {
          case 'signedOut':
            return BackwardPushFadeInRoute((_) => Padding(
                  padding: padding,
                  child: HomeAuthButtons(),
                ));
          case 'signedInNoPlayerProfile':
            child = Loading(
              dim: width * 0.4,
            );
          case 'signedInNoName':
            child = NameFormView();
          case 'signedInNoPic':
            child = PhotoPromptView();
          case 'signedIn':
            return ForwardPopRoute((_) => Padding(
                  padding: padding,
                  child: HomeSignedInButtons(),
                ));
        }
        child ??= ErrorWidget('No route found');

        return ForwardPushFadeInRoute((_) => Padding(
              padding: padding,
              child: child!,
            ));
      },
    ));
  }
}
