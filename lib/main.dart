import 'dart:js_util';
import 'dart:math';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bull/firebase_options.dart';
import 'package:flutter_bull/src/custom/data/abstract/repository.dart';
import 'package:flutter_bull/src/custom/data/abstract/storage_service.dart';
import 'package:flutter_bull/src/custom/widgets/row_of_n.dart';
import 'package:flutter_bull/src/custom/data/abstract/auth_service.dart';
import 'package:flutter_bull/src/developer/utter_bull_developer_panel.dart';
import 'package:flutter_bull/src/model/achievement.dart';
import 'package:flutter_bull/src/model/game_room.dart';
import 'package:flutter_bull/src/model/player.dart';
import 'package:flutter_bull/src/model/player_status.dart';
import 'package:flutter_bull/src/model/game_result.dart';
import 'package:flutter_bull/src/notifiers/game_notifier.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/notifiers/view_models/reveal_view_notifier.dart';
import 'package:flutter_bull/src/proto/regular_rectangle_packer.dart';
import 'package:flutter_bull/src/providers/app_services.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/services/data_layer.dart';
import 'package:flutter_bull/src/services/data_stream_service.dart';
import 'package:flutter_bull/src/services/game_server.dart';
import 'package:flutter_bull/src/services/local_achievement_service.dart';
import 'package:flutter_bull/src/style/utter_bull_theme.dart';
import 'package:flutter_bull/src/view_models/5_reveals_phase/reveal_view_model.dart';
import 'package:flutter_bull/src/views/3_game/0_lobby_phase_view.dart';
import 'package:flutter_bull/src/views/3_game/4_result_phase_view.dart';
import 'package:flutter_bull/src/views/5_reveals_phase/reveal_view.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_player_avatar.dart';
import 'package:flutter_bull/src/widgets/utter_bull_app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stack_trace/stack_trace.dart';
import 'package:logger/logger.dart';

import 'src/custom/data/implemented/firebase.dart';
import 'src/widgets/main/mobile_app_layout_container.dart';

// Immediate
// TODO: Implement saboteur guessing minigame
// TODO: Reveal screen - navigate to a mini round results view
// TODO: Remove reading screen, subsume into reader screen

// Future
// TODO: Consider firebase function listeners in TS file

////////////////////////////////////////////////////////////////

String fakeId = '';
const bool testModeOn = false;

////////////////////////////////////////////////////////////////

bool get isFakingAuth => fakeId != '';

const int instances = 1;
const bool isEmulatingFirebase = true;
const bool devToolsOn = true;
const bool overrideMediaQuery = true;

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
    if (testModeOn) return ResultViewTest();
    return instances > 1
        ? _buildMultipleInstances(instances)
        : _buildInstance();
  }

  // Fake auth, Fake server, Real database, Real streams
  Widget _buildMultipleInstances(int numberOfInstances) {
    final userIds = List.generate(numberOfInstances, (i) => 'u${i + 1}');

    final DataService dataService = _getFirebaseDataLayer();
    final DataStreamService streamService = FirebaseDataStreamService();
    final ImageStorageService imgService = FirebaseImageStorageService();

    final authMap =
        Map.fromEntries(userIds.map((e) => MapEntry(e, FakeAuthService(e))));
    final dataMap =
        Map.fromEntries(userIds.map((e) => MapEntry(e, dataService)));
    final streamMap =
        Map.fromEntries(userIds.map((e) => MapEntry(e, streamService)));
    final imgMap = Map.fromEntries(userIds.map((e) => MapEntry(e, imgService)));
    final serverMap = Map.fromEntries(userIds.map((e) =>
        MapEntry(e, UtterBullClientSideServer(dataMap[e]!, [authMap[e]!]))));

    return WidgetsApp(
        debugShowCheckedModeBanner: false,
        color: Colors.transparent,
        builder: (_, __) {
          return RowOfN<String>(
            length: numberOfInstances,
            data: userIds,
            transform: (_, userId) => ProvisionedUtterBullFunctionUser(
              child: const UtterBullApp(),
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

    final auth = isFakingAuth ? FakeAuthService(fakeId) : FirebaseAuthService();
    final data = _getFirebaseDataLayer();
    final server = UtterBullClientSideServer(data, [auth]);
    final streams = FirebaseDataStreamService();
    final images = FirebaseImageStorageService();

    return WidgetsApp(
      builder: (context, _) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
            child: ProvisionedUtterBullFunctionUser(
              child: Container(
                color: Colors.black,
                child: MobileAppLayoutContainer(child: UtterBullApp()),
              ),
              authService: auth,
              server: server,
              streamService: streams,
              dataService: data,
              imageService: images,
            ),
          ),
          SizedBox(
            width: 1300,
            child: ProvisionedUtterBullFunctionUser(
              child: UtterBullDeveloperPanel(),
              authService: auth,
              server: server,
              streamService: streams,
              dataService: data,
              imageService: images,
            ),
          )
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
      achievementRepo: Repository<Achievement>(LocalAchievementService()),
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

  const ProvisionedUtterBullFunctionUser({
    required this.child,
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

class ResultViewTest extends StatefulWidget {
  ResultViewTest({super.key});

  @override
  State<ResultViewTest> createState() => _ResultViewTestState();
}

class _ResultViewTestState extends State<ResultViewTest> {

  void onFab() {
    //_revealController.onRevealed();
  }

  static const userId = '0';
  static const roomId = '';
  static const whoseTurnId = '0';

  static int numberOfPlayers = 5;

  Map<String, Player> get createPlayers {
    final list = List.generate(numberOfPlayers,
        (index) => Player(id: index.toString(), name: 'Player $index'));

    return Map.fromEntries(list.map((e) => MapEntry(e.id!, e)));
  }

  late Map<String, Player> players = createPlayers;

  GameRoom get createGame {
    final playerOrder = players.keys.toList();

    final Map<String, String> targets = {};
    final Map<String, bool> truths = {};
    final Map<String, PlayerState> playerStates = Map.fromEntries(playerOrder.map((e) => MapEntry(e, (int.parse(e) % 2) == 0 ? PlayerState.ready : PlayerState.unready)));
    final int n = playerOrder.length;
    for (var i = 0; i < n; i++) {
      final String playerId = playerOrder[i];
      if (i % 2 == 0) {
        targets.addAll({playerId: playerOrder[(i + 2) % n]});
        truths.addAll({playerId: false});
      } else {
        targets.addAll({playerId: playerId});
        truths.addAll({playerId: true});
      }
    }

    final votes = Map.fromEntries(playerOrder.map((p) => MapEntry(
        p,
        List.generate(numberOfPlayers, (id) {
          final i = int.parse(p);
          return p == whoseTurnId
              ? 'p'
              : (i % 2) == 1
                  ? 't'
                  : 'l';
        }))));

    final voteTimes = Map.fromEntries(playerOrder.map((p) => MapEntry(
        p,
        List.generate(numberOfPlayers, (id) {
          return Random(id).nextInt(300);
        }))));

    final texts = Map.fromEntries(playerOrder
        .map((p) => MapEntry(p, 'Player statement statement statement')));

    return GameRoom(
        roomCode: "42069",
        leaderId: userId,
        playerOrder: playerOrder,
        playerIds: playerOrder,
        playerStates: playerStates,
        subPhase: 0,
        votes: votes,
        voteTimes: voteTimes,
        truths: truths,
        targets: targets,
        texts: texts,
        progress: 0);
  }

  late GameRoom game = createGame;

  RevealViewModel? _revealViewModel;
  late final RevealViewController _revealController =
      RevealViewController(_revealViewModel);

    

  // TODO: Test reveal with 1 voter: squash or align?

  @override
  Widget build(BuildContext context) {

    final data = StaticDataLayer(game, players);

    return ProvisionedUtterBullFunctionUser(
      authService: FakeAuthService('0'),
      server: MockServer(),
      streamService: data,
      dataService: data,
      imageService: FirebaseImageStorageService(),
      child: MaterialApp(
        theme: UtterBullGlobal.theme,
        builder: (context, child) => MobileAppLayoutContainer(
          child: ProviderScope(
              overrides: [
                getCurrentGameRoomIdProvider.overrideWithValue(roomId),
                getSignedInPlayerIdProvider.overrideWithValue(userId),
                getPlayerWhoseTurnIdProvider.overrideWithValue(whoseTurnId),
              ],
              child: Scaffold(
                floatingActionButton:
                    FloatingActionButton(onPressed: () => onFab()),
                body: Navigator(
                  onGenerateRoute: (settings) {
                    return PageRouteBuilder(pageBuilder: (_, __, ___) {
                      return Container(
                          decoration: UtterBullGlobal.gameViewDecoration,
                          child: const LobbyPhaseView());
                    });
                  },
                ),
              )),
        ),
      ),
    );
  }
}
