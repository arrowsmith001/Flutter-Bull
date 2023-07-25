import 'package:flutter_bull/src/model/game_room.dart';
import 'package:flutter_bull/src/model/player.dart';
import 'package:flutter_bull/src/notifiers/auth_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';


part 'app_states.g.dart';

@Riverpod(keepAlive: true)
String getSignedInPlayerId(Ref ref) => throw UnimplementedError();

@Riverpod(keepAlive: true)
String getSignedInPlayerName(Ref ref) => throw UnimplementedError();

@Riverpod(keepAlive: true)
String getCurrentGameRoom(Ref ref) => throw UnimplementedError();
