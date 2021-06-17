import 'package:auto_size_text/auto_size_text.dart';
import 'package:bubble/bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bull/gen/assets.gen.dart';
import '../extensions.dart';
import '../utilities/local_res.dart';
import '../widgets.dart';

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
                .FlexibleExt(),

          image.SizedBoxExt(height: imageSize, width: imageSize).PaddingExt(new EdgeInsets.fromLTRB(15,3,15,3)).FlexibleExt()
        ],
      ),
    );
  }
}


