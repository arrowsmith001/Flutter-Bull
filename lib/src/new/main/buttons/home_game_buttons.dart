import 'package:coordinated_page_route/coordinated_page_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/new/main/buttons/join_game_view.dart';
import 'package:flutter_bull/src/new/notifiers/misc/auth_notifier.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeGameButtons extends ConsumerStatefulWidget {
  const HomeGameButtons({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _HomeGameButtonsState();
}

class _HomeGameButtonsState extends ConsumerState<HomeGameButtons> with UserID {
  void onJoinRoomPressed() {
    Navigator.of(context).push(ForwardFadePushRoute((_) => const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: JoinGameView(),
        )));
  }

  void onCreateRoomPressed() {
    ref.read(authNotifierProvider.notifier).createRoom(userId!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
            child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: UtterBullButton(
              isShimmering: false,
              onPressed: onCreateRoomPressed,
              title: 'Create Game'),
        )),
        Flexible(
            child: Padding(
          padding: const EdgeInsets.all(4.0),
          child:
              UtterBullButton(onPressed: onJoinRoomPressed, title: 'Join Game'),
        )),
      ],
    );
  }
}
