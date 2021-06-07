import 'package:flutter/cupertino.dart';
import 'dart:math' as math;

extension StringModifier on String? {
  bool isNullOrEmpty() => this == null || this == '';
}

extension IterableModifier<T> on Iterable<T> {
  T? getRandom() {
    int length = this.length;
    if(length == 0) return null;
    int randomIndex = math.Random().nextInt(length);
    return this.toList(growable: false)[randomIndex];
  }

  List<T> getRandomSublist(int length){
    throw UnimplementedError();
    if(this.length <= length) return this.toList();
    if(length == 0) return [];
  }
}


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
  Widget RotateExt(double angle, [Offset origin = Offset.zero]) {
    return Transform.rotate(
      origin: origin,
      angle: angle,
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

  // Renders the widget invisible and nullifies all interactivity
  Widget HeroExt(Object tag) {
    return Hero(
      child: this,
      tag: tag
    );
  }


}

extension WidgetListModifier on List<Widget> {

  Widget ColumnExt({bool expand = false}){

    Widget out = Column(
      children: this,
    );

    if(expand) out = out.ExpandedExt();

    return out;
  }

}