import 'package:flutter/material.dart';
import 'package:flutter_bull/src/custom/extensions/riverpod_extensions.dart';
import 'package:flutter_bull/src/notifiers/auth_notifier.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/notifiers/signed_in_player_status_notifier.dart';
import 'package:flutter_bull/src/providers/app_services.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<HomeView> {
  final TextEditingController _roomCodeTextEditController =
      TextEditingController();

  AuthNotifier get authNotifier => ref.read(authNotifierProvider.notifier);
  SignedInPlayerStatusNotifier get signedInPlayerNotifier => ref.read(signedInPlayerStatusNotifierProvider(readUserId).notifier);

  String get watchUserId => ref.watch(getSignedInPlayerIdProvider);
  String get readUserId => ref.read(getSignedInPlayerIdProvider);

  void onJoinRoom() async {
    signedInPlayerNotifier.joinRoom(_roomCodeTextEditController.text.toUpperCase());
  }

  void onCreateRoom() async {
    signedInPlayerNotifier.createRoom();
  }

  @override
  Widget build(BuildContext context) {
    
    final userId = ref.watch(getSignedInPlayerIdProvider);
    final playerNotifier = signedInPlayerStatusNotifierProvider(userId);

    final playerAsync = ref.watch(playerNotifier);
/* 
    final userId = ref.watch(getSignedInPlayerIdProvider);
    final player = ref.watch(playerNotifierProvider(userId)).requireValue; */

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: playerAsync.hasValue
                  ? Text(playerAsync.requireValue.player!.toJson().toString())
                  : CircularProgressIndicator(),
            ),
            const Text(
              'Utter Bull',
            ),
            TextField(
              controller: _roomCodeTextEditController,
            ),
            ElevatedButton(
                onPressed: () {
                  onJoinRoom();
                },
                child: Text("Join Room")),
            ElevatedButton(
                onPressed: () {
                  onCreateRoom();
                },
                child: Text("Create Room")),
            TextButton(
                onPressed: () =>
                    Navigator.of(context).pushReplacementNamed('profile'),
                child: Text('Edit Profile')),
            TextButton(
                onPressed: () => authNotifier.signOut(),
                child: Text('Sign out'))
          ],
        ),
      ),
    );
  }
}
