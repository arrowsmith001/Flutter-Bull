import 'package:coordinated_page_route/coordinated_page_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bull/src/views/new/notifiers/app/app_event_notifier.dart';
import 'package:flutter_bull/src/views/new/notifiers/app/app_notifier.dart';
import 'package:flutter_bull/src/views/new/notifiers/states/auth_notifier_state.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/views/3_game/2_game_round_view.dart';
import 'package:flutter_bull/src/views/new/notifiers/auth_notifier.dart';
import 'package:flutter_bull/src/views/new/home/buttons/name_form_view.dart';
import 'package:flutter_bull/src/views/new/home/buttons/photo_prompt_view.dart';
import 'package:flutter_bull/src/widgets/common/loading_message.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_button.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_circular_progress_indicator.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_text_box.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'buttons/home_auth_buttons.dart';
import 'buttons/home_game_buttons.dart';
import '../loading.dart';

class HomeMainButtons extends ConsumerStatefulWidget {
  const HomeMainButtons({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _HomeMainButtonsState();
}

class _HomeMainButtonsState extends ConsumerState<HomeMainButtons>
    with MediaDimensions {
  late String initialRoute =
      ref.read(authNotifierProvider).valueOrNull?.authState?.name ??
          AuthState.signedOut.name;

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

        final int prevIndex =
            prev == null ? -1 : AuthState.values.toList().indexOf(prev);
        final int nextIndex = AuthState.values.toList().indexOf(next);

        _navKey.currentState
            ?.pushReplacementNamed(next.name, arguments: nextIndex - prevIndex);
      }
    });

    return Navigator(
      observers: [CoordinatedRouteObserver(), HeroController()],
      key: _navKey,
      initialRoute: initialRoute,
      onGenerateRoute: (settings) {
        final String? name = settings.name;
        final int direction = (settings.arguments as int?) ?? 0;

        Widget? child;

        final padding = EdgeInsets.symmetric(horizontal: width * 0.1);
        switch (settings.name) {
          case 'signedOut':
            return BackwardFadePushRoute((_) => Padding(
                  padding: padding,
                  child: const HomeAuthButtons(),
                ));
          case 'signedInNoPlayerProfile':
            child = LoadingMessage('Creating Player Profile');
          case 'signedInNoName':
            child = const NameFormView();
          case 'signedInNoPic':
            child = const PhotoPromptView();
          case 'signedIn':
            return ForwardPopRoute((_) => Padding(
                  padding: padding,
                  child: const HomeGameButtons(),
                ));
        }
        child ??= ErrorWidget('No route found');

        child = Padding(
          padding: padding,
          child: child,
        );

        if (direction > 0) {
          return ForwardFadePushRoute((_) => child!);
        } else if (direction < 0) {
          return BackwardFadePushRoute((_) => child!);
        } else {
          return PageRouteBuilder(pageBuilder: (_, __, ___) => child!);
        }
      },
    );
  }
}


