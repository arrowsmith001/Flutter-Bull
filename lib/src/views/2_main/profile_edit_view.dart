import 'dart:html';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bull/src/custom/extensions/riverpod_extensions.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'dart:html' as html;

// TODO: Profile edit: Both-in-one

class ProfileEditView extends ConsumerStatefulWidget {
  const ProfileEditView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileEditViewState();
}

class _ProfileEditViewState extends ConsumerState<ProfileEditView> with UserID {
  final _nameInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final asyncPlayer = ref.watch(playerNotifierProvider(userId));

    ref.listen(
        playerNotifierProvider(userId)
            .select((value) => value.value?.player.name), (_, next) {
      if (next != null) {
        _nameInputController.text = next;
      }
    });

    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          
          Spacer(),

          Flexible(
            flex: 1,
            child: Column(
        children: [
              Text(
              "Set up your profile",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            ]),
          ),

          Flexible(
            flex: 1,
            child: Column(
            children: [
            Text(
            'Enter your name:',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          TextField(controller: _nameInputController),
          ],)),

          Flexible(
            flex: 1,
            child: Column(
            
            children: 
          [
            TextButton(
              onPressed: () => ref
                  .read(playerNotifierProvider(userId).notifier)
                  .setName(_nameInputController.text),
              child: Text('Set Name')),

          Text(
            'Set display picture (optional):',
            style: Theme.of(context).textTheme.headlineMedium,
          ),

          Flexible(child: 
          
          SizedBox(
            height: 150,
            child: asyncPlayer.whenDefault((data) => Image.memory(data.avatarData!))))

          ],)),

          Spacer()
        ],
      ),
    );
  }
}
