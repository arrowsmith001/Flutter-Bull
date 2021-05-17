import 'package:flutter/cupertino.dart';

// Some modifiers for Widgets just to tidy up the code
extension WidgetModifier on Widget {

  // Wraps widget in a Padding widget
  Widget PaddingExt([EdgeInsetsGeometry value = const EdgeInsets.all(16)]) {
    return Padding(
      padding: value,
      child: this,
    );
  }

  // Wraps widget in an Align widget
  Widget AlignExt([Alignment alignment = Alignment.center]) {
    return Align(
      alignment: alignment,
      child: this,
    );
  }

  // Wraps widget in a Flexible widget
  Widget FlexibleExt([int flex = 1]) {
    return Flexible(
      flex: flex,
      child: this,
    );
  }
  // Wraps widget in an Expanded widget
  Widget ExpandedExt() {
    return Expanded(
      child: this,
    );
  }

  // Wraps widget in a Container widget with a color
  Widget ColoredContainerExt(Color color) {
    return Container(
      color: color,
      child: this,
    );
  }

  // Wraps widget in a Container widget with a Box Decoration
  Widget BoxDecorationContainerExt(BoxDecoration boxDecoration) {
    return Container(
      decoration: boxDecoration,
      child: this,
    );
  }

  // Wraps widget in a Container widget with a Box Decoration
  Widget SizedBoxExt({double height = 50, double width = 50}) {
    return SizedBox(
      height: height, width: width,
      child: this,
    );
  }

  // Wraps widget in a Container widget with a Box Decoration
  Widget ScaleExt(double value) {
    return Transform.scale(
      scale: value,
      child: this,
    );
  }

  // Wraps widget in a Container widget with a Box Decoration
  Widget TranslateExt({double dx = 0, double dy = 0}) {
    return Transform.translate(
      offset: Offset(dx, dy),
      child: this,
    );
  }

  // Wraps widget in a Container widget with a Box Decoration
  Widget OpacityExt(double value) {
    return Opacity(
      opacity: value,
      child: this,
    );
  }

  // Renders the widget invisible and nullifies all interactivity
  Widget InvisibleIgnoreExt() {
    return Visibility(
      visible: false,
        maintainSize: true,
        maintainAnimation: true,
        maintainState: true,
        child: IgnorePointer(
            child: this));
  }


}
