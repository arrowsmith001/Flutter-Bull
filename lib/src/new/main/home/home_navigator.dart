import 'package:coordinated_page_route/coordinated_page_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bull/src/new/main/camera_view.dart';
import 'package:flutter_bull/src/new/main/auth/sign_up_email_view.dart';
import 'package:flutter_bull/src/new/main/home/home_view.dart';
import 'package:flutter_bull/src/new/notifiers/app/app_state_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class HomeNavigator extends ConsumerStatefulWidget {
  const HomeNavigator({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeNavigatorState();
}

class _HomeNavigatorState extends ConsumerState<HomeNavigator> {

  @override
  void initState() {
    super.initState();
    _navKey = GlobalKey<NavigatorState>();
  }

  late final GlobalKey<NavigatorState> _navKey;


  @override
  Widget build(BuildContext context) {
    void onCloseSignUpPage() {
      ref
          .read(appStateNotifierProvider.notifier)
          .setSignUpPageState(SignUpPageState.closed);
    }

    return Navigator(
      key: _navKey,
      observers: [CoordinatedRouteObserver(), HeroController()],
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    HomeView());
          case 'signUp':
            return PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 750),
                pageBuilder: (context, animation, secondaryAnimation) {
                  return SlideTransition(
                      position: CurvedAnimation(
                              parent: animation, curve: Curves.easeInOut)
                          .drive(Tween(begin: Offset(0, 1), end: Offset.zero)),
                      child: Stack(children: [
                        GestureDetector(
                          onTap: () => onCloseSignUpPage(),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 24.0, right: 24.0, top: 100.0),
                          child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(24.0),
                                  topRight: Radius.circular(24.0)),
                              child: SignUpEmailView()),
                        )
                      ]));
                });

          case 'camera':
            return PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 750),
                pageBuilder: (context, animation, secondaryAnimation) {
                  return SlideTransition(
                      position: CurvedAnimation(
                              parent: animation, curve: Curves.easeInOut)
                          .drive(Tween(begin: Offset(0, 1), end: Offset.zero)),
                      child: CameraView());
                });
        }
      },
    );
  }
}
