import 'dart:math';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

// TODO: Enforce consistent size
class RegularRectanglePacker extends StatelessWidget {
  RegularRectanglePacker(
      {super.key, this.color, required this.size, required this.items}) {
    if (R == 0.0 || R.isNaN || R.isInfinite || R.isNegative) {
      rowCount = 1;
      colCount = 1;
    }
else
{
  
    double dRowCount = sqrt(n.toDouble() / R);
    double dColCount = R * dRowCount;

    rowCount = max(dRowCount.floor(), 1);
    colCount = max(dColCount.floor(), 1);
}
  }

  late int colCount;
  late int rowCount;

  final Color? color;
  final Size size;
  final List<Widget> items;

  double get R => size.width / size.height;

  int get n => items.length;

  double get ratioAdjH => R <= 1 ? R : 1 + log(R);

  double get ratioAdjV => R > 1 ? R : 1 + log(R);

  int get nPerRow => (ratioAdjH * sqrt(n)).ceil();

  int get numberOfRows => (n / nPerRow).ceil();

  double get dim => size.width / nPerRow;

  @override
  Widget build(BuildContext context) {
    final List<Widget> rows = [];

    var numberAdded = 0;
    var rowNum = 0;
    var breakCondition = 10000;

    while (numberAdded < n && 0 < breakCondition) {
      breakCondition--;

      final List<Widget> colChildren = [];

      for (var j = 0; j < colCount; j++) {
        var index = (rowNum * colCount) + j;
        try {
          colChildren.add(items[index]);
        } catch (e) {}
        numberAdded++;
      }

      if (colChildren.isNotEmpty) {
        final row = Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: colChildren.map((e) => Flexible(child: e)).toList());

        rows.add(row);
      }

      rowNum++;
    }

    final Widget child = Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: rows
            .map((e) => Expanded(
                  child: e,
                ))
            .toList());

    return Container(
      color: color,
      child: SizedBox(
        width: size.width,
        height: size.height,
        child: child,
      ),
    );
  }
}
