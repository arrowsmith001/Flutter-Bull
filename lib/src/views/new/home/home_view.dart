import 'package:flutter/material.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/views/new/home/bar/auth_bar.dart';
import 'package:flutter_bull/src/views/new/home/home_main_buttons.dart';
import 'package:flutter_bull/src/views/new/utter_bull.dart';
import 'package:flutter_bull/src/widgets/utter_bull_title.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'bar/auth_bar_container.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> with MediaDimensions {

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        SizedBox.fromSize(
            size: Size(width, height * 0.1)),
        
        Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: UtterBullTitle(),
        ),
        ),

        Expanded(
        child: SizedBox.fromSize(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(child: HomeMainButtons()),
            ],
          ),
        ),
        )
      ],
    );
  }
}
