import 'package:coordinated_page_route/coordinated_page_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bull/gen/assets.gen.dart';
import 'package:flutter_bull/src/custom/widgets/controlled_navigator.dart';
import 'package:flutter_bull/src/navigation/coordinated_routes/swap_route.dart';
import 'package:flutter_bull/src/navigation/navigation_controller.dart';
import 'package:flutter_bull/src/notifiers/auth_notifier.dart';
import 'package:flutter_bull/src/notifiers/states/auth_notifier_state.dart';
import 'package:flutter_bull/src/widgets/common/error_popup.dart';
import 'package:flutter_bull/src/widgets/common/loading_widget.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  AuthNotifier get authNotifier => ref.read(authNotifierProvider.notifier);

  final _navController = LoginNavigationController();

  @override
  Widget build(BuildContext context) {

    ref.listen(authNotifierProvider.select((value) => value), (prev, next) {

      final wasLoading = prev?.isLoading ?? false;
      final isLoading = next.isLoading;

      Logger().d(wasLoading.toString() +
          " " +
          isLoading.toString() +
          " " +
          next.toString());

      if (!wasLoading && isLoading) {
        _navController.navigateToLoading(next.valueOrNull?.message);
      }
    });

    final asyncData = ref.watch(authNotifierProvider);

    return asyncData.when(
      data: (data) => ControlledNavigator(
          observers: [CoordinatedRouteObserver()],
          controller: _navController,
          data: data),
      loading: () => LoadingWidget(),
      error: (e, _) => ErrorPopup(
        e.toString(),
        escape: () => Logger().d("message"),
      ),
    );
  }
}

class LoginNavigationController
    extends NavigationController<AuthNotifierState> {
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
        return SwapRoute((context) => const LoginOptionsView());
      case 'loading':
        return SwapRoute((context) {
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

class LoginOptionsView extends ConsumerStatefulWidget {
  const LoginOptionsView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LoginOptionsViewState();
}

class _LoginOptionsViewState extends ConsumerState<LoginOptionsView> {
  static const double buttonPadding = 16.0;

  AuthNotifier get authNotifier => ref.read(authNotifierProvider.notifier);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
            flex: 1,
            child: Text("Welcome!",
                style: Theme.of(context).textTheme.headlineLarge)),
        Flexible(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(buttonPadding),
                  child: UtterBullButton(
                      title: "Sign up with email",
                      onPressed: null, // () => _onSignUpWithEmail(),
                      leading: Assets.images.at.image()),
                ),
                Padding(
                  padding: const EdgeInsets.all(buttonPadding),
                  child: UtterBullButton(
                      title: "Sign up with Google",
                      onPressed: null, // () => _onSignUpWithGoogle(),
                      leading: Assets.images.google.image()),
                ),
                Padding(
                  padding: const EdgeInsets.all(buttonPadding * 2),
                  child: UtterBullButton(
                      title: "Continue as guest",
                      onPressed: () => _onContinueAsGuest()),
                ),
              ],
            ))
      ],
    );
  }

  void _onSignUpWithEmail() {}

  void _onSignUpWithGoogle() {}

  Future<void> _onContinueAsGuest() async {
    await authNotifier.signIn();
  }
}
