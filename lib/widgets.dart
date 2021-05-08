import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'extensions.dart';

class EmptyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox.shrink();
  }
}

class BlueExpandedContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.blue).ExpandedExt();
  }
}
class YellowExpandedContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.yellow).ExpandedExt();
  }
}
class RedExpandedContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.red).ExpandedExt();
  }
}
class GreenExpandedContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.green).ExpandedExt();
  }
}

List<Widget> ColumnChildrenTest() => [
  BlueExpandedContainer(), RedExpandedContainer(), YellowExpandedContainer()
];