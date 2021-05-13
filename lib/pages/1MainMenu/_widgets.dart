import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../extensions.dart';
import '../../utilities/localRes.dart';

class MainMenuButton extends StatelessWidget {

  MainMenuButton(this.text, this.image, this.callback, {this.fontSize = 16, this.minFontSize = 16, this.imageSize = 16});

  String text;
  Widget image;
  double fontSize;
  double minFontSize;
  double imageSize;

  void Function() callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        callback.call();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.1, 0.3, 0.65, 0.85],
                  colors: [Colors.white, Colors.white,Colors.white, Colors.grey]).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),

              child: AutoSizeText(text, minFontSize: minFontSize, maxLines: 2, textAlign: TextAlign.end, style: AppStyles.MainMenuButtonTextStyle(fontSize)))
                .FlexibleExt(),

          image.SizedBoxExt(height: imageSize, width: imageSize).PaddingExt(new EdgeInsets.fromLTRB(15,3,15,3)).FlexibleExt()
        ],
      ),
    );
  }
}