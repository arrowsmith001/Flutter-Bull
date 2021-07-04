import 'package:auto_size_text/auto_size_text.dart';
import 'package:bubble/bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bull/gen/assets.gen.dart';
import 'package:extensions/extensions.dart';
import '../utilities/local_res.dart';
import '../widgets/misc.dart';

class MainMenuButton extends StatelessWidget {

  MainMenuButton(this.text, this.image, this.onPressed, {this.fontSize = 16, this.minFontSize = 16, this.imageSize = 16, this.fontColor = Colors.white});

  String text;
  Widget image;
  double fontSize;
  double minFontSize;
  double imageSize;
  Color fontColor;
  Widget? secondChild;

  dynamic Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.1, 0.3, 0.65, 0.85],
                  colors: [Colors.white, Colors.white,Colors.white, Colors.grey]).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),

              child: AutoSizeText(text, minFontSize: minFontSize, maxLines: 1, textAlign: TextAlign.end, style: AppStyles.MainMenuButtonTextStyle(fontSize, fontColor)))
                .xFlexible(),

          image.xSizedBox(height: imageSize, width: imageSize).xPadding(new EdgeInsets.fromLTRB(15,3,15,3)).xFlexible()
        ],
      ),
    );
  }
}


class MyClass extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Title 1'),
                )
            ),
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Title 2'),
                )
            ),
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Title 3'),
                )
            ),
          ],
        ),
      ),
    );
  }
}

class MyClass2 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: [
              Text('Title 1').xPadAll(8).xExpanded(),
              Text('Title 2').xPadAll(8).xExpanded(),
              Text('Title 3').xPadAll(8).xExpanded(),
            ].xColumn()
      ),
    );
  }
}


