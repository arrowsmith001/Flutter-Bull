import 'dart:math';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class RegularRectanglePacker extends StatelessWidget {
  RegularRectanglePacker({super.key, required this.size, required this.items});

  final Size size;
  double get ratio => size.width / size.height;

  final List<Widget> items;

  int get n => items.length;

  double get ratioAdjH => ratio <= 1 ? ratio : 1 + log(ratio);
  double get ratioAdjV => ratio > 1 ? ratio : 1 + log(ratio);
  int get nPerRow => (sqrt(n)).ceil();

  int get numberOfRows => (n / nPerRow).ceil();
  double get dim => size.width / nPerRow;

  @override
  Widget build(BuildContext context) {

    // return Stack(children: [
    //   Positioned.fromRect(
    //     rect: Rect.fromCenter((size.width / 2) - dim/2, (size.height / 2) - dim/2, dim, dim),
    //     child: items[0])
    // ]);

    final List<Widget> rows = List<Row>.generate(numberOfRows, (i) {
      final int remainder = (n - (i * nPerRow)) % nPerRow;
      final int nInThisRow = i < (numberOfRows - 1)
          ? nPerRow
          : (remainder == 0 ? nPerRow : remainder);

      final double spaceToFill =
          nInThisRow == nPerRow ? 0 : ((nPerRow - nInThisRow) * dim);

      return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        SizedBox(width: spaceToFill / 2),
        ...List.generate(nInThisRow, (j) {
          Logger().d("$i $j $nInThisRow");
          return items[(i * nPerRow) + j];
        }).map((e) => Flexible(child: e)).toList(),
        SizedBox(width: spaceToFill / 2),
      ]);
    });

    final Widget child = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: rows
            .map((e) => Flexible(
                  child: e,
                ))
            .toList());

    return SizedBox(
      width: size.width,
      height: size.height,
      child: Column(children: [
        Expanded(
            child: Row(
          children: [Expanded(child: child)],
        ))
      ]),
    );
  }
}
