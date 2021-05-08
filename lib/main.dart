import 'dart:async';
import 'dart:typed_data';
import 'dart:math' as math;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bull/gen/assets.gen.dart';
import 'package:flutter_bull/pages/1MainMenu/background.dart';
import 'package:flutter_bull/pages/1MainMenu/title.dart';
import 'package:flutter_bull/particles.dart';
import 'package:flutter_bull/resources.dart';
import 'package:flutter_bull/utilities.dart';
import 'extensions.dart';
import 'dart:ui' as ui;
import 'package:image/image.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

   @override
    Widget build(BuildContext context) {

     ResourceManager rm = new ResourceManager();
     return StreamBuilder<double>(
         stream: rm.loadAllResources(),
         builder: (ctx, snap){

           if(!snap.hasData || snap.data != 1.0) {

             double value = snap.data??0;

             int progress = (100 * value).round();
             return Center(
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           CircularProgressIndicator(value: snap.data??0),
                           Text(progress.toString() + "%", textDirection: TextDirection.ltr)
                         ],
                       ).ExpandedExt()
                     ],
                   ),
                 );
           }

           return CupertinoApp(
             title: 'Flutter Bull',
             theme: CupertinoThemeData(
                 primaryColor: AppColors.MainColor
             ),
             home: MainMenu(),
           );

         });

  }
}


class MainMenu extends StatefulWidget {

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {

  @override
  Widget build(BuildContext context) {


    var primaryColor = CupertinoTheme.of(context).primaryColor;
    var fadedPrimaryColor = ui.Color.lerp(primaryColor, Colors.white, 0.2)!;
    var darkenedPrimaryColor = ui.Color.lerp(primaryColor, Colors.black, 0.2)!;

    var offset = 0.04;
    var backgroundDecoration = new BoxDecoration(
        gradient: LinearGradient(
            colors: [
              fadedPrimaryColor,
              primaryColor,
              primaryColor,
              fadedPrimaryColor
            ],
            stops: [
              0, offset, 1-offset, 1
            ]));

    // Button vars
    var buttonIconSize = 65.0;
    var minFontSize = 10.0;
    var fontSize = 30.0;

    var CreateGameButton = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        AutoSizeText("CREATE GAME", minFontSize: minFontSize, maxLines: 2, textAlign: TextAlign.end, style: AppStyles.MainMenuButtonTextStyle(fontSize)).FlexibleExt(),
        Assets.images.bullAddGlowBrown.image().SizedBoxExt(height: buttonIconSize, width: buttonIconSize).PaddingExt(new EdgeInsets.fromLTRB(15,5,15,5)).FlexibleExt()
      ],
    );

    var JoinGameButton = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        AutoSizeText("JOIN GAME", minFontSize: minFontSize, maxLines: 2, textAlign: TextAlign.end, style: AppStyles.MainMenuButtonTextStyle(fontSize)).FlexibleExt(),
        Assets.images.arrowsGlowBrownEdit.image().SizedBoxExt(height: buttonIconSize, width: buttonIconSize).PaddingExt(new EdgeInsets.fromLTRB(15,5,15,5)).FlexibleExt()
      ],
    );

    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [

              MainMenuBackgroundEffect(),

              Column(
                children: [

                  Column(

                  ).FlexibleExt(1),

                  Column(
                    children: [
                      UtterBullTitle()
                    ]

                  ).FlexibleExt(2),

                  Row(
                    children: [
                      Column(

                        mainAxisAlignment: MainAxisAlignment.end,

                        children: [

                          CreateGameButton,

                          JoinGameButton,

                        ],

                      ).PaddingExt(new EdgeInsets.fromLTRB(0,0,0,25)).FlexibleExt()
                    ],
                  ).ExpandedExt()

                ],
              )
            ],
          )


      ).BoxDecorationContainerExt(backgroundDecoration),
    );

  }
}



