import 'dart:js_util';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:coordinated_page_route/coordinated_page_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bull/firebase_options.dart';
import 'package:flutter_bull/src/custom/data/abstract/repository.dart';
import 'package:flutter_bull/src/custom/data/abstract/storage_service.dart';
import 'package:flutter_bull/src/style/utter_bull_theme.dart';
import 'package:flutter_bull/src/custom/widgets/row_of_n.dart';
import 'package:flutter_bull/src/custom/data/abstract/auth_service.dart';
import 'package:flutter_bull/src/developer/utter_bull_developer_panel.dart';
import 'package:flutter_bull/src/model/achievement.dart';
import 'package:flutter_bull/src/model/game_room.dart';
import 'package:flutter_bull/src/model/player.dart';
import 'package:flutter_bull/src/model/player_status.dart';
import 'package:flutter_bull/src/model/game_result.dart';
import 'package:flutter_bull/src/providers/app_services.dart';
import 'package:flutter_bull/src/services/data_layer.dart';
import 'package:flutter_bull/src/services/data_stream_service.dart';
import 'package:flutter_bull/src/services/game_server.dart';
import 'package:flutter_bull/src/views/0_app/auth_container.dart';
import 'package:flutter_bull/src/widgets/utter_bull_app.dart';
import 'package:flutter_bull/src/widgets/utter_bull_master_background.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stack_trace/stack_trace.dart';
import 'package:logger/logger.dart';

import 'src/custom/data/implemented/firebase.dart';

// TODO: Formalize events in UI layer
// TODO: Consider firebase function listeners in TS file

final int instances = 1;
final bool isEmulatingFirebase = true;
final bool devToolsOn = true;
final bool overrideMediaQuery = true;

void main() async {
  FlutterError.demangleStackTrace = (StackTrace stack) {

    if (stack is Trace) return stack.vmTrace;
    if (stack is Chain) return stack.toTrace().vmTrace;
    return stack;
  };

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  if (isEmulatingFirebase) {
    const host = '127.0.0.1';

    FirebaseFunctions.instance.useFunctionsEmulator(host, 5001);
    FirebaseFirestore.instance.useFirestoreEmulator(host, 8080);
    await FirebaseAuth.instance.useAuthEmulator(host, 9099);
    await FirebaseStorage.instance.useStorageEmulator(host, 9199);
  }

  FirebaseAuth.instance.setPersistence(Persistence.NONE);

  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return instances > 1
        ? _buildMultipleInstances(instances)
        : _buildInstance();
  }

  // Fake auth, Fake server, Real database, Real streams
  Widget _buildMultipleInstances(int numberOfInstances) {
    //final userIds = List.generate(numberOfInstances, (i) => 'user_$i');
    final userIds = List.generate(numberOfInstances, (i) => 'u${i + 1}');

    final authMap =
        Map.fromEntries(userIds.map((e) => MapEntry(e, FakeAuthService(e))));
    final dataMap = Map.fromEntries(
        userIds.map((e) => MapEntry(e, _getFirebaseDataLayer())));
    final streamMap = Map.fromEntries(
        userIds.map((e) => MapEntry(e, FirebaseDataStreamService())));
    final imgMap = Map.fromEntries(
        userIds.map((e) => MapEntry(e, FirebaseImageStorageService())));
    final serverMap = Map.fromEntries(userIds.map((e) => MapEntry(
        e,
        UtterBullClientSideServer(
            dataMap[e] as DataService, [authMap[e] as AuthService]))));

/*     final commonData = _getFirebaseDataLayer();
    final commonStreams = FirebaseDataStreamService();
    final commonImageService = FirebaseImageStorageService();
    final commonServer =
        UtterBullClientSideServer(commonData, authMap.values.toList()); */

/*     for (var userId in userIds) {
      final auth = authMap[userId]!;
      auth.addListener(() {
        commonServer.onUserAuthStateChanged(auth.getUserId);
      });
    } */

    // TODO: Extract provisions to interface

    return WidgetsApp(
        debugShowCheckedModeBanner: false,
        color: Colors.transparent,
        builder: (_, __) {
          return RowOfN<String>(
            length: numberOfInstances,
            data: userIds,
            transform: (_, userId) => ProvisionedUtterBullFunctionUser(
              const UtterBullApp(),
              authService:
                  //FirebaseAuthService(),
                  authMap[userId]!,
              server: serverMap[userId]!,
              streamService: streamMap[userId]!,
              dataService: dataMap[userId]!,
              imageService: imgMap[userId]!,
            ),
          );
        });
  }

  Widget _buildInstance() {
    //auth.signOut();

    final auth = FirebaseAuthService();
    final data = _getFirebaseDataLayer();
    final server = UtterBullClientSideServer(data, [auth]);
    final streams = FirebaseDataStreamService();
    final images = FirebaseImageStorageService();

    data.achievementRepo.createItem(Achievement(id: 'fooledAll', title: 'Fooled All', description: '* fooled the whole room', score: 30, iconPath: 'icons/achievements/default.png'));
    data.achievementRepo.createItem(Achievement(id: 'fooledMost', title: 'Fooled Most', description: '* fooled most of the room', score: 20, iconPath: 'icons/achievements/default.png'));
    data.achievementRepo.createItem(Achievement(id: 'fooledSome', title: 'Fooled Some', description: '* fooled some of the room', score: 10, iconPath: 'icons/achievements/default.png'));
    data.achievementRepo.createItem(Achievement(id: 'votedCorrectly', title: 'Voted Correctly', description: '* voted correctly', score: 10, iconPath: 'icons/achievements/default.png'));
    data.achievementRepo.createItem(Achievement(id: 'votedCorrectlyQuickest', title: 'Quickest Correct Vote', description: '* voted correctly in the quickest time', score: 20, iconPath: 'icons/achievements/default.png'));
//builder: (context, constraints) => 
    return WidgetsApp(
      builder: (context, _) => Row(
        children: [
          ProvisionedUtterBullFunctionUser(
            Container(
              color: Colors.black,
              child: AspectRatio(
                aspectRatio: 9 / 20,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return MediaQuery(
                      data: MediaQueryData(size: constraints.biggest),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: const UtterBullApp(),
                        ),
                      ),
                    );
                  }
                ),
              ),
            ),
            authService: auth,
            server: server,
            streamService: streams,
            dataService: data,
            imageService: images,
          ),
          Expanded(
              child: ProvisionedUtterBullFunctionUser(
            UtterBullDeveloperPanel(),
            authService: auth,
            server: server,
            streamService: streams,
            dataService: data,
            imageService: images,
          ))
        ],
      ),
      color: Colors.black,
    );
  }

  DatabaseDrivenDataLayer _getFirebaseDataLayer() {
    return DatabaseDrivenDataLayer(
      gameRoomRepo: Repository<GameRoom>(
          FirebaseDatabaseService('rooms', GameRoom.fromJson)),
      playerRepo: Repository<Player>(
          FirebaseDatabaseService('players', Player.fromJson)),
      playerStatusRepo: Repository<PlayerStatus>(
          FirebaseDatabaseService('playerStatuses', PlayerStatus.fromJson)),
      resultRepo: Repository<GameResult>(
          FirebaseDatabaseService('results', GameResult.fromJson)),
      achievementRepo: Repository<Achievement>(
          FirebaseDatabaseService('achievements', Achievement.fromJson)),
    );
  }
}

class ProvisionedUtterBullFunctionUser extends StatelessWidget {
  final AuthService authService;
  final UtterBullServer server;
  final DataStreamService streamService;
  final DataService dataService;
  final ImageStorageService imageService;
  final Widget child;

  const ProvisionedUtterBullFunctionUser(
    this.child, {
    required this.authService,
    required this.server,
    required this.streamService,
    required this.dataService,
    required this.imageService,
  });

  @override
  Widget build(BuildContext context) {
    return ProviderScope(overrides: [
      authServiceProvider.overrideWithValue(authService),
      utterBullServerProvider.overrideWithValue(server),
      dataStreamServiceProvider.overrideWithValue(streamService),
      dataServiceProvider.overrideWithValue(dataService),
      imageStorageServiceProvider.overrideWithValue(imageService)
    ], child: child);
  }
}

