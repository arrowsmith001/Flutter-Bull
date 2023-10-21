import 'package:coordinated_page_route/coordinated_page_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bull/src/custom/extensions/riverpod_extensions.dart';
import 'package:flutter_bull/src/custom/widgets/controlled_navigator.dart';
import 'package:flutter_bull/src/navigation/navigation_controller.dart';
import 'package:flutter_bull/src/views/new/notifiers/auth_notifier.dart';
import 'package:flutter_bull/src/views/new/notifiers/states/auth_notifier_state.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/views/1_auth/login_view.dart';
import 'package:flutter_bull/src/views/1_auth/main_view.dart';
import 'package:flutter_bull/src/views/new/home/auth/sign_up_email_view.dart';
import 'package:flutter_bull/src/widgets/common/error_popup.dart';
import 'package:flutter_bull/src/widgets/common/loading_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class AuthContainer extends ConsumerStatefulWidget {
  const AuthContainer({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthContainerState();
}

class _AuthContainerState extends ConsumerState<AuthContainer> {
  final _navController = AuthNavigationController();

  void onUserIdChanged(String? prev, String? next) {
    Logger().d('prev: $prev, next: $next');

    if (next != null) {
      _navController.navigateToMain(next);
    } else {
      _navController.navigateToLogin();
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<String?>(
        authNotifierProvider.select((stateAsync) => stateAsync.value?.userId),
        onUserIdChanged);

    final asyncData = ref.watch(authNotifierProvider);

    final Widget main = asyncData.when(
      data: (data) => ControlledNavigator(
          observers: [CoordinatedRouteObserver()],
          controller: _navController,
          data: data),

      //data: (e) => ErrorPopup(e.toString(), escape: () => Logger().d("message"),),
      loading: () => LoadingWidget(),
      error: (e, _) => ErrorPopup(
        e.toString(),
        escape: () => _onEscapeError(),
      ),
    );

    return Scaffold(body: main);
  }

  void _onEscapeError() {
    _navController.navigateToLogin();
  }
}

class AuthNavigationController extends NavigationController<AuthNotifierState> {
  static const String loginRoute = 'login';
  static String mainRoute(String userId) => 'main/$userId';

  void navigateToLogin() => navigateTo(loginRoute);

  void navigateToMain(String signedInUserId) =>
      navigateTo(mainRoute(signedInUserId));

  @override
  Route get defaultRoute => throw UnimplementedError();

  @override
  String generateInitialRoute(AuthNotifierState data) {
    if (data.userId == null) {
      return loginRoute;
    } else {
      return mainRoute(data.userId!);
    }
  }

  @override
  PageRoute? generateRoute() {
    switch (nextRoutePath) {
      case 'login':
        return BackwardPushRoute((_) => const LoginView());

      case 'main':
        final userId = nextRoutePath;
        final userOverride =
            getSignedInPlayerIdProvider.overrideWithValue(userId);
        return ForwardPushRoute(
            (_) => ProviderScope(overrides: [userOverride], child: MainView()));
    }

    return null;
  }
}
