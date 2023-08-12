import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:coordinated_page_route/coordinated_page_route.dart';
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
import 'package:flutter_bull/src/developer/utter_bull_developer_panel.dart';
import 'package:flutter_bull/src/model/game_room.dart';
import 'package:flutter_bull/src/model/game_room_state.dart';
import 'package:flutter_bull/src/model/player.dart';
import 'package:flutter_bull/src/model/player_status.dart';
import 'package:flutter_bull/src/notifiers/auth_notifier.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/providers/app_services.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/services/data_layer.dart';
import 'package:flutter_bull/src/services/data_stream_service.dart';
import 'package:flutter_bull/src/services/game_server.dart';
import 'package:flutter_bull/src/views/1_auth/main_view.dart';
import 'package:flutter_bull/src/views/0_app/auth_container.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stack_trace/stack_trace.dart';
import 'package:logger/logger.dart';

import 'src/custom/data/implemented/firebase.dart';

// TODO: Reveals phase to end
// TODO: Formalize events in UI layer
// TODO: Developer UI
// TODO: Consider firebase function listeners...

final int instances = 1;
final bool isEmulatingFirebase = true;
final bool devToolsOn = true;

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

  runApp(MyApp());
}

// TODO: Figure out TDD

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
              UtterBullApp(),
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

    return WidgetsApp(
      builder: (context, _) => Row(
        children: 
      [
        ProvisionedUtterBullFunctionUser(
          UtterBullApp(),
          authService: auth,
          server: server,
          streamService: streams,
          dataService: data,
          imageService: images,
          ),
        Expanded(child: ProvisionedUtterBullFunctionUser(
            UtterBullDeveloperPanel(),
            authService: auth,
            server: server,
            streamService: streams,
            dataService: data,
            imageService: images,
            ))
    
      ],), color: Colors.black,
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

class ProvisionedUtterBullFunctionUser extends StatelessWidget {
  final AuthService authService;
  final UtterBullServer server;
  final DataStreamService streamService;
  final DataService dataService;
  final ImageStorageService imageService;
  final Widget child;

  const ProvisionedUtterBullFunctionUser(this.child, {
    required this.authService,
    required this.server,
    required this.streamService,
    required this.dataService,
    required this.imageService,
  });

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
        overrides: 
        [
          authServiceProvider.overrideWithValue(authService),
          utterBullServerProvider.overrideWithValue(server),
          dataStreamServiceProvider.overrideWithValue(streamService),
          dataServiceProvider.overrideWithValue(dataService),
          imageStorageServiceProvider.overrideWithValue(imageService)
        ], 
        child: child);
  }
}

class UtterBullApp extends StatelessWidget {
  const UtterBullApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 9 / 20,
      child: Container(
        color: Colors.grey,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: UtterBullTheme.theme,
                home: false ? TestWidget2() : AuthContainer()),
          ),
        ),
      ),
    );
  }
}

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
      navigatorObservers: [CoordinatedRouteObserver()],
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

class TestWidget2 extends ConsumerStatefulWidget {
  const TestWidget2({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TestWidget2State();
}

class _TestWidget2State extends ConsumerState<TestWidget2> {
  final key = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: key,
        navigatorObservers: [CoordinatedRouteObserver()],
        initialRoute: '/foo',
        onGenerateRoute: (settings) {
          if (settings.name == '/foo') {
            return ForwardPushRoute((p0) => Scaffold(
                  body: Center(
                    child: TextButton(
                        child: Text('1'),
                        onPressed: () => Navigator.of(key.currentContext!)
                            .pushNamed('/bar')),
                  ),
                ));
          } else {
            return BackwardPushRoute((p0) => Scaffold(
                  body: Center(
                    child: TextButton(
                        child: Text('2'),
                        onPressed: () => Navigator.of(key.currentContext!)
                            .pushNamed('/foo')),
                  ),
                ));
          }
        });
  }
}
