import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bull/src/custom/extensions/riverpod_extensions.dart';
import 'package:flutter_bull/src/notifiers/auth_notifier.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/notifiers/signed_in_player_status_notifier.dart';
// ignore: unused_import
import 'package:flutter_bull/src/providers/app_services.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_button.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_player_avatar.dart';
import 'package:flutter_bull/src/widgets/utter_bull_title.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<HomeView> with UserID {
  final TextEditingController _roomCodeTextEditController =
      TextEditingController();

  AuthNotifier get authNotifier => ref.read(authNotifierProvider.notifier);
  SignedInPlayerStatusNotifier get signedInPlayerNotifier =>
      ref.read(signedInPlayerStatusNotifierProvider(userId).notifier);

  void onCreateRoom() async {
    signedInPlayerNotifier.createRoom();
  }

  void onJoinRoomPressed() async {
    Navigator.of(context).pushNamed('join');
  }

  void onJoinRoom() {
    signedInPlayerNotifier
        .joinRoom(_roomCodeTextEditController.text.trim().toUpperCase());
  }

  @override
  Widget build(BuildContext context) {
    final userId = ref.watch(getSignedInPlayerIdProvider);
    final playerNotifier = signedInPlayerStatusNotifierProvider(userId);

    final avatarAsync = ref.watch(playerNotifierProvider(userId));

    final playerAsync = ref.watch(playerNotifier);
/* 
    final userId = ref.watch(getSignedInPlayerIdProvider);
    final player = ref.watch(playerNotifierProvider(userId)).requireValue; */

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(child: _buildPlayerAvatar(avatarAsync)),
            const Expanded(child: UtterBullTitle()),
            Expanded(
              child: Row(
                children: [
                  Flexible(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: _buildMainButtons(),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignOutButton() {
    return TextButton(
        onPressed: () => authNotifier.signOut(), child: const Text('Sign out'));
  }

  Widget _buildPlayerAvatar(AsyncValue<PlayerWithAvatar> avatarAsync) {
    return SizedBox(
      height: 250,
      child: avatarAsync.whenDefault((avatar) {
        final data = avatar.avatarData;
        return Hero(
            tag: 'avatar',
            child: GestureDetector(
                onTap: () =>
                    Navigator.of(context).pushReplacementNamed('avatar'),
                child: UtterBullPlayerAvatar(data!)));
      }),
    );
  }

  Widget _buildMainButtons() {
    return Column(
      children: [
        Flexible(
            child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: UtterBullButton(onPressed: onCreateRoom, title: 'Create Game'),
        )),
        Flexible(
            child: Padding(
          padding: const EdgeInsets.all(4.0),
          child:
              UtterBullButton(onPressed: onJoinRoomPressed, title: 'Join Game'),
        )),
      ],
    );
  }
}
