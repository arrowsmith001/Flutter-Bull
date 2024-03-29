import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bull/src/notifiers/view_models/lobby_phase_view_notifier.dart';
import 'package:flutter_bull/src/proto/regular_rectangle_packer.dart';
import 'package:logger/logger.dart';

// TODO: Optimize and generalize
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
  late List<T> items = widget.initialData;
  late Map<Object, int> itemIdsToIndex = _generateMap();

  late List<Widget> views = items.map(getHeroedItem).toList();

  void _buildViewsFromItems() {
    views.clear();
    views.addAll(viewsFromItems);
  }

  List<Widget> get viewsFromItems => items.map(getHeroedItem).toList();

  Widget getHeroedItem(T item, [bool shrink = false]) {
    final built = widget.builder(item);
    final tag = widget.itemToId(item);

    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      transform: tagsToRemove.contains(tag) ? Matrix4.identity() * 0.05 : Matrix4.identity(),
      child: Hero(tag: tag, child: built));
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
    final itemIndex = itemIdsToIndex[itemTag]!;

    // final oldItem = views[itemIndex];
    // oldItem.control.start();

    views.removeAt(itemIndex);
    items.removeAt(itemIndex);
    itemIdsToIndex.remove(itemTag);

    navKey.currentState?.pushReplacement(_getRoute());
  }

  void addItem(T item) {
    items.add(item);
    itemIdsToIndex.addAll({widget.itemToId(item): items.indexOf(item)});
    views.add(getHeroedItem(item));

    navKey.currentState?.pushReplacement(_getRoute());
  }

  List<Object> tagsToRemove = [];

  void setItems(List<T> newItems) {
    final newTags = newItems.map((e) => widget.itemToId(e)).toSet();
    final currentTags = itemIdsToIndex.keys.toSet();

    if (setEquals(newTags, currentTags)) {

      items.clear();
      items.addAll(newItems);

      itemIdsToIndex = _generateMap();

      setState(() {
        _buildViewsFromItems();
      });
    } else {

      final tags =
          itemIdsToIndex.keys.where((element) => !newTags.contains(element));


      // for (var tag in tagsToRemove) {
      //   final itemIndex = itemIdsToIndex[tag]!;
      //   final oldItem = views[itemIndex];
      //   oldItem.control.start();
      // }

      items.clear();
      items.addAll(newItems);
      itemIdsToIndex = _generateMap();
      
      _buildViewsFromItems();

      // setState(() {
      //   this.tagsToRemove.addAll(tags);
      // });

      navKey.currentState?.pushReplacement(_getRoute());

    }
  }

  void updateItem(String key, T Function(T) transform) {
    final index = itemIdsToIndex[key];
    if (index == null) return;

    final item = items[index];
    final newItem = transform(item);

    items.removeAt(index);
    items.insert(index, newItem);

    setState(() {
      _buildViewsFromItems();
    });
    //navKey.currentState?.pushReplacement(_getRoute(0));
  }

  void updateItems(List<T> items) {
    final Map<Object, T> map =
        Map.fromEntries(items.map((e) => MapEntry(widget.itemToId(e), e)));

    final List<T> newItemList = <T>[];

    for (int i = 0; i < this.items.length; i++) {
      final tag = widget.itemToId(items[i]);
      if (map.containsKey(tag)) {
        newItemList.add(map[tag]!);
      } else {
        newItemList.add(this.items[i]);
      }
    }

    this.items.clear();
    this.items.addAll(newItemList);

    setState(() {
      _buildViewsFromItems();
    });

    //navKey.currentState?.pushReplacement(_getRoute(0));
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
          return RegularRectanglePacker(items: List.from(views));
        });
  }

  Map<Object, int> _generateMap() {
    return Map.fromEntries(items
        .map((item) => MapEntry(widget.itemToId(item), items.indexOf(item))));
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
