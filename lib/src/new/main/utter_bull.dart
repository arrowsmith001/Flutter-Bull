import 'dart:async';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:coordinated_page_route/coordinated_page_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bull/src/custom/extensions/riverpod_extensions.dart';
import 'package:flutter_bull/src/custom/widgets/rounded_border.dart';
import 'package:flutter_bull/src/mixins/app_hooks.dart';
import 'package:flutter_bull/src/style/utter_bull_theme.dart';
import 'package:flutter_bull/src/new/notifiers/game/game_view.dart';
import 'package:flutter_bull/src/new/main/buttons/join_game_view.dart';
import 'package:flutter_bull/src/views/3_game/2_game_round_view.dart';
import 'package:flutter_bull/src/widgets/notifications/notification_view.dart';
import 'package:flutter_bull/src/new/notifiers/app/app_event_notifier.dart';
import 'package:flutter_bull/src/new/notifiers/misc/notification_notifier.dart';
import 'package:flutter_bull/src/new/notifiers/app/app_state_notifier.dart';
import 'package:flutter_bull/src/new/notifiers/app/app_state.dart';
import 'package:flutter_bull/src/new/notifiers/states/auth_notifier_state.dart';
import 'package:flutter_bull/src/views/2_main/profile_setup_view.dart';
import 'package:flutter_bull/src/new/notifiers/misc/auth_notifier.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/notifiers/signed_in_player_status_notifier.dart';
// ignore: unused_import
import 'package:flutter_bull/src/providers/app_services.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/new/main/buttons/name_form_view.dart';
import 'package:flutter_bull/src/new/main/auth/sign_up_email_view.dart';
import 'package:flutter_bull/src/new/notifiers/misc/camera_notifier.dart';
import 'package:flutter_bull/src/new/notifiers/states/camera_notifier_state.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_button.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_player_avatar.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_text_box.dart';
import 'package:flutter_bull/src/widgets/unique/utter_bull_title.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_bull/src/new/notifiers/states/notification_notifier_state.dart'
    as notifs;
import 'package:http/http.dart';
import 'package:zwidget/zwidget.dart';
import 'package:logger/logger.dart';

import '../../mixins/auth_hooks.dart';
import '../../widgets/notifications/fading_list_notification_center.dart';
import 'camera_view.dart';
import 'auth_bar.dart';
import 'home/home_buttons.dart';
import 'home/home_view.dart';
import 'main_navigator.dart';

class UtterBull extends ConsumerStatefulWidget {
  const UtterBull({super.key});

  @override
  ConsumerState<UtterBull> createState() => _UtterBullState();
}

class _UtterBullState extends ConsumerState<UtterBull>
    with MediaDimensions, AuthHooks, AppHooks {
  bool get isAuthBarShowing =>
      isSignedIn &&
      !(isOnSignUpPage ||
          isOnCameraPage ||
          isCreatingRoom ||
          isJoiningRoom ||
          isInGame);

  @override
  Widget build(BuildContext context) {
    
    final authBarTopPadding = MediaQuery.of(context).viewPadding.top;
    final authBarHeight = (height * 0.1) + authBarTopPadding;

    final Widget authBarSwitcher = AnimatedSwitcher(
      transitionBuilder: (child, animation) {
        return AnimatedBuilder(
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, -authBarHeight * (1 - animation.value)),
              child: child,
            );
          },
          animation: animation,
          child: child,
        );
      },
      duration: const Duration(milliseconds: 300),
      child: isAuthBarShowing
          ? SizedBox.fromSize(
              key: ValueKey(userId),
              size: Size(width, authBarHeight),
              child: AuthBar(
                  innerPadding: EdgeInsets.only(top: authBarTopPadding)))
          : const SizedBox.shrink(key: ValueKey(0)),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: MainNavigator()),
          Positioned(top: 0,
            child: authBarSwitcher,
          ),
          AnimatedPositioned.fromRect(
              duration: const Duration(milliseconds: 300),
              rect: Rect.fromLTWH(
                  width * 0.3,
                  height * 0.1 * (isAuthBarShowing ? 1 : 0.5),
                  width * 0.7,
                  height * 0.5),
              child: FadingListNotificationCenter(
                  blockIf: () => false 
                  )),
        ],
      ),
    );
  }

}
