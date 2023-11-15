import 'package:auto_size_text/auto_size_text.dart';
import 'package:coordinated_page_route/coordinated_page_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bull/gen/assets.gen.dart';
import 'package:flutter_bull/src/custom/extensions/riverpod_extensions.dart';
import 'package:flutter_bull/src/custom/widgets/controlled_navigator.dart';
import 'package:flutter_bull/src/navigation/coordinated_routes/swap_route.dart';
import 'package:flutter_bull/src/navigation/navigation_controller.dart';
import 'package:flutter_bull/src/views/new/notifiers/auth_notifier.dart';
import 'package:flutter_bull/src/views/new/notifiers/states/auth_notifier_state.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/views/new/home/auth/sign_up_email_view.dart';
import 'package:flutter_bull/src/widgets/common/error_popup.dart';
import 'package:flutter_bull/src/widgets/common/loading_widget.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_button.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_circular_progress_indicator.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_single_option_dismissable_dialog.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../new/bottom_bar.dart';
import 'login_options_view.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  late final _navController = LoginNavigationController();
  final _navHeaderController = LoginNavigationHeaderController();
  final _navFooterController = LoginNavigationFooterController();

  @override
  Widget build(BuildContext context) {
    // ref.listen(authNotifierProvider.select((value) => value), (prev, next) {
    //   final wasLoading = prev?.isLoading ?? false;
    //   final isLoading = next.isLoading;

    //   Logger().d(
    //       "auth load listen: was [$wasLoading] is [$isLoading] next [$next]");

    //   if (!wasLoading && isLoading) {
    //     _navController.navigateToLoading(next.valueOrNull?.message);
    //   }
    // });

    // ref.listen(authNotifierProvider.select((value) => value.valueOrNull?.route),
    //     (prev, next) {
    //   if (next != null) {
    //     _navHeaderController.navigateTo(next);
    //     _navController.navigateTo(next);
    //     _navFooterController.navigateTo(next);
    //   }
    // });

    // ref.listen(
    //     authNotifierProvider.select((value) => value.valueOrNull?.signUp),
    //     (prev, next) {
    //   if (next == true) {
    //     _navFooterController.navigateTo('isSigningUp');
    //   } else if (next == false) {
    //     _navFooterController.navigateTo('signUpEmail');
    //   }
    // });

    final asyncData = ref.watch(authNotifierProvider);

    return Column(
      children: [
        Flexible(
            flex: 1,
            child: asyncData.whenDefault((data) => ControlledNavigator(
                  observers: [CoordinatedRouteObserver()],
                  controller: _navHeaderController,
                  data: data,
                ))),
        Expanded(
          flex: 5,
          child: asyncData.when(
            data: (data) => ControlledNavigator(
                observers: [CoordinatedRouteObserver()],
                controller: _navController,
                data: data),
            loading: () => const LoadingWidget(),
            error: (e, _) => ErrorPopup(
              e.toString(),
              escape: () => Logger().d("message"),
            ),
          ),
        ),
        Flexible(
            flex: 1,
            child: asyncData.whenDefault((data) => ControlledNavigator(
                  observers: [CoordinatedRouteObserver()],
                  controller: _navFooterController,
                  data: data,
                ))),
      ],
    );
  }
}

class LoginNavigationController
    extends NavigationController<AuthNotifierState> {
  List<LoginNavigationController> controllers;

  LoginNavigationController({this.controllers = const []});
  @override
  Route get defaultRoute => throw UnimplementedError();

  @override
  String generateInitialRoute(AuthNotifierState data) {
    return data.userId == null ? 'options' : 'loading';
  }

  @override
  PageRoute? generateRoute() {
    switch (nextRoutePath) {
      case 'options':
        return BackwardFadePushRoute((context) => const LoginOptionsView());
      case 'signUpEmail':
        return ForwardFadePushRoute((_) => const SignUpEmailView());
      case 'loading':
        return CoordinatedZoomFadeRoute((context) {
          final message = tryNextRoutePath;
          return LoadingWidget(message: message);
        });
    }

    return null;
  }

  void navigateToLoading(String? message) {
    navigateTo('loading/${message ?? ''}');
  }
}

class LoginNavigationHeaderController extends LoginNavigationController {
  @override
  Route get defaultRoute => PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const SizedBox.shrink(),
      );

  @override
  PageRoute? generateRoute() {
    switch (nextRoutePath) {
      case 'options':
        return UpDownStaggeredSlideRoute(
            (context) => _buildOptionsHeader(context),
            overlap: 0.5);
      case 'signUpEmail':
        return UpDownStaggeredSlideRoute((context) => SignUpHeader(),
            overlap: 0.5);
      case 'loading':
        return UpDownStaggeredSlideRoute((context) => const SizedBox.shrink(),
            overlap: 0.5);
    }

    return null;
  }

  Widget _buildOptionsHeader(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Container(
                decoration: BoxDecoration(
                    //borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12)),
                    color: Theme.of(context).primaryColor),
                child:
                    Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: AutoSizeText(
                        "Welcome!",
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        maxFontSize: 120,
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                  // Flexible(
                  //   child: Padding(
                  //     padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  //     child: UglyOutlinedText(text: 'Utter Bull!'),
                  //   ),
                  // )
                ])))
      ],
    );
  }
}

class LoginNavigationFooterController extends LoginNavigationController {
  @override
  Route get defaultRoute => PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const SizedBox.shrink(),
      );

  void _onSignUpExplanationPressed(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => UtterBullSingleOptionDismissableDialog(
            message: 'Utter Bull requires an account for players to identify and interact with one another.' +
                '\n\nAfter creating an account, all content you produce in the game is associated with an anonymized player profile.' +
                '\n\nWe do not actively collect or store the data produced by your interactions with this application for purposes beyond game functionality.'));
  }

  @override
  PageRoute? generateRoute() {
    switch (nextRoutePath) {
      case 'options':
        return DownUpStaggeredSlideRoute(
            (context) => Padding(
                  padding: EdgeInsets.all(24),
                  child: ElevatedButton(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AutoSizeText(
                          "Why do I need to create an account?",
                          textAlign: TextAlign.center,
                          maxFontSize: 100,
                          minFontSize: 25,
                        ),
                      ),
                      onPressed: () => _onSignUpExplanationPressed(context)),
                ),
            overlap: 0.5);
      case 'signUpEmail':
        return DownUpStaggeredSlideRoute((context) => SignUpButtonBar(),
            overlap: 0.5);
      case 'isSigningUp':
        return DownUpStaggeredSlideRoute((context) => SignUpInProgressBar(),
            overlap: 0.5);
      case 'loading':
        return DownUpStaggeredSlideRoute((context) => const SizedBox.shrink(),
            overlap: 0.5);
    }

    return null;
  }
}

class SignUpFooter extends ConsumerStatefulWidget {
  const SignUpFooter({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpFooterState();
}

class _SignUpFooterState extends ConsumerState<SignUpFooter>
    with Auth, MediaDimensions {
  bool isSigningUp = false;

  void onIsSigningUpChanged(bool value) {
    setState(() {
      isSigningUp = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    // ref.listen(
    //     authNotifierProvider.select((value) => value.valueOrNull?.signUp),
    //     (prev, next) {
    //   if (next != null) onIsSigningUpChanged(next);
    // });

    return AnimatedSwitcher(
      switchInCurve: Curves.elasticOut,
      layoutBuilder: (currentChild, previousChildren) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                  height: height * 0.05, color: Theme.of(context).primaryColor),
              currentChild!
            ],
          ),
        );
      },
      transitionBuilder: (child, animation) {
        return AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return Transform.translate(
                offset: Offset(0, (1 - animation.value) * (height * 0.15)),
                child: child);
          },
          child: child,
        );
      },
      duration: Duration(milliseconds: 600),
      child: isSigningUp ? SizedBox.shrink() : SizedBox.shrink(),
    );
  }
}

class SignUpButtonBar extends ConsumerWidget {
  const SignUpButtonBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BottomBar(
        height: 125,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: UtterBullButton(
                  title: 'Sign Up',
                  // onPressed: () => ref
                  //     .read(authNotifierProvider.notifier)
                  //     .setValidateSignUpForm(true)
                      ),
            ),
          ],
        ));
  }
}

class SignUpInProgressBar extends ConsumerWidget {
  const SignUpInProgressBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BottomBar(
        height: 125,
        key: UniqueKey(),
        child: Row(
          children: [
            SizedBox.fromSize(
                size: Size(75, 75),
                child: UtterBullCircularProgressIndicator()),
            Flexible(
              child: AutoSizeText(
                "Signing you up...",
                maxLines: 1,
                style: TextStyle(fontSize: 50),
              ),
            )
          ],
        ));
  }
}

class SignUpHeader extends ConsumerWidget {
  const SignUpHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        Row(
          children: [
            Expanded(
                child: Container(
                    decoration: BoxDecoration(
                        //borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12)),
                        color: Theme.of(context).primaryColor),
                    child: Column(children: [
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: AutoSizeText(
                          "Sign Up with Email",
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          maxFontSize: 120,
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ])))
          ],
        ),
        Positioned(
            child: IconButton(
          icon: Icon(Icons.exit_to_app),
          onPressed: () {
            //ref.read(authNotifierProvider.notifier).setRoute('options');
          },
        )),
      ],
    );
  }
}

abstract class SameSideStaggeredSlideRoute extends CoordinatedPageRoute {
  SameSideStaggeredSlideRoute(super.builder,
      {this.curve = Curves.bounceOut,
      this.overlap = 0.0,
      Duration duration = const Duration(milliseconds: 700)})
      : super(transitionDuration: duration);

  Offset get entryOffset;

  Curve curve;
  final double overlap;

  @override
  Widget getEntryTransition(
      BuildContext context, Animation<double> animation, Widget child) {
    return SlideTransition(
      position: CurvedAnimation(
              parent: animation,
              curve: Interval(0.5 - (overlap / 2), 1.0, curve: curve))
          .drive(Tween(begin: entryOffset, end: Offset.zero)),
      child: child,
    );
  }

  @override
  Widget getExitTransition(
      BuildContext context, Animation<double> animation, Widget child) {
    return SlideTransition(
      position: CurvedAnimation(
              parent: animation,
              curve: Interval(0.0, 0.5 + (overlap / 2), curve: Curves.easeOut))
          .drive(Tween(begin: Offset.zero, end: entryOffset)),
      child: child,
    );
  }
}

abstract class StaggeredPushRoute extends CoordinatedPageRoute {
  StaggeredPushRoute(super.builder,
      {this.curve = Curves.easeInOut,
      this.overlap = 0.0,
      Duration duration = const Duration(milliseconds: 300)})
      : super(transitionDuration: duration);

  Offset get entryOffset;

  Curve curve;
  final double overlap;

  // TODO: Implement
  @override
  Widget getEntryTransition(
      BuildContext context, Animation<double> animation, Widget child) {
    return SlideTransition(
      position: CurvedAnimation(
              parent: animation,
              curve: Interval(0.5 - (overlap / 2), 1.0, curve: curve))
          .drive(Tween(begin: entryOffset, end: Offset.zero)),
      child: child,
    );
  }

  // TODO: Implement
  @override
  Widget getExitTransition(
      BuildContext context, Animation<double> animation, Widget child) {
    return SlideTransition(
      position: CurvedAnimation(
              parent: animation,
              curve: Interval(0.0, 0.5 + (overlap / 2), curve: curve))
          .drive(Tween(begin: Offset.zero, end: entryOffset)),
      child: child,
    );
  }
}

class UpDownStaggeredSlideRoute extends SameSideStaggeredSlideRoute {
  UpDownStaggeredSlideRoute(super.builder, {super.overlap});

  @override
  Offset get entryOffset => const Offset(0, -1);
}

class DownUpStaggeredSlideRoute extends SameSideStaggeredSlideRoute {
  DownUpStaggeredSlideRoute(super.builder, {super.overlap});

  @override
  Offset get entryOffset => const Offset(0, 1);
}
