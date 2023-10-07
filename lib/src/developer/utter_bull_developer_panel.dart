import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bull/src/custom/data/abstract/auth_service.dart';
import 'package:flutter_bull/src/enums/game_phases.dart';
import 'package:flutter_bull/src/model/game_room.dart';
import 'package:flutter_bull/src/model/player.dart';
import 'package:flutter_bull/src/notifiers/auth_notifier.dart';
import 'package:flutter_bull/src/notifiers/game_notifier.dart';
import 'package:flutter_bull/src/notifiers/signed_in_player_status_notifier.dart';
import 'package:flutter_bull/src/notifiers/states/auth_notifier_state.dart';
import 'package:flutter_bull/src/notifiers/states/game_notifier_state.dart';
import 'package:flutter_bull/src/notifiers/states/signed_in_player_status_notifier_state.dart';
import 'package:flutter_bull/src/providers/app_services.dart';
import 'package:flutter_bull/src/services/data_layer.dart';
import 'package:flutter_bull/src/services/data_stream_service.dart';
import 'package:flutter_bull/src/services/game_server.dart';
import 'package:flutter_bull/src/utils/game_data_functions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UtterBullDeveloperPanel extends ConsumerStatefulWidget {
  const UtterBullDeveloperPanel({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UtterBullDeveloperPanelState();
}

class _UtterBullDeveloperPanelState
    extends ConsumerState<UtterBullDeveloperPanel> {
  late ScrollController _scrollController = ScrollController();

  String? get userId => authAsync.value?.userId;
  String? get roomId => roomAsync.value?.gameRoom.id;

  AuthService get _auth => ref.read(authServiceProvider);
  DataService get _data => ref.read(dataServiceProvider);
  DataStreamService get _stream => ref.read(dataStreamServiceProvider);
  UtterBullServer get _server => ref.read(utterBullServerProvider);

  AsyncValue<AuthNotifierState> get authAsync =>
      ref.watch(authNotifierProvider);
  AuthNotifier get authNotifier => ref.read(authNotifierProvider.notifier);

  SignedInPlayerStatusNotifierProvider playerProviderCustom(String? id) =>
      signedInPlayerStatusNotifierProvider(id);
  SignedInPlayerStatusNotifierProvider get playerProvider =>
      playerProviderCustom(authAsync.valueOrNull?.userId);
  AsyncValue<SignedInPlayerStatusNotifierState> get playerAsync =>
      ref.watch(playerProvider);
  SignedInPlayerStatusNotifier get playerNotifier =>
      ref.read(playerProvider.notifier);

  GameNotifierProvider get roomProvider =>
      gameNotifierProvider(playerAsync.valueOrNull?.player?.occupiedRoomId);
  AsyncValue<GameNotifierState> get roomAsync => ref.watch(roomProvider);
  GameNotifier get roomNotifier => ref.read(roomProvider.notifier);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey.shade100,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            mainAxisSize: MainAxisSize.min, 
            children: [

            ElevatedButton(
                onPressed: () => authNotifier.signOut(),
                child: Text("Sign out")),

            LabelledAsyncData('userId', authAsync.valueOrNull,
                stringifyValue: (data) => data?.userId),

            Row(
              children: [
                LabelledAsyncData('player', playerAsync.valueOrNull,
                    stringifyValue: (p) =>
                        _jsonPrettyString(p?.player?.toJson())),
              ],
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start, 
              children: [

              Flexible(
                child: Column(
                  children: [
                    Container(child: _buildRoomFunctions()),
                    LabelledAsyncData('room', roomAsync.valueOrNull,
                        stringifyValue: (r) =>
                            _jsonPrettyString(r?.gameRoom.toJson())),
                  ],
                ),
              ),

              Expanded(
                  child: Row(children: [
                Flexible(
                    child: ListedLabelledAsyncData(
                  'roomPlayers',
                  roomAsync.valueOrNull,
                  (r) => r?.players.values.toList(),
                  stringifyValue: (p) => _jsonPrettyString(p.player.toJson()),
                  buildTrailing: (p) => _buildPlayerFunctions(p.player.id),
                  buildTextColor: (s, str) => _getColorCode(s.player.id),
                ))
              ])),
              
            ]),
          ]),
        ));
  }

  bool _playerIsInRoom(String? id) {
    if (id == null || roomId == null) return false;
    return roomAsync.value!.gameRoom.playerIds.contains(id);
  }

  String _jsonPrettyString(Object? obj) =>
      obj == null ? 'null' : JsonEncoder.withIndent('\t').convert(obj);


  Widget _buildPlayerFunctions(String? id) {
    if (id == null) return Container();
    return Column(children: [
      ElevatedButton(
          onPressed: roomId == null || !_playerIsInRoom(id)
              ? null
              : () => _server.removeFromRoom(id, roomId!),
          child: Text('Remove from room')),
      ElevatedButton(
          onPressed: roomId == null || !_playerIsInRoom(id)
              ? null
              : () => _server.setPlayerState(
        roomId!, id, roomAsync.requireValue.gameRoom.playerStates[id] != PlayerState.ready ? PlayerState.ready : PlayerState.unready),
          child: Text('Toggle Ready')),
      ElevatedButton(
          onPressed: roomId == null
              ? null
              : () => _server.submitText(roomId!, id, _generateText(id)),
          child: Text('Submit Text')),
      Wrap(
        children: [
          ElevatedButton(
              onPressed:
                  roomId == null ? null : () => _server.vote(roomId!, id, true),
              child: Text('Vote T')),
          ElevatedButton(
              onPressed: roomId == null
                  ? null
                  : () => _server.vote(roomId!, id, false),
              child: Text('Vote L'))
        ],
      ),
    ]);
  }

  Widget _buildRoomFunctions() {
    if (roomId == null) return Container();
    return Column(
      children: [
        Wrap(children: [
          ElevatedButton(
              onPressed: () => addRandomPlayer(),
              child: Text('Add Random Player')),
          ElevatedButton(
              onPressed:
                  roomId == null ? null : () => _server.startGame(roomId!),
              child: Text('Start Game')),
          ElevatedButton(
              onPressed:
                  roomId == null ? null : () => _server.returnToLobby(roomId!),
              child: Text('Return to Lobby')),
          ElevatedButton(
              onPressed:
                  roomId == null ? null : () => _server.startRound(roomId!, ''),
              child: Text('Start Round')),
          ElevatedButton(
              onPressed:
                  roomId == null ? null : () => _server.endRound(roomId!, ''),
              child: Text('End Round')),
          ElevatedButton(
              onPressed:
                  roomId == null ? null : () => _server.reveal(roomId!, ''),
              child: Text('Reveal')),
          ElevatedButton(
              onPressed:
                  roomId == null ? null : () => _server.revealNext(roomId!, ''),
              child: Text('Next Reveal')),
          ElevatedButton(
              onPressed: roomId == null
                  ? null
                  : () => _server.calculateResults(roomId!),
              child: Text('Calculate results')),
        ]),

        // TODO: Test with arbitrary phase changing
/*       
Row(children: [
          ElevatedButton(
              onPressed: () => _server.setRoomPhase(roomId!, _phasePlus(-1)),
              child: Text('-')),
          Text('Phase'),
          ElevatedButton(
              onPressed: () => _server.setRoomPhase(roomId!, _phasePlus(1)),
              child: Text('+')),
        ]), */
        Row(children: [
          ElevatedButton(
              onPressed: () => _server.setSubPhase(roomId!, _subPhasePlus(-1)),
              child: Text('-')),
          Text('Sub'),
          ElevatedButton(
              onPressed: () => _server.setSubPhase(roomId!, _subPhasePlus(1)),
              child: Text('+')),
        ])
      ],
    );
  }

  void addRandomPlayer() async {
    final id = FirebaseFirestore.instance.collection('players').doc().id;
    final name = _getRandomName(id);
    final newPlayer = Player(
        id: id,
        name: name,
        profilePhotoPath: _getPhotoFromName(name),
        occupiedRoomId: roomId);
    await _data.createPlayer(newPlayer);
    await _server.joinRoom(id, roomAsync.requireValue.gameRoom.roomCode);
  }

  String _getRandomName([String? seed]) {
    final stringSeedToInt =
        seed?.codeUnits.reduce((value, element) => value + element);
    final index = Random(stringSeedToInt).nextInt(randomFirstNames.length);
    return randomFirstNames.keys.toList()[index];
  }

  String _generateText(String id) {
    final targets = roomAsync.requireValue.gameRoom.targets;
    return GameDataFunctions.generatePlaceholderText(id, targets);
  }

  GamePhase _phasePlus(int i) {
    final newIndex = roomAsync.requireValue.gameRoom.phase.index + i;
    return GamePhase.values[newIndex % GamePhase.values.length];
  }

  int _subPhasePlus(int i) {
    return max(0, roomAsync.requireValue.gameRoom.subPhase + i);
  }

  Color? _getColorCode(String? id) {
    try {
      if (_playerIsInRoom(id) == false) return Colors.grey;
      if (_isPlayersTurn(id)) return Colors.yellow[900];
    } catch (e) {}
    return null;
  }

  bool _isPlayersTurn(String? id) {
    try {
      final room = roomAsync.requireValue.gameRoom;
      return room.playerOrder[room.progress] == id;
    } catch (e) {}
    return false;
  }

  String _getPhotoFromName(String name) {
    final Gender gender = randomFirstNames[name]!;
    List<String> photos = gender == Gender.male ? malePhotos : femalePhotos;
    final index =
        Random(name.codeUnits.reduce((v, e) => v + e)).nextInt(photos.length);
    return photos[index];
  }
}

class LabelledAsyncData<T> extends StatelessWidget {
  const LabelledAsyncData(this.label, this.asyncData, {this.stringifyValue});

  final String label;
  final T asyncData;
  final String? Function(T)? stringifyValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$label:'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: LayoutBuilder(builder: (context, constraints) {
              return Text(
                _getString(),
                softWrap: true,
                overflow: TextOverflow.ellipsis,
              );
            }),
          )
        ],
      ),
    );
  }

  String _getString() {
    final data = asyncData;
    if (data == null) return '<null>';
    if (stringifyValue == null) return data.toString();
    return stringifyValue!(data) ?? '<null>';
  }
}

class ListedLabelledAsyncData<T, S> extends StatelessWidget {
  const ListedLabelledAsyncData(
      this.label, this.asyncData, this.listFromAsyncData,
      {this.stringifyValue, this.buildTextColor, this.buildTrailing});

  final String label;
  final T asyncData;
  final List<S>? Function(T) listFromAsyncData;
  final Widget Function(S)? buildTrailing;
  final Color? Function(S, String)? buildTextColor;
  final String? Function(S)? stringifyValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$label:'),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: LayoutBuilder(builder: (context, constraints) {
                final list = listFromAsyncData(asyncData);
                if (list == null) return Text('<null>');

                return ListView(
                    shrinkWrap: true,
                    children: list.map((s) {
                      final str = _getString(s);
                      final child = buildTextColor == null
                          ? Text(str)
                          : Text(str,
                              style: TextStyle(color: buildTextColor!(s, str)));
                      if (buildTrailing == null) return child;
                      return Row(
                        children: [child, buildTrailing!(s)],
                      );
                    }).toList());
              }),
            ),
          ),
        ],
      ),
    );
  }

  String _getString(S value) {
    if (value == null) return '<null>';
    if (stringifyValue == null) return value.toString();
    return stringifyValue!(value) ?? '<null>';
  }
}

enum Gender { male, female }

const Map<String, Gender> randomFirstNames = {
  "Alice": Gender.female,
  "Bob": Gender.male,
  "Carol": Gender.female,
  "David": Gender.male,
  "Eve": Gender.female,
  "Frank": Gender.male,
  "Grace": Gender.female,
  "Henry": Gender.male,
  "Ivy": Gender.female,
  "Jack": Gender.male,
  "Katherine": Gender.female,
  "Liam": Gender.male,
  "Mia": Gender.female,
  "Noah": Gender.male,
  "Olivia": Gender.female,
  "Penelope": Gender.female,
  "Quinn": Gender.male,
  "Ryan": Gender.male,
  "Sophia": Gender.female,
  "Thomas": Gender.male,
  "Uma": Gender.female,
  "Violet": Gender.female,
  "William": Gender.male,
  "Xander": Gender.male,
  "Yasmine": Gender.female,
  "Zoe": Gender.female,
};

final femalePhotos = [
  ...List.generate(8, (i) => 'pp/default/female${i+1}.jpg'),  
  'pp/default/beauty.png'
  ];

final malePhotos = [
  ...List.generate(7, (i) => 'pp/default/male${i+1}.jpg')
  ];
