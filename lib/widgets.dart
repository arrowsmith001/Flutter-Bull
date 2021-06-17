import 'package:auto_size_text/auto_size_text.dart';
import 'package:bubble/bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bull/gen/fonts.gen.dart';
import 'package:flutter_bull/utilities/local_res.dart';
import 'classes/classes.dart';
import 'extensions.dart';
import 'gen/assets.gen.dart';

class MyLoadingIndicator extends StatelessWidget {
  MyLoadingIndicator([this.size]);

  Size? size;

  @override
  Widget build(BuildContext context) {

    Widget loading = Center(
      child: CircularProgressIndicator(),
    );

    if(size != null) loading = loading.SizedBoxExt(height: size!.height, width: size!.width);

    return loading;
  }
}


class Avatar extends StatelessWidget{
  Avatar(this.image,
      {this.borderFlashValue = 0, this.borderWidth = 5, this.loading = false,
        this.defaultImage, this.size, this.shape = BoxShape.circle, this.borderRadius = 8.0, this.borderColor, this.clippedRectRadius});
  final double borderFlashValue;
  final double borderWidth;
  final bool loading;
  final Image? image;
  final ImageProvider? defaultImage;
  final Size? size;
  final BoxShape shape;
  final double borderRadius;
  final Color? borderColor;
  final double? clippedRectRadius;

  static const Color DEFAULT_BORDER_COLOR = Colors.blueAccent;

  @override
  Widget build(BuildContext context) {

    Widget loadingIndicator = MyLoadingIndicator(size);
    loadingIndicator = Container( decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle), child: loadingIndicator);
    if(size != null) loadingIndicator = Container(child: loadingIndicator, width: size!.width, height: size!.height);

    //if(image == null) return EmptyWidget();

    return SizedBox(
      height: size?.height,
      width: size?.width,
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
                    height: size == null ? null : size!.height,
                    width: size == null ? null : size!.width,
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
                          fit: BoxFit.contain,
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
              .PaddingExt(EdgeInsets.all(8)),
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
    ).PaddingExt(outsidePadding);
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

            MyCupertinoStyleDialog(columnChildren, borderRadius: MyBorderRadii.TOP_ONLY, outsidePadding: EdgeInsets.only(top:p,left:p,right:p),).ExpandedExt(),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                buttons[0].PaddingExt(EdgeInsets.only(top: 8, right: 4)).FlexibleExt(flexList == null ? 1 : flexList![0]),

                buttons[1].PaddingExt(EdgeInsets.only(top: 8, left: 4)).FlexibleExt(flexList == null ? 1 : flexList![1]),
              ],
            ).PaddingExt(EdgeInsets.only(bottom:p,left:p,right:p))


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

    button = button.BoxDecorationContainerExt(
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

    if(height != null) button = button.SizedBoxExt(height: height!);

    return Row(
      children: [
        button.ExpandedExt()
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
        ).ExpandedExt(),
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
                  .PaddingExt(EdgeInsets.symmetric(vertical: 8, horizontal: 18)),
            )
                .FlexibleExt(),

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



class EmptyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox.shrink();
  }
}

class BlueExpandedContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.blue).ExpandedExt();
  }
}
class YellowExpandedContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.yellow).ExpandedExt();
  }
}
class RedExpandedContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.red).ExpandedExt();
  }
}
class GreenExpandedContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.green).ExpandedExt();
  }
}

List<Widget> ColumnChildrenTest() => [
  BlueExpandedContainer(), RedExpandedContainer(), YellowExpandedContainer()
];