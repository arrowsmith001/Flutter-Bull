import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:coordinated_page_route/coordinated_page_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bull/src/custom/extensions/riverpod_extensions.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/views/2_main/profile_setup_view.dart';
import 'package:flutter_bull/src/views/new/home/buttons/photo_prompt_view.dart';
import 'package:flutter_bull/src/views/new/notifiers/auth_notifier.dart';
import 'package:flutter_bull/src/views/new/notifiers/camera_notifier.dart';
import 'package:flutter_bull/src/views/new/notifiers/app/app_notifier.dart';
import 'package:flutter_bull/src/views/new/notifiers/app/app_state.dart';
import 'package:flutter_bull/src/views/new/notifiers/states/auth_notifier_state.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/views/new/loading.dart';
import 'package:flutter_bull/src/views/new/utter_bull.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_circular_progress_indicator.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_player_avatar.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class AuthBar extends ConsumerStatefulWidget {
  const AuthBar({super.key, this.innerPadding});

  final EdgeInsets? innerPadding;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthBarState();
}

class _AuthBarState extends ConsumerState<AuthBar>
    with MediaDimensions, SingleTickerProviderStateMixin {
  late final _animController =
      AnimationController(vsync: this, duration: Duration(milliseconds: 200));
  late final _zoomAnim =
      CurvedAnimation(parent: _animController, curve: Curves.easeInOut)
          .drive(Tween(begin: 1.0, end: _avatarScale));

  bool isEditingName = false;

  TextEditingController _nameController = TextEditingController();
  FocusNode _nameFocus = FocusNode();
  final _nameFieldKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {

    // ref.listen(
    //     appNotifierProvider.select((value) => value.valueOrNull?.nowNotBusy),
    //     (_, next) {
    //   if (next != null &&
    //       (next == Busy.creatingGame || next == Busy.joiningGame)) {
    //     setState(() {
    //       ref.read(appNotifierProvider.notifier).setAuthBarState(AuthBarState.show);
    //     });
    //   }
    // });

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
      child: Padding(
        padding: widget.innerPadding ?? EdgeInsets.zero,
        child: ref.watch(authNotifierProvider).when(
              data: (AuthNotifierState state) {
                final String? userId = state.userId;
                final bool isSignedIn = state.authState != null &&
                    state.authState != AuthState.signedOut;

                final avatar = Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 4.0, vertical: 4.0),
                  child: userId == null
                      ? const Opacity(
                          opacity: 0.5,
                          child: UtterBullPlayerAvatar(null, null))
                      : ref.watch(playerNotifierProvider(userId)).when(
                          data: (data) {
                            return AnimatedBuilder(
                              animation: _animController,
                              builder: (context, child) {
                                return Transform.scale(
                                  alignment: Alignment.topRight,
                                  scale: _zoomAnim.value,
                                  child: child,
                                );
                              },
                              child: MouseRegion(
                                cursor: SystemMouseCursors.click,
                                onEnter: (event) {
                                  _animController.forward(from: 0);
                                  //_avatarScale = 2.5;
                                },
                                onExit: (event) {
                                  _animController.reverse();
                                  // _avatarScale = 1.0;
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
                          loading: () => const Opacity(
                              opacity: 0.5,
                              child: UtterBullPlayerAvatar(null, null))),
                );

                final buttons = Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.red)),
                          onPressed: () {
                            setState(() {
                              isEditingName = false;
                            });
                          },
                          child: Text('X')),
                      ElevatedButton(
                          onPressed: () async {
                            if (!(_nameFieldKey.currentState?.validate() ??
                                false)) return;
                            await ref
                                .read(playerNotifierProvider(userId!).notifier)
                                .setName(_nameController.text);
                            setState(() {
                              isEditingName = false;
                            });
                          },
                          child: Text('OK')),
                    ],
                  ),
                );

                final Widget name = userId == null
                    ? ref.watch(appNotifierProvider).whenDefault((app) {
                        final bool isLoggingIn =
                            app.busyWith.contains(Busy.loggingIn);
                        final bool isSigningUp =
                            app.busyWith.contains(Busy.signingUp);

                        String? message;
                        if (isLoggingIn) {
                          message = 'Logging in...';
                        } else if (isSigningUp) {
                          message = 'Signing up...';
                        }
                        return AnimatedSwitcher(
                          duration: Duration(milliseconds: 300),
                          child: message == null
                              ? SizedBox.shrink()
                              : AutoSizeText(
                                  key: ValueKey(message),
                                  message,
                                  textAlign: TextAlign.end,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge),
                        );
                      })
                    : ref.watch(playerNotifierProvider(userId)).when(
                        data: (data) {
                          if (isEditingName) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: FormField(
                                validator: (_) =>
                                    InputValidators.emptyValidator(
                                        _nameController.text),
                                key: _nameFieldKey,
                                builder: (context) => UtterBullTextField(
                                    maxLength: 25,
                                    errorText:
                                        _nameFieldKey.currentState?.errorText,
                                    focusNode: _nameFocus,
                                    controller: _nameController),
                              ),
                            );
                          }

                          return data.player.name == null
                              ? const SizedBox.shrink()
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4.0, horizontal: 8.0),
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Expanded(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Flexible(
                                              child: AutoSizeText('Hi',
                                                  textAlign: TextAlign.end,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headlineLarge),
                                            ),
                                            Flexible(
                                              child: MouseRegion(
                                                cursor:
                                                    SystemMouseCursors.click,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      _nameController.text =
                                                          data.player.name ??
                                                              '';
                                                      _nameFocus.requestFocus();
                                                      isEditingName = true;
                                                    });
                                                  },
                                                  child: AutoSizeText(
                                                      '${data.player.name}',
                                                      textAlign: TextAlign.end,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headlineLarge!
                                                          .copyWith(
                                                              color: Colors
                                                                  .white)),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ))
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
                                child: Transform.flip(
                              flipX: false,
                              child: !isSignedIn
                                  ? SizedBox.shrink()
                                  : IconButton(
                                      onPressed: () {
                                        ref
                                            .read(authNotifierProvider.notifier)
                                            .signOut();
                                      },
                                      icon: Icon(
                                        Icons.logout,
                                        color:
                                            Theme.of(context).primaryColorLight,
                                        size: 60,
                                      )),
                            ))
                          ],
                        ),
                      ),
                      Expanded(
                          flex: 4,
                          child: Row(
                            children: [
                              isEditingName ? buttons : SizedBox.shrink(),
                              Expanded(child: name),
                              avatar
                            ],
                          )),
                    ],
                  ),
                );
              },
              loading: () => UtterBullCircularProgressIndicator(
                  size: const Size(100, 100)),
              error: (e, st) => ErrorWidget(e),
            ),
      ),
    );
  }

  double _avatarScale = 2.5;

  void _onAvatarPressed() async {
    setState(() {
      isEditingName = false;
    });
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
