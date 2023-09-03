import 'package:flutter/material.dart';
import 'package:flutter_bull/src/custom/extensions/riverpod_extensions.dart';
import 'package:flutter_bull/src/notifiers/view_models/result_view_notifier.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResultView extends ConsumerStatefulWidget {
  const ResultView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ResultViewViewState();
}

class _ResultViewViewState extends ConsumerState<ResultView>
    with RoomID, UserID {

  @override
  Widget build(BuildContext context) {
    final vmProvider = resultViewNotifierProvider(roomId, userId);
    final vmAsync = ref.watch(vmProvider);

    return Scaffold(body: vmAsync.whenDefault((vm) {

      return Text(vm.playerBreakdown.toString());
    }));
  }
  
}

// TODO: Display results
// TODO: Figure out what ResultView/ResultViewModel needs
// TODO: Separate gameRoomData??
