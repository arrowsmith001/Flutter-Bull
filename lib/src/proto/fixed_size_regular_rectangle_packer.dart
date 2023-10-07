import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:flutter/material.dart';

class FixedSizeRegularRectanglePacker extends StatelessWidget {
  FixedSizeRegularRectanglePacker({
    super.key,
    required this.size,
    required this.items,
    this.cellRatio = 1.0,
  }) {
    if (R <= 0.0 || R.isInfinite || R.isNaN) {
      Nc = 0;
      Nr = 0;
    } else {
      double dRowCount = sqrt((n * cellRatio) / R);
      Nr = max(1, dRowCount.ceil());

      double dColCount = n / Nr;
      Nc = max(1, dColCount.ceil());
    }
  }

  final Size size;
  final List<Widget> items;
  final double cellRatio;

  late double R = size.width / size.height;
  late int Nc;
  late int Nr;

  int get n => items.length;

  double get dimH => size.width / Nc;

  double get dimV => size.height / Nr;

  double get dimR => dimH / dimV;

  double get rAdj => 1;

  Size get dimSize => Size(dimH * rAdj, dimV * rAdj);

  @override
  Widget build(BuildContext context) {
    
    if (cellRatio <= 0.0) {
      return ErrorWidget(Exception('\'cellRatio\' must be greater than 0.0'));
    }

    final List<Widget> rows = [];

    for (var i = 0; i < Nr; i++) {
      final List<Widget> colChildren = [];

      for (var j = 0; j < Nc; j++) {
        var index = (i * Nc) + j;

        if (index < n) {
          colChildren.add(Flexible(
            child: AspectRatio(
              aspectRatio: cellRatio,
              child: SizedBox(
                width: dimH,
                height: dimV,
                child: items[index],
              ),
            ),
          ));
        }
      }

      if (colChildren.isNotEmpty) {
        final row = SizedBox(
          height: dimV,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: colChildren),
        );

        rows.add(row);
      }
    }

    final Widget child = Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: rows.map((e) => e).toList());

    return SizedBox(
      width: size.width,
      height: size.height,
      child: child,
    );
  }
}
