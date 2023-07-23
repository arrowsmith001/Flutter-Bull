import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bull/firebase_options.dart';
import 'package:flutter_bull/src/custom/data/abstract/repository.dart';
import 'package:flutter_bull/src/custom/widgets/row_of_n.dart';
import 'package:flutter_bull/src/custom/data/abstract/auth_service.dart';
import 'package:flutter_bull/src/model/game_room.dart';
import 'package:flutter_bull/src/model/player.dart';
import 'package:flutter_bull/src/providers/app_services.dart';
import 'package:flutter_bull/src/services/data_layer.dart';
import 'package:flutter_bull/src/services/data_stream_service.dart';
import 'package:flutter_bull/src/services/game_server.dart';
import 'package:flutter_bull/src/views/utter_bull_container.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stack_trace/stack_trace.dart';

import 'src/custom/data/implemented/firebase.dart';

void main() async {
  // TODO: Generalize init

  FlutterError.demangleStackTrace = (StackTrace stack) {
    if (stack is Trace) return stack.vmTrace;
    if (stack is Chain) return stack.toTrace().vmTrace;
    return stack;
  };

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

// TODO: Figure out TDD
// TODO: Containerize

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildMultipleInstances(4);
    //return _buildInstance();
  }

  // Fake auth, Fake server, Real database, Real streams
  Widget _buildMultipleInstances(int numberOfInstances) {

    final userIds = List.generate(numberOfInstances, (i) => 'user_$i');
    final authMap = <String, AuthService>{};
    for (var userId in userIds) 
    {
      authMap.addAll({userId: FakeAuthService(userId)});
    }

    final commonData = DatabaseDrivenDataLayer(
      gameRoomRepo: Repository<GameRoom>(
          FirebaseDatabaseService('rooms', GameRoom.fromJson)),
      playerRepo: Repository<Player>(
          FirebaseDatabaseService('players', Player.fromJson)),
    );

    final commonStreams = FirebaseDataStreamService();
    final commonServer = UtterBullClientSideServer(commonData,
        authMap.values.toList(), FiveDigit3Alpha2NumericCodeGenerator());

/*     for (var userId in userIds) {
      final auth = authMap[userId]!;
      auth.addListener(() {
        commonServer.onUserAuthStateChanged(auth.getUserId);
      });
    } */

    return WidgetsApp(
        color: Colors.transparent,
        builder: (_, __) {
          return RowOfN<String>(
            length: numberOfInstances,
            data: userIds,
            transform: (_, userId) => ProvisionedUtterBullApp(
              authService:
                  //FirebaseAuthService(),
                  authMap[userId],
              server: commonServer,
              streamService: commonStreams,
            ),
          );
        });
  }

  Widget _buildInstance() {
    final auth = FirebaseAuthService();

    final data = DatabaseDrivenDataLayer(
      gameRoomRepo: Repository<GameRoom>(
          FirebaseDatabaseService('rooms', GameRoom.fromJson)),
      playerRepo: Repository<Player>(
          FirebaseDatabaseService('players', Player.fromJson)),
    );

    final server = UtterBullClientSideServer(
        data, [auth], FiveDigit3Alpha2NumericCodeGenerator());

    final streams = FirebaseDataStreamService();

    return ProvisionedUtterBullApp(
        authService: auth, server: server, streamService: streams);
  }
}

class ProvisionedUtterBullApp extends StatelessWidget {
  final AuthService? authService;
  final UtterBullServer? server;
  final DataStreamService? streamService;

  const ProvisionedUtterBullApp(
      {this.authService, this.server, this.streamService});

  @override
  Widget build(BuildContext context) {
    final List<Override> overrides = [];

    if (authService != null)
      overrides.add(authServiceProvider.overrideWithValue(authService!));
    if (server != null)
      overrides.add(utterBullServerProvider.overrideWithValue(server!));
    if (streamService != null)
      overrides
          .add(dataStreamServiceProvider.overrideWithValue(streamService!));

    return ProviderScope(overrides: overrides, child: UtterBullApp());
  }
}

class UtterBullApp extends StatelessWidget {
  const UtterBullApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: UtterBullContainer());
  }
}
