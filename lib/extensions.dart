import 'package:flutter/cupertino.dart';
import 'dart:math' as math;

import 'package:flutter_bull/widgets.dart';

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

extension ListModifier<T> on List<T> {

  // Returns a new iterable with all elements shifted by m
  List<T> loop([int m = 0, bool backwards = false]){
    int n = this.length;
    if(n < 2) return new List<T>.from(this);
    int sign = backwards ? -1 : 1;
    return new List<T>.generate(n, (i) => this[(i - (sign * m)) % n]);
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

  // Wraps widget in a Padding widget with EdgeInsets.all value
  Widget PadAllExt([double value = 0.0]) {
    return this.PaddingExt(EdgeInsets.all(value));
  }

  // Wraps widget in a Padding widget with EdgeInsets.symmetric value
  Widget PadSymExt({double h = 0.0, double v = 0.0}) {
    return this.PaddingExt(EdgeInsets.symmetric(horizontal: h, vertical: v));
  }

  // Wraps widget in a Padding widget with EdgeInsets.symmetric value
  Widget PadOnlyExt({double left = 0.0, double top = 0.0, double right = 0.0, double bottom = 0.0, }) {
    return this.PaddingExt(EdgeInsets.only(left: left, top: top, right: right, bottom: bottom));
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

  // Wraps widget in a SizedBox widget
  Widget SizedBoxExt({double height = 50, double width = 50}) {
    return SizedBox(
      height: height, width: width,
      child: this,
    );
  }

  // Wraps widget in a Transform.scale widget
  Widget ScaleExt(double value) {
    return Transform.scale(
      scale: value,
      child: this,
    );
  }

  // Wraps widget in a Transform.translate widget
  Widget TranslateExt({double dx = 0, double dy = 0}) {
    return Transform.translate(
      offset: Offset(dx, dy),
      child: this,
    );
  }

  // Wraps widget in a Transform.rotate widget
  Widget RotateExt(double angle, [Offset origin = Offset.zero]) {
    return Transform.rotate(
      origin: origin,
      angle: angle,
      child: this,
    );
  }

  // Wraps widget in an Opacity widget
  Widget OpacityExt(double value) {
    return Opacity(
      opacity: value < 0.0 ? 0.0 : value > 1.0 ? 1.0 : value,
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

  // Wraps the widget in a Hero widget with a tag
  Widget HeroExt(Object tag) {
    return Hero(
      child: this,
      tag: tag
    );
  }

  // Returns this widget only if the condition is fulfilled, otherwise returns an EmptyWidget
  Widget EmptyUnless(bool condition){
    if(condition) return this;
    else return EmptyWidget();
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