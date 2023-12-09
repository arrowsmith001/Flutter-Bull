import 'package:flutter_bull/extensions/object.dart';
import 'package:flutter_bull/src/enums/game_phases.dart';
import 'package:flutter_bull/src/model/game_room.dart';
import 'package:flutter_bull/src/notifiers/game_notifier.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/notifiers/view_models/lobby_player.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/providers/game_data.dart';
import 'package:flutter_bull/src/view_models/3_game/1_writing_phase_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'round_data.g.dart';

@Riverpod(keepAlive: false)
PublicPlayer? playerWhoseTurn(Ref ref) {
  final GameRoom? g = game(ref);
  final int progress = ref.watch(getProgressProvider);
  final String? whoseTurnId = g?.playerOrder[progress];
  return whoseTurnId == null ? null : players(ref)?[whoseTurnId];
}
