import 'package:flutter/material.dart';
import 'package:flutter_bull/extensions/build_context.dart';
import 'package:flutter_bull/mixins/consumer.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/views/new/home/bar/auth_bar.dart';
import 'package:flutter_bull/src/views/new/home/home_main_buttons.dart';
import 'package:flutter_bull/src/views/new/notification_center.dart';
import 'package:flutter_bull/src/views/new/notifiers/app/app_event_notifier.dart';
import 'package:flutter_bull/src/views/new/notifiers/app/app_notifier.dart';
import 'package:flutter_bull/src/views/new/notifiers/auth_notifier.dart';
import 'package:flutter_bull/src/views/new/notifiers/camera_notifier.dart';
import 'package:flutter_bull/src/views/new/notifiers/states/camera_notifier_state.dart';
import 'package:flutter_bull/src/views/new/utter_bull.dart';
import 'package:flutter_bull/src/widgets/utter_bull_title.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> with MediaDimensions, ConsumerFunctions {

  bool get _keyboardVisible => MediaQuery.of(context).viewInsets.bottom != 0;

  void onNewSignUpPageState<T>(T? _, T? next) {
    if (next == SignUpPageState.open) {
      context.pushNamed('signUp');
      hideAuthBar();
    } else if (next == SignUpPageState.closed) {
      context.pop();
      showAuthBar();
    }
  }

  void onNewCameraViewState<T>(T? _, T? next) {
    if (next == CameraViewState.open) {
      context.pushNamed('camera');
      hideAuthBar();
    }
  }

  // void onCameraState<T>(T? _, T? next) {
  //   if (next == CameraState.ready) {
  //     context.pushNamed('camera');
  //     hideAuthBar();
  //   } else if (next == CameraState.closed) {
  //     context.pop();
  //     showAuthBar();
  //   }
  // }



  @override
  Widget build(BuildContext context) {

    ref.listen(
        appEventNotifierProvider
            .select((data) => data.valueOrNull?.newSignUpPageState), onNewSignUpPageState);

    ref.listen(
        appEventNotifierProvider.select(
            (value) => value.valueOrNull?.newCameraViewState), onNewCameraViewState);


    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox.fromSize(size: Size(width, height * 0.1)),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: AnimatedOpacity(
                    duration: Duration(milliseconds: 150),
                    opacity: _keyboardVisible ? 0.2 : 1.0,
                    child: UtterBullTitle()),
              ),
            ),
            Spacer()
          ],
        ),

        Scaffold(
          resizeToAvoidBottomInset: true,
          body: Column(
            children: [
              Expanded(
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    SizedBox(
                        width: width,
                        height: height * 0.5,
                        child: HomeMainButtons()),
                  ],
                ),
              ),
            ],
          ),
        )
        // Scaffold(
        //   resizeToAvoidBottomInset: true,
        //   body: SizedBox(
        //         width: width,
        //         child: Column(
        //           mainAxisAlignment: MainAxisAlignment.end,
        //           mainAxisSize: MainAxisSize.max,
        //           children: [
        //             Spacer(),
        //           Flexible(child: Container(color: Colors.red, child: HomeMainButtons()))
        //         ],)),
        // ),
      ],
    );
  }
  


}
