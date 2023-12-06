import 'package:flutter_bull/src/notifiers/game_notifier.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/notifiers/states/game_notifier_state.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/utils/game_data_functions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

mixin RoundHooks<T extends ConsumerStatefulWidget> on ConsumerState<T> {

  late final int progress = ref.watch(getProgressProvider);
  late final String userId = ref.watch(getSignedInPlayerIdProvider);
  late final String gameId = ref.watch(getCurrentGameRoomIdProvider);

  late final String? whoseTurnId = _watchThen((game) => game.gameRoom.playerOrder[progress]);

  late final String? playerWhoseTurnStatement = _watchThen((game) => game.gameRoom.texts[whoseTurnId]);

  late final List<String> playersLeftToPlay = _watchThen((game) => GameDataFunctions
    .getShuffledIds(game.gameRoom)
    .where((id) => (progress - 1) < game.gameRoom.playerOrder.indexOf(id))
    .toList()) ?? [];

late final int timeToReadOut = _watchThen((game) => GameDataFunctions.calculateTimeToReadOut(game.gameRoom.texts[whoseTurnId])) ?? 0;

  late final List<String> roleDescriptionStrings = _watchThen((game) => GameDataFunctions.getRoleDescriptionStrings(game.gameRoom, game.players, userId, progress)) ?? [];

  late final bool isMyTurn = _watchThen((game) => game.gameRoom.playerOrder[progress] == userId) ?? false;
  late final PublicPlayer? playerWhoseTurn = _watchThen((game) => game.players[game.gameRoom.playerOrder[progress]]);
  
  R? _watchThen<R>(R? Function(GameNotifierState game) transform) =>
      ref.watch(gameNotifierProvider(gameId).select((value) =>
          value.valueOrNull == null ? null : transform(value.valueOrNull!)));
}
