import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bull/firebase_options.dart';
import 'package:flutter_bull/src/custom/data/abstract/repository.dart';
import 'package:flutter_bull/src/custom/data/abstract/storage_service.dart';
import 'package:flutter_bull/src/custom/style/utter_bull_theme.dart';
import 'package:flutter_bull/src/custom/widgets/row_of_n.dart';
import 'package:flutter_bull/src/custom/data/abstract/auth_service.dart';
import 'package:flutter_bull/src/model/game_room.dart';
import 'package:flutter_bull/src/model/game_room_state.dart';
import 'package:flutter_bull/src/model/player.dart';
import 'package:flutter_bull/src/model/player_status.dart';
import 'package:flutter_bull/src/navigation/utter_bull_router.dart';
import 'package:flutter_bull/src/notifiers/auth_notifier.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/providers/app_services.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/services/data_layer.dart';
import 'package:flutter_bull/src/services/data_stream_service.dart';
import 'package:flutter_bull/src/services/game_server.dart';
import 'package:flutter_bull/src/views/1_auth/login_view.dart';
import 'package:flutter_bull/src/views/1_auth/main_view.dart';
import 'package:flutter_bull/src/views/0_app/auth_container.dart';
import 'package:flutter_bull/utter_bull_router_layer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:stack_trace/stack_trace.dart';
import 'package:logger/logger.dart';

import 'src/custom/data/implemented/firebase.dart';

final bool isEmulatingFirebase = true;

void main() async {
  // TODO: Generalize init

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

  runApp(const MyApp());
}

// TODO: Figure out TDD
// TODO: Containerize

final int instances = 1;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return instances > 1
        ? _buildMultipleInstances(instances)
        : _buildInstance();
  }

  // Fake auth, Fake server, Real database, Real streams
  Widget _buildMultipleInstances(int numberOfInstances) {
    //final userIds = List.generate(numberOfInstances, (i) => 'user_$i');
    final userIds = [
      'u1',
      'u2',
      'u3',
      'u4' 
    ];
    final authMap = <String, AuthService>{};
    for (var userId in userIds) {
      authMap.addAll({userId: FakeAuthService(userId)});
    }

    final commonData = _getFirebaseDataLayer();
    final commonStreams = FirebaseDataStreamService();
    final commonImageService = FirebaseImageStorageService();
    final commonServer =
        UtterBullClientSideServer(commonData, authMap.values.toList());

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
            transform: (_, userId) => ProvisionedUtterBullApp(
              authService:
                  //FirebaseAuthService(),
                  authMap[userId]!,
              server: commonServer,
              streamService: commonStreams,
              dataService: commonData,
              imageService: commonImageService,
            ),
          );
        });
  }

  Widget _buildInstance() {
    final auth = FirebaseAuthService();

    //auth.signOut();

    final data = _getFirebaseDataLayer();

    final server = UtterBullClientSideServer(data, [auth]);

    final streams = FirebaseDataStreamService();
    final images = FirebaseImageStorageService();

    return ProvisionedUtterBullApp(
      authService: auth,
      server: server,
      streamService: streams,
      dataService: data,
      imageService: images,
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
  );
  }
}

class ProvisionedUtterBullApp extends StatelessWidget {
  final AuthService authService;
  final UtterBullServer server;
  final DataStreamService streamService;
  final DataService dataService;
  final ImageStorageService imageService;

  const ProvisionedUtterBullApp(
      {required this.authService,
      required this.server,
      required this.streamService,
      required this.dataService,
      required this.imageService,
      
      });

  @override
  Widget build(BuildContext context) {
    final List<Override> overrides = [];

    overrides.add(authServiceProvider.overrideWithValue(authService));
    overrides.add(utterBullServerProvider.overrideWithValue(server));
    overrides.add(dataStreamServiceProvider.overrideWithValue(streamService));
    overrides.add(dataServiceProvider.overrideWithValue(dataService));
    overrides.add(imageStorageServiceProvider.overrideWithValue(imageService));

    return ProviderScope(overrides: overrides, child: UtterBullApp());
  }
}

class UtterBullApp extends ConsumerWidget {
  const UtterBullApp({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AspectRatio(
      aspectRatio: 9/20,
      child: Container(
        color: Colors.grey,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),

            child: MaterialApp.router(
      routerConfig: ref.watch(routerProvider),
      debugShowCheckedModeBanner: false,
      theme: UtterBullTheme.theme,
      //home: false ? TestWidget() : AuthContainer()
    ),
          ),
        ),
      ),
    );
  }
}

/* class NoRouteInformationProvider extends RouteInformationProvider {
  @override
  void addListener(VoidCallback listener) {
  }

  @override
  void removeListener(VoidCallback listener) {
  }

  @override
  // TODO: implement value
  RouteInformation get value => throw UnimplementedError();

} */

class TestWidget extends ConsumerStatefulWidget {
  const TestWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends ConsumerState<TestWidget>
    with SingleTickerProviderStateMixin {
  List<String> list = ['a', 'b', 'c'];

  final GlobalKey<AnimatedListState> _key = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      home: Scaffold(
        body: Column(
          children: [
            TextButton(
                onPressed: () {
                  final i = list.length;
                  list.insert(i, 'd');
                  _key.currentState!
                      .insertItem(i, duration: Duration(seconds: 1));
                },
                child: Text('press')),
            Expanded(
              child: AnimatedList(
                controller: ScrollController(),
                key: _key,
                initialItemCount: list.length,
                itemBuilder: (context, index, animation) {
                  return _buildListItem(index, animation);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(int index, Animation<double> animation) {
    return AnimatedBuilder(
      key: ValueKey(index),
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        return Opacity(
          opacity: animation.value,
          child: child,
        );
      },
      child: ListTile(
        title: Text(list[index]),
      ),
    );
  }
}
