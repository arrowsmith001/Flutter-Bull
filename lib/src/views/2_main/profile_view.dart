import 'package:flutter/material.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  final _nameInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    
    final userId = ref.watch(getSignedInPlayerIdProvider);

    ref.listen(playerNotifierProvider(userId).select((value) => value.value?.player.name), (_, next) {
      if (next != null) 
      {
        _nameInputController.text = next;
      }
    });

    return Scaffold(
      body: Center(
          child: Column(
        children: [
          Text('Enter your name:'), TextField(controller: _nameInputController),
          TextButton(onPressed: () => ref.read(playerNotifierProvider(userId).notifier).setName(_nameInputController.text), child: Text('Set Name'))
        ],
      )),
    );
  }
}
