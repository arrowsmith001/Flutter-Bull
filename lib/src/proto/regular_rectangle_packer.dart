import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter_bull/src/proto/fixed_size_regular_rectangle_packer.dart';
import 'package:logger/logger.dart';
import 'package:flutter/material.dart';

class RegularRectanglePacker extends StatelessWidget {
  RegularRectanglePacker(
      {super.key, this.color, this.cellRatio = 1.0, required this.items});

  final double cellRatio;
  final Color? color;
  final List<Widget> items;

  late Size size;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      size = constraints.biggest;

      return FixedSizeRegularRectanglePacker(
          size: size, items: items, cellRatio: cellRatio);
    });
  }
}
