import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bull/src/custom/extensions/riverpod_extensions.dart';
import 'package:flutter_bull/src/enums/game_phases.dart';
import 'package:flutter_bull/src/mixins/auth_hooks.dart';
import 'package:flutter_bull/src/mixins/game_hooks.dart';
import 'package:flutter_bull/src/notifiers/view_models/game_round_view_notifier.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/style/utter_bull_theme.dart';
import 'package:flutter_bull/src/view_models/3_game/2_game_round_view_model.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_button.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_player_avatar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReaderView extends ConsumerStatefulWidget {
  const ReaderView({super.key});

  @override
  ConsumerState<ReaderView> createState() => _ReaderViewState();
}

class _ReaderViewState extends ConsumerState<ReaderView>
    with  Progress, AuthHooks, GameHooks {

dynamic vm;


  Decoration? decoration;
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      final modalAnim = ModalRoute.of(context)!.animation!;
      modalAnim.addListener(() {
        if (modalAnim.isCompleted) {
          setState(() {
            decoration = UtterBullGlobal.gameViewDecoration;
          });
        }
      });
    });
  }

  Future<void> onRevealStatement() async {
    Navigator.of(context).pushReplacementNamed(RoundPhase.reading.name);
  }

  @override
  Widget build(BuildContext context) {

        Widget avatar = Hero(
            tag: 'avatar',
            child: UtterBullPlayerAvatar(null,  null));//'playerWhoseTurn(fixedProgress).avatarData'));
      
        Widget prompt = Hero(
          tag: 'prompt',
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(16.0)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: AutoSizeText(
                            vm.roleDescriptionStrings.first,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: AutoSizeText(
                            vm.roleDescriptionStrings.last,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
        );
      
        Widget bottomWidget = vm.isMyTurn
            ? UtterBullButton(
                title: 'Reveal Statement',
                onPressed: () => onRevealStatement(),
              )
            : Text('Waiting for ${vm.playerWhoseTurn.player.name}...',
                style: Theme.of(context).textTheme.headlineMedium);
      
      
      return Scaffold(
      
      body: Container(
        decoration: decoration,
        child: Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.75,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: avatar,
              ),
            ),
            Flexible(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: prompt,
              ),
            ),
            Flexible(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: bottomWidget,
              ),
            )
          ],
        )),
      ));
  }
  
}
