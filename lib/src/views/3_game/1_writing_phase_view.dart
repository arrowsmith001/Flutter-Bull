import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bull/src/custom/extensions/riverpod_extensions.dart';
import 'package:flutter_bull/src/notifiers/game_notifier.dart';
import 'package:flutter_bull/src/notifiers/view_models/writing_phase_view_notifier.dart';
import 'package:flutter_bull/src/providers/app_services.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/services/game_server.dart';
import 'package:flutter_bull/src/widgets/utter_bull_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class WritingPhaseView extends ConsumerStatefulWidget {
  const WritingPhaseView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _WritingPhaseViewState();
}

class _WritingPhaseViewState extends ConsumerState<WritingPhaseView> with RoomID, UserID {
  UtterBullServer get _getServer => ref.read(utterBullServerProvider);
  TextEditingController _submissionController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    
    final vmProvider =
        writingPhaseViewNotifierProvider(roomId, userId);
    final vmAsync = ref.watch(vmProvider);

    return Scaffold(
      body: vmAsync.whenDefault((vm) {
  
        return Center(
          child: Column(
        children: [
          Flexible(
            child: Text(vm.writingPromptString),
          ),
          Flexible(child: TextField(controller: _submissionController)),
          Flexible(
            child: PlaceholderButton(
                onPressed: () {
                  _getServer.submitText(
                      roomId, userId, _submissionController.text);
                },
                title: 'Submit Text'),
          )
        ],
      ),
        );
      }),
    );

  }
}
