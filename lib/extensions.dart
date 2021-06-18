import 'package:flutter/cupertino.dart';
import 'dart:math' as math;


extension StringModifier on String? {
  bool isNullOrEmpty() => this == null || this == '';
}

extension IterableModifier<T> on Iterable<T> {

  // Get a random item from the provided iterable
  T? getRandom() {
    int length = this.length;
    if(length == 0) return null;
    if(length == 1) return this.single;
    int randomIndex = math.Random().nextInt(length);
    return this.toList(growable: false)[randomIndex];
  }

  // Get a random sublist of the provided iterable (if ofLength is null, sublist length will also be randomized)
  List<T> getRandomSublist([int? ofLength]){
    List<T> out = [];
    int length = this.length;

    if(ofLength == 0 || length == 0) return out;
    if(length == 1) return [this.single];

    if(ofLength == null) ofLength = math.Random().nextInt(length);
    else ofLength = math.min(ofLength, length);

    List<T> list = List.from(this);
    while(ofLength! > 0)
      {
        T element = list.getRandom()!;
        out.add(element);
        list.remove(element);
        ofLength--;
      }

    return out;
  }
}

extension ListModifier<T> on List<T> {

  // Returns a new iterable with all elements shifted by m i.e. [a, b, c].loop(1) => [c, a, b]
  List<T> loop([int m = 0, bool backwards = false]){
    int n = this.length;
    if(n <= 1) return new List<T>.from(this);
    int sign = backwards ? -1 : 1;
    return new List<T>.generate(n, (i) => this[(i - (sign * m)) % n]);
  }

}


// Some modifiers for Widgets just to tidy up the code
extension WidgetModifier on Widget {

  // Wraps widget in a Padding widget
  Widget xPadding([EdgeInsetsGeometry value = const EdgeInsets.all(16)]) {
    return Padding(
      padding: value,
      child: this,
    );
  }

  // Wraps widget in a Padding widget with EdgeInsets.all value
  Widget xPadAll([double value = 0.0]) {
    return this.xPadding(EdgeInsets.all(value));
  }

  // Wraps widget in a Padding widget with EdgeInsets.symmetric value
  Widget xPadSym({double h = 0.0, double v = 0.0}) {
    return this.xPadding(EdgeInsets.symmetric(horizontal: h, vertical: v));
  }

  // Wraps widget in a Padding widget with EdgeInsets.symmetric value
  Widget xPadOnly({double left = 0.0, double top = 0.0, double right = 0.0, double bottom = 0.0, }) {
    return this.xPadding(EdgeInsets.only(left: left, top: top, right: right, bottom: bottom));
  }

  // Wraps widget in an Align widget
  Widget xAlign([Alignment alignment = Alignment.center]) {
    return Align(
      alignment: alignment,
      child: this,
    );
  }

  // Wraps widget in a Flexible widget
  Widget xFlexible([int flex = 1]) {
    return Flexible(
      flex: flex,
      child: this,
    );
  }
  // Wraps widget in an Expanded widget
  Widget xExpanded() {
    return Expanded(
      child: this,
    );
  }

  // Wraps widget in a Container widget with a color
  Widget xColoredContainer(Color color) {
    return Container(
      color: color,
      child: this,
    );
  }

  // Wraps widget in a Container widget with a Box Decoration
  Widget xBoxDecorContainer(BoxDecoration boxDecoration) {
    return Container(
      decoration: boxDecoration,
      child: this,
    );
  }

  // Wraps widget in a SizedBox widget
  Widget xSizedBox({double height = 50, double width = 50}) {
    return SizedBox(
      height: height, width: width,
      child: this,
    );
  }

  // Wraps widget in a Transform.scale widget
  Widget xScale(double value) {
    return Transform.scale(
      scale: value,
      child: this,
    );
  }

  // Wraps widget in a Transform.translate widget
  Widget xTranslate({double dx = 0, double dy = 0}) {
    return Transform.translate(
      offset: Offset(dx, dy),
      child: this,
    );
  }

  // Wraps widget in a Transform.rotate widget
  Widget xRotate(double angle, [Offset origin = Offset.zero]) {
    return Transform.rotate(
      origin: origin,
      angle: angle,
      child: this,
    );
  }

  // Rotates and then translates widget
  Widget xRotateTranslate(double angle, {double dx = 0, double dy = 0} ) {
    return this.xRotate(angle).xTranslate(dx: dx, dy: dy);
  }

  // Wraps widget in an Opacity widget
  Widget xOpacity(double value) {
    return Opacity(
      opacity: value < 0.0 ? 0.0 : value > 1.0 ? 1.0 : value,
      child: this,
    );
  }

  // Renders the widget invisible and nullifies all interactivity, but maintains spacing
  Widget xInvisibleIgnore() {
    return Visibility(
        visible: false,
        maintainSize: true,
        maintainAnimation: true,
        maintainState: true,
        child: IgnorePointer(
            child: this));
  }

  // Wraps the widget in a Hero widget with a tag
  Widget xHero(Object tag) {
    return Hero(child: this, tag: tag);
  }

  // Returns this widget only if the condition is fulfilled, otherwise returns an EmptyWidget
  Widget xEmptyUnless(bool condition){
    return condition ? this : EmptyWidget();
  }

  // Returns a stack of this and the provided widget
  Widget xStackThis(Widget toStack, [Alignment alignment = Alignment.center]){
    return [this].xStackThis(toStack, alignment);
  }

  // Returns a stack of this and the provided widgets
  Widget xStackThese(List<Widget> toStack, [Alignment alignment = Alignment.center]){
    return [this].xStackThese(toStack, alignment);
  }

}

extension WidgetListModifier on List<Widget> {

  // Returns Row with provided widgets as children
  Widget xRow({bool expandChildren = false, MainAxisAlignment mainAxisAlign = MainAxisAlignment.start}){
    List<Widget> children;
    if(!expandChildren) children = this;
    else children = List.from(this).map<Widget>((w) => w.xExpanded()).toList(growable: false);
    return Row(mainAxisAlignment: mainAxisAlign, children: children);
  }

  // Returns Column with provided widgets as children
  Widget xColumn({bool expandChildren = false, MainAxisAlignment mainAxisAlign = MainAxisAlignment.start}){
    List<Widget> children;
    if(!expandChildren) children = this;
    else children = List.from(this).map<Widget>((w) => w.xExpanded()).toList(growable: false);
    return Column(mainAxisAlignment: mainAxisAlign, children: children);
  }

  // Returns a stack of these
  Widget xStack([Alignment alignment = Alignment.center]){
    return Stack(children: this, alignment: alignment);
  }

  // Returns a stack of these and the provided widget
  Widget xStackThis(Widget toStack, [Alignment alignment = Alignment.center]){
    return (this..add(toStack)).xStack(alignment);
  }

  // Returns a stack of these and the provided widgets
  Widget xStackThese(List<Widget> toStack, [Alignment alignment = Alignment.center]){
    return (this..addAll(toStack)).xStack(alignment);
  }
}

// Smallest possible widget
class EmptyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SizedBox.shrink();
}