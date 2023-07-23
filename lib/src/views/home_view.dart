import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bull/main.dart';
import 'package:flutter_bull/src/custom/extensions/riverpod_extensions.dart';
import 'package:flutter_bull/src/notifiers/auth_notifier.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/providers/app_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// TODO: Have "states" extend Loadable, implement "ghost" data so it doesnt just drop out of existence

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<HomeView> {

  final TextEditingController _roomCodeTextEditController = TextEditingController();


  AuthNotifier get authNotifier => ref.watch(authNotifierProvider.notifier);

  String? get watchUserId => ref.watch(authServiceProvider).getUserId;
  String? get readUserId => ref.read(authServiceProvider).getUserId;

  void onJoinRoom() async {
    ref.read(utterBullServerProvider).joinRoom(readUserId!, _roomCodeTextEditController.text.toUpperCase());
  }

  void onCreateRoom() async {
    ref.read(utterBullServerProvider).createRoom(readUserId!);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Figure out what to do with this null check. How to handle null...
    final signedInPlayer = ref.watch(playerNotifierProvider(watchUserId!));

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: signedInPlayer.whenDefault((data) {
                return Text(data.toJson().toString());
              }),
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
                onPressed: () => authNotifier.signOut(),
                child: Text('Sign out'))
          ],
        ),
      ),
    );
  }
}
