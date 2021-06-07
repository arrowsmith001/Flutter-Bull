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

class Avatar extends StatelessWidget{
  Avatar(this.image, 
      {this.borderFlashValue = 0, this.borderWidth = 5, this.loading = false, 
        this.defaultImage, this.size, this.shape = BoxShape.circle, this.borderRadius = 8.0, this.borderColor});
  final double borderFlashValue;
  final double borderWidth;
  final bool loading;
  final Image? image;
  final ImageProvider? defaultImage;
  final Size? size;
  final BoxShape shape;
  final double borderRadius;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {

    Widget loadingIndicator = MyLoadingIndicator(size);
    loadingIndicator = Container( decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle), child: loadingIndicator);
    if(size != null) loadingIndicator = loadingIndicator.SizedBoxExt(height: size!.height, width: size!.width);

    return Stack(
      children: [

        loadingIndicator,
        Container(
          height: size == null ? null : size!.height,
            width: size == null ? null : size!.width,
            decoration: BoxDecoration(
              //color: Color.fromARGB(101, 229, 220, 220),
                shape: shape,
                borderRadius: shape == BoxShape.rectangle ? BorderRadius.all(Radius.circular(borderRadius)) : null,
                border: Border.all(
                    color: Color.lerp(borderColor ?? Colors.blueAccent, Colors.white, borderFlashValue)!,
                    width: borderWidth),
                image: image == null && defaultImage == null ? null : DecorationImage(
                  colorFilter: loading ? ColorFilter.mode(Colors.white.withOpacity(0.5), BlendMode.lighten) : null,
                  fit: BoxFit.cover,
                  image: image == null ? defaultImage! : image!.image,
                ))
        ),


      ],
    );
  }
}

class MyBubble extends StatelessWidget {
  const MyBubble(this.text, {this.size});
  final String text;
  final Size? size;

  static const double DEFAULT_SIZE = 24;

  @override
  Widget build(BuildContext context) {
    return Bubble(
        nipOffset: 75,
        nipWidth: 15,
        nipHeight: 20,
        padding: BubbleEdges.all(4),
        margin: BubbleEdges.all(4),
        elevation: 0,
        nip: BubbleNip.leftTop,
        child: Container(
          height: size == null ? DEFAULT_SIZE : size!.height,
          child: Center(
            child: AutoSizeText(text,
                minFontSize: 16,
                textAlign:
                TextAlign.center,
                style: AppStyles.DebugStyle(32)),
          )
              .PaddingExt(EdgeInsets.all(8)),
        )
    );
  }
}
