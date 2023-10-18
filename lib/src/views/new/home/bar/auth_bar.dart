import 'package:coordinated_page_route/coordinated_page_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/views/new/auth_notifier.dart';
import 'package:flutter_bull/src/notifiers/states/auth_notifier_state.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/views/new/loading.dart';
import 'package:flutter_bull/src/views/new/utter_bull.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_circular_progress_indicator.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_player_avatar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class AuthBar extends ConsumerStatefulWidget {
  const AuthBar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthBarState();
}

class _AuthBarState extends ConsumerState<AuthBar> {

  @override
  Widget build(BuildContext context) {
    return Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).primaryColorDark
                  ])),
              child: ref.watch(authNotifierProvider).when(
                    data: (AuthNotifierState state) {
                      final String? userId = state.userId;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                  child: IconButton.filled(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.settings,
                                        size: 60,
                                      )))
                            ],
                          )),
                          Spacer(),
                          Expanded(child: Text(state.userId.toString())),
                          Expanded(child: userId == null ? SizedBox.shrink() : ref
                                .watch(playerNotifierProvider(userId))
                                .when(
                                    data: (data) {
                                        return data.player.name == null ? SizedBox.shrink() : Text('Hi ${data.player.name}');
                                    },
                                    error: (e, st) => SizedBox.shrink(),
                                    loading: () => SizedBox.shrink())),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: userId == null ? Opacity(
                              opacity: 0.5,
                              child: UtterBullPlayerAvatar(null, null)) 
                            :  ref
                                .watch(playerNotifierProvider(userId))
                                .when(
                                    data: (data) {
                                        return UtterBullPlayerAvatar(
                                            null, data.avatarData);
                                    },
                                    error: (e, st) => ErrorWidget(e),
                                    loading: () => Loading(dim: 25)),
                          ))
                        ],
                      );
                    },
                    loading: () => UtterBullCircularProgressIndicator(
                        size: Size(100, 100)),
                    error: (e, st) => ErrorWidget(e),
                  ),
            );
  }
}