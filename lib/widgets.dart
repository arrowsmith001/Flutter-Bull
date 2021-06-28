import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bubble/bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bull/gen/fonts.gen.dart';
import 'package:flutter_bull/utilities/local_res.dart';
import 'classes/classes.dart';
import 'package:extensions/extensions.dart';
import 'gen/assets.gen.dart';

class MyLoadingIndicator extends StatefulWidget {
  MyLoadingIndicator([this.size = DEFAULT_LOADING_SIZE]);

  static const Size DEFAULT_LOADING_SIZE = const Size(50, 50);

  Size size;

  @override
  _MyLoadingIndicatorState createState() => _MyLoadingIndicatorState();
}

class _MyLoadingIndicatorState extends State<MyLoadingIndicator> with SingleTickerProviderStateMixin {

  static const Duration SPIN_DURATION = const Duration(seconds: 1);
  static const Curve SPIN_CURVE = Curves.easeInOut;

  late AnimationController _animController = new AnimationController(vsync: this, duration: SPIN_DURATION);
  late Animation<double> animation = new CurvedAnimation(parent: _animController, curve: SPIN_CURVE);

  @override
  void initState() {
    super.initState();
    _animController.repeat();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  Size get size => widget.size;


  @override
  Widget build(BuildContext context) {

    return Center(
      child: Assets.images.loadingArrows.image(width: size.width, height: size.height)
      .xRotate(pi*2*animation.value),
    );
  }
}


class Avatar extends StatelessWidget{
  Avatar(this.image,
      {this.borderFlashValue = 0, this.borderWidth = 5, this.loading = false,
        this.defaultImage, this.size = const Size(100, 100), this.shape = BoxShape.circle,
        this.borderRadius = 8.0, this.borderColor, this.clippedRectRadius});

  final double borderFlashValue;
  final double borderWidth;
  final bool loading;
  final Image? image;
  final ImageProvider? defaultImage;
  final Size size;
  final BoxShape shape;
  final double borderRadius;
  final Color? borderColor;
  final double? clippedRectRadius;

  static const Color DEFAULT_BORDER_COLOR = Colors.blueAccent;

  @override
  Widget build(BuildContext context) {

    Widget loadingIndicator = MyLoadingIndicator(new Size(size.width*0.5, size.height*0.5));
    loadingIndicator = Container( decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle), child: loadingIndicator);
    if(size != null) loadingIndicator = Container(child: loadingIndicator, width: size.width, height: size.height);

    //if(image == null) return EmptyWidget();

    return SizedBox(
      height: size.height,
      width: size.width,
      child: Stack(
        children: [

          Center(child: loadingIndicator),

          image == null ? EmptyWidget() :
          Center(
            child: AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(clippedRectRadius ?? 0),
                clipBehavior: Clip.hardEdge,
                child: Container(
                    height: size.height,
                    width: size.width,
                    decoration: BoxDecoration(
                      //color: Color.fromARGB(101, 229, 220, 220),
                        shape: clippedRectRadius == null ? shape : BoxShape.rectangle,
                        borderRadius: shape == BoxShape.rectangle ? BorderRadius.all(Radius.circular(borderRadius)) : null,
                        border: Border.all(
                            color: Color.lerp(borderColor ?? DEFAULT_BORDER_COLOR, Colors.white, borderFlashValue)!,
                            width: borderWidth
                        ),
                        image: DecorationImage(
                          colorFilter: loading ? ColorFilter.mode(Colors.white.withOpacity(0.5), BlendMode.lighten) : null,
                          fit: BoxFit.fill,
                          image: image == null ? Assets.images.bullImgTransparent : image!.image,
                        ))
                ),
              ),
            ),
          ),


        ],
      ),
    );
  }
}

class MyBubble extends StatelessWidget {
  const MyBubble(this.text, {this.size, this.nip = BubbleNip.leftTop});
  final String text;
  final Size? size;
  final BubbleNip nip;

  static const double DEFAULT_SIZE = 24;

  @override
  Widget build(BuildContext context) {
    return Bubble(
        color: Colors.white.withOpacity(0.7),
        nipOffset: 75,
        nipWidth: 15,
        nipHeight: 20,
        padding: BubbleEdges.all(4),
        margin: BubbleEdges.all(4),
        elevation: 0,
        nip: nip,
        child: Container(
          height: size == null ? DEFAULT_SIZE : size!.height,
          child: Center(
            child: AutoSizeText(text,
                minFontSize: 16,
                textAlign:
                TextAlign.center,
                style: AppStyles.defaultStyle(fontSize: 32, color: Colors.black)),
          )
              .xPadding(EdgeInsets.all(8)),
        )
    );
  }
}

class MyCupertinoStyleDialog extends StatelessWidget {

  const MyCupertinoStyleDialog(this.columnChildren,
      {this.borderRadius = MyBorderRadii.ALL, this.outsidePadding = const EdgeInsets.all(PADDING)});

  final List<Widget> columnChildren;
  static const double PADDING = 40.0;
  final BorderRadius borderRadius;
  final EdgeInsets outsidePadding;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.85),
              shape: BoxShape.rectangle,
              borderRadius: borderRadius),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:  columnChildren,
          ),
        )
    ).xPadding(outsidePadding);
  }
}

class MyCupertinoStyleDialogWithButtons extends StatelessWidget {
  MyCupertinoStyleDialogWithButtons(
      {required this.columnChildren, required this.buttons,
        this.flexList}){
  }

  final List<Widget> columnChildren;
  List<int>? flexList;
  final List<Widget> buttons;

  @override
  Widget build(BuildContext context) {
    double p = MyCupertinoStyleDialog.PADDING;
    return Center(
        child: Column(
          children: [

            MyCupertinoStyleDialog(columnChildren, borderRadius: MyBorderRadii.TOP_ONLY, outsidePadding: EdgeInsets.only(top:p,left:p,right:p),).xExpanded(),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                buttons[0].xPadding(EdgeInsets.only(top: 8, right: 4)).xFlexible(flexList == null ? 1 : flexList![0]),

                buttons[1].xPadding(EdgeInsets.only(top: 8, left: 4)).xFlexible(flexList == null ? 1 : flexList![1]),
              ],
            ).xPadding(EdgeInsets.only(bottom:p,left:p,right:p))


          ],
        )
    );
  }
}

class MyCupertinoStyleButton extends StatelessWidget {

  BorderRadius borderRadius;
  Widget text;
  dynamic Function()? onPressed;
  Color color;
  double value;
  Alignment glowPosition;
  double? height;


  MyCupertinoStyleButton({
    this.borderRadius = MyBorderRadii.ALL,
    this.text = const Text('Press Me'),
    required this.onPressed,
    this.color = Colors.white,
    this.value = 1.0,
    this.glowPosition = Alignment.center,
    this.height
  });

  @override
  Widget build(BuildContext context) {
    Widget button = CupertinoButton(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        borderRadius: borderRadius,
        //color: color,
        onPressed: onPressed,
        child: text
    );

    button = button.xBoxDecorContainer(
        BoxDecoration(
            gradient: RadialGradient(
                colors: [Colors.white, color],
                stops: [0, 0.15],
                radius: 0,//2,
                focal: glowPosition
            ),
            //boxShadow: [BoxShadow(color: Colors.white, blurRadius: 8*value)],
            borderRadius: borderRadius,
            border: Border.all(color: Colors.black26.withOpacity(0.2), width: 1)
        ));

    if(height != null) button = button.xSizedBox(height: height!);

    return Row(
      children: [
        button.xExpanded()
      ],
    );
  }
}

class MyCupertinoStyleBox extends StatelessWidget {
  MyCupertinoStyleBox({required this.content, this.borderRadius = MyBorderRadii.NONE});
  final Widget content;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: borderRadius),
          child: Center(
            child: content,
          ),
        ).xExpanded(),
      ],
    );
  }
}

class MyListItem extends StatelessWidget {
  const MyListItem({this.text = 'Your text here', this.iconData = Icons.circle, required this.onTap});
  final String text;
  final IconData iconData;
  final dynamic Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [

            Container(
              child: Text(text,
                textAlign: TextAlign.end,
                style: TextStyle(fontSize: 26, fontFamily: FontFamily.lapsusProBold),)
                  .xPadding(EdgeInsets.symmetric(vertical: 8, horizontal: 18)),
            )
                .xFlexible(),

            Container(
              width: 50,
              child: Icon(iconData, size: 50, color: Colors.black,),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
              color: Colors.blue),
            )


          ],
        ),
        decoration: BoxDecoration(
            color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(100))
        ),
      ),
    );
  }
}


class BlueExpandedContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.blue).xExpanded();
  }
}
class YellowExpandedContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.yellow).xExpanded();
  }
}
class RedExpandedContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.red).xExpanded();
  }
}
class GreenExpandedContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.green).xExpanded();
  }
}

List<Widget> ColumnChildrenTest() => [
  BlueExpandedContainer(), RedExpandedContainer(), YellowExpandedContainer()
];