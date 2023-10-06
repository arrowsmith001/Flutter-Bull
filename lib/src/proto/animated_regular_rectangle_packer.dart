import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bull/src/notifiers/view_models/lobby_phase_view_notifier.dart';
import 'package:flutter_bull/src/proto/regular_rectangle_packer.dart';
import 'package:logger/logger.dart';

class AnimatedRegularRectanglePacker<T> extends StatefulWidget {
  AnimatedRegularRectanglePacker(
      {super.key,
      required this.initialData,
      required this.builder,
      required this.itemToId,
      this.cellRatio = 1});

  final double cellRatio;

  final List<T> initialData;
  final Widget Function(T) builder;
  final Object Function(T) itemToId;

  final HeroController hc = HeroController(
      createRectTween: (r1, r2) => CustomRectTween(a: r1!, b: r2!));

  @override
  State<AnimatedRegularRectanglePacker<T>> createState() =>
      AnimatedRegularRectanglePackerState<T>();
}

class AnimatedRegularRectanglePackerState<T>
    extends State<AnimatedRegularRectanglePacker<T>> {
  late List<ShrinkingWidget> items =
      widget.initialData.map(getHeroedItem).toList();

  ShrinkingWidget getHeroedItem(T item, [bool shrink = false]) {
    final built = widget.builder(item);
    final tag = widget.itemToId(item);

    return ShrinkingWidget(
      child: Hero(tag: tag, child: built),
    );
  }

  Widget Function(Animation, Widget) defaultExitAnimation = (anim, child) {
    return child;
  };

  // void setItems(List<Widget> newItems) {
  //   setState(() {
  //     items = getHeroedItems(newItems);
  //     navKey.currentState!.pushReplacement(_getRoute());
  //   });
  // }

  void removeItem(T itemToRemove) async {
    final itemTag = widget.itemToId(itemToRemove);
    final itemIndex =
        items.indexWhere((element) => element.child.tag == itemTag);
    final oldItem = items[itemIndex];

    // items = List.generate(items.length, (i) {
    //   if (i != itemIndex)
    //     return items[i];
    //   else
    //     return getHeroedItem(itemToRemove, true);
    // });

    // items[itemIndex] = Hero(tag: itemTag, placeholderBuilder: (_, __, ___) => Text("HI"), child: Text("HOP") );

    // items[itemIndex] = Hero(
    //     tag: itemTag,
    //     child: oldItem,
    //     placeholderBuilder: (context, heroSize, child) =>
    //         ShrinkingWidget(oldItem));

    oldItem.control.start();
    items.removeAt(itemIndex);

    navKey.currentState?.pushReplacement(_getRoute());
  }

  void addItem(T item) {
    items.add(getHeroedItem(item));

    navKey.currentState?.pushReplacement(_getRoute());
  }

  final navKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return HeroControllerScope(
      controller: widget.hc,
      child: Navigator(
        key: navKey,
        initialRoute: '/',
        onGenerateRoute: (settings) {
          return _getRoute();
        },
      ),
    );
  }

  PageRoute _getRoute() {
    return PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 500),
        pageBuilder: (_, __, ___) {
          return RegularRectanglePacker(items: List.from(items));
        });
  }
}

class CustomRectTween extends RectTween {
  CustomRectTween({required this.a, required this.b}) : super(begin: a, end: b);
  final Rect a;
  final Rect b;

  @override
  Rect lerp(double t) {
    final t0 = Cubic(0.72, 0.15, 0.5, 1.23).transform(t);

    return Rect.fromLTRB(
      lerpDouble(a.left, b.left, t0),
      lerpDouble(a.top, b.top, t0),
      lerpDouble(a.right, b.right, t0),
      lerpDouble(a.bottom, b.bottom, t0),
    );
  }

  double lerpDouble(num a, num b, double t) {
    if (a == null && b == null) return 0;
    a ??= 0.0;
    b ??= 0.0;
    return a + (b - a) * t;
  }
}

class SWC extends ValueNotifier<int> {
  SWC(super.value);

  void start() {
    value = 1;
    notifyListeners();
  }
}

class ShrinkingWidget extends StatefulWidget {
  ShrinkingWidget({required this.child, super.key});
  final Hero child;

  final SWC control = SWC(0);

  @override
  State<ShrinkingWidget> createState() => _ShrinkingWidgetState();
}

class _ShrinkingWidgetState extends State<ShrinkingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController anim;

  @override
  void initState() {
    super.initState();
    anim =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    anim.addListener(() {
      setState(() {});
    });

    widget.control.addListener(onShrink);
  }

  void start() {
    anim.forward();
  }

  @override
  void dispose() {
    widget.control.removeListener(onShrink);
    anim.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(scale: 1 - anim.value, child: widget.child);
  }

  void onShrink() {
      if (widget.control.value == 1) start();
  }
}
