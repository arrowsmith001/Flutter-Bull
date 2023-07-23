import 'package:flutter_bull/src/model/game_room.dart';
import 'package:flutter_bull/src/model/player.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';


part 'app_states.g.dart';

@Riverpod(keepAlive: true)
Player getCurrentPlayer(Ref ref) => throw UnimplementedError();

@Riverpod(keepAlive: true)
GameRoom getCurrentGameRoom(Ref ref) => throw UnimplementedError();
