import 'package:auto_size_text/auto_size_text.dart';
import 'package:coordinated_page_route/coordinated_page_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/views/new/home/buttons/photo_prompt_view.dart';
import 'package:flutter_bull/src/views/new/notifiers/auth_notifier.dart';
import 'package:flutter_bull/src/views/new/notifiers/camera_notifier.dart';
import 'package:flutter_bull/src/views/new/notifiers/states/auth_notifier_state.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/views/new/loading.dart';
import 'package:flutter_bull/src/views/new/utter_bull.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_circular_progress_indicator.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_player_avatar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class AuthBar extends ConsumerStatefulWidget {
  const AuthBar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthBarState();
}

class _AuthBarState extends ConsumerState<AuthBar> with MediaDimensions {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
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

              final avatar = Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
                child: userId == null
                    ? const Opacity(
                        opacity: 0.5, child: UtterBullPlayerAvatar(null, null))
                    : ref.watch(playerNotifierProvider(userId)).when(
                        data: (data) {
                          return Transform.scale(
                            alignment: Alignment.topRight,
                            scale: _avatarScale,
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              onEnter: (event) {
                                setState(() {
                                  _avatarScale = 2.5;
                                });
                              },
                              onExit: (event) {
                                setState(() {
                                  _avatarScale = 1.0;
                                });
                              },
                              child: GestureDetector(
                                onTap: () => _onAvatarPressed(),
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Positioned(
                                      child: UtterBullPlayerAvatar(
                                          null, data.avatarData),
                                    ),
                                    // Positioned(
                                    //     bottom: -height*0.1,
                                    //   child: Container(
                                    //     color: Colors.amber,
                                    //     height: 100, width: width*0.8,
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        error: (e, st) => ErrorWidget(e),
                        loading: () => const Loading(dim: 25)),
              );

              final name = userId == null
                            ? const SizedBox.shrink()
                            : ref.watch(playerNotifierProvider(userId)).when(
                                data: (data) {
                                  return data.player.name == null
                                      ? const SizedBox.shrink()
                                      : Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4.0, horizontal: 8.0),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Expanded(
                                                  child: AutoSizeText(
                                                    'Hi ${data.player.name}',
                                                    textAlign: TextAlign.end,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headlineLarge,
                                                  ),
                                                )
                                              ]),
                                        );
                                },
                                error: (e, st) => const SizedBox.shrink(),
                                loading: () => const SizedBox.shrink());

              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: Row(
                  key: ValueKey(userId),
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      Expanded(
                          child: IconButton.filled(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.settings,
                                size: 60,
                              )))
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                        child: Row(
                          children: [
                          Expanded(child: name), 
                          avatar
                        ],)),
                  ],
                ),
              );
            },
            loading: () =>
                UtterBullCircularProgressIndicator(size: const Size(100, 100)),
            error: (e, st) => ErrorWidget(e),
          ),
    );
  }

  double _avatarScale = 1.0;

  void _onAvatarPressed() async {
    showDialog(
        context: context,
        builder: (context) => Stack(
              children: [
                Positioned(
                    width: width * 0.75,
                    top: height * 0.1,
                    right: 0,
                    child: PhotoPromptButtons(onPressed: () {
                      Navigator.of(context).pop();
                    })),
              ],
            ));
    //await ref.read(cameraNotifierProvider.notifier).initialize();
  }
}
