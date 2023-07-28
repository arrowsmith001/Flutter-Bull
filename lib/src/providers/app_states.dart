import 'package:flutter_bull/src/model/game_room.dart';
import 'package:flutter_bull/src/model/player.dart';
import 'package:flutter_bull/src/notifiers/auth_notifier.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/notifiers/room_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';


part 'app_states.g.dart';



@Riverpod(keepAlive: true)
String getSignedInPlayerId(Ref ref) => throw UnimplementedError('getSignedInPlayerId');

@Riverpod(keepAlive: true)
String getCurrentGameRoomId(Ref ref) => throw UnimplementedError('getCurrentGameRoomId');


// TODO: Fix annoying wont-navigate-on-occupied-room-update bug
// TODO: Research riverpod architecture
// TODO: ***** Notifier for every view: Capture state FULLY *****
