import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

class PlaceholderButton extends StatelessWidget {
  
  const PlaceholderButton({ this.onPressed, required this.title});

  final VoidCallback? onPressed;
  final String title;

  @override
  Widget build(BuildContext context){
      return LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: EdgeInsets.all(8),//constraints.maxHeight * 0.1),
            child: GestureDetector(
              onTap: onPressed == null ? null : () => onPressed!(),
              child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(32.0)),
          child: Padding(
            padding: EdgeInsets.all(8),//constraints.maxHeight * 0.1),
            child: Center(child: AutoSizeText(title, style: TextStyle(fontSize: 100),)),
          ),
    ) ,
            ),
          );
        }
      );
  }
}

class UtterBullButton extends StatefulWidget {
  const UtterBullButton({required this.onPressed, required this.title});

  final VoidCallback onPressed;
  final String title;

  @override
  _UtterBullButtonState createState() => _UtterBullButtonState();
}

class _UtterBullButtonState extends State<UtterBullButton> {
  double radius = 64.0;
  Color get primaryColor => Theme.of(context).colorScheme.primary;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 5 / 1,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: GestureDetector(
          onTap: () => widget.onPressed(),
          child: _buildOuterEdge(),
        ),
      ),
    );
  }

  Container _buildOuterEdge() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color:
                    Color.lerp(primaryColor, Colors.black, 0.3)!.withAlpha(100),
                offset: Offset(0, 10)),
          ],
          borderRadius: BorderRadius.circular(radius)),
      child: Padding(
        padding: EdgeInsets.all(4.0),
        child: _buildOuterLayer(),
      ),
    );
  }

  Widget _buildOuterLayer() {
    return _buildShinyCorner(Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: _buildInnerLayer(),
        ));
  }

  Container _buildShinyCorner(Alignment center, {required Widget child}) {
    return Container(
      decoration: BoxDecoration(
          gradient: RadialGradient(
              center: center,
              radius: 1,
              stops: [0.2, 0.5],
              colors: [Colors.white, primaryColor.withAlpha(255)]),
          borderRadius: BorderRadius.circular(radius)),
      child: child,
    );
  }

  Container _buildInnerLayer() {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.lerp(primaryColor, Colors.white, 0.7)!,
              primaryColor
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            borderRadius: BorderRadius.circular(radius)),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: _buildContents(),
        ));
  }

  Widget _buildContents() {
    return Container(
      child: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: UglyOutlinedText(widget.title))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class UglyOutlinedText extends StatelessWidget {
  const UglyOutlinedText(
    this.text,
  );

  final String text;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AutoSizeText(
          text.toUpperCase(),
          minFontSize: 4,
          style: TextStyle(
              fontSize: 100,
              fontWeight: FontWeight.bold,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 4
                ..color = Colors.grey.withAlpha(150)),
          textAlign: TextAlign.center,
        ),
        AutoSizeText(
          text.toUpperCase(),
          minFontSize: 4,
          style: TextStyle(
              fontSize: 100,
              fontWeight: FontWeight.bold,
              foreground: Paint()
                ..style = PaintingStyle.fill
                ..color = Colors.white),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}

class PaddedRRect extends StatelessWidget {
  final Widget child;

  final EdgeInsets padding;
  final double radius;
  final Color color;

  const PaddedRRect(
      {required this.child,
      this.padding = const EdgeInsets.all(8.0),
      this.radius = 8.0,
      this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(radius)),
        child: Padding(
          padding: padding,
          child: child,
        ));
  }
}
