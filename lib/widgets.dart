import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'classes.dart';
import 'extensions.dart';


class MyCupertinoStyleDialog extends StatelessWidget {

  const MyCupertinoStyleDialog(this.columnChildren,
      {this.borderRadius = MyBorderRadii.ALL, this.outsidePadding = const EdgeInsets.all(PADDING)});

  final List<Widget> columnChildren;
  static const DIALOG_BORDER_RADIUS = 10.0;
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
  dynamic Function() onPressed;
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
                radius: 2,
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