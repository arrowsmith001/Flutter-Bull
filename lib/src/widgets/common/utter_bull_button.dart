import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_circular_progress_indicator.dart';
import 'package:shimmer/shimmer.dart';
import 'package:logger/logger.dart';

class PlaceholderButton extends StatelessWidget {
  const PlaceholderButton({this.onPressed, required this.title});

  final VoidCallback? onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Padding(
        padding: EdgeInsets.all(8), //constraints.maxHeight * 0.1),
        child: GestureDetector(
          onTap: onPressed == null ? null : () => onPressed!(),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(32.0)),
            child: Padding(
              padding: EdgeInsets.all(8), //constraints.maxHeight * 0.1),
              child: Center(
                  child: AutoSizeText(
                title,
                style: TextStyle(fontSize: 100),
              )),
            ),
          ),
        ),
      );
    });
  }
}

// TODO: Make buttons react to click

class UtterBullButton extends StatefulWidget {
  const UtterBullButton(
      {this.onPressed,
      required this.title,
      this.leading,
      this.maxHeight,
      this.isLoading = false,
      this.isShimmering = true,
      this.color,
      this.gradient});

  final VoidCallback? onPressed;
  final String title;
  final Widget? leading;
  final double? maxHeight;
  final bool isLoading;
  final bool isShimmering;
  final Color? color;
  final Gradient? gradient;

  @override
  _UtterBullButtonState createState() => _UtterBullButtonState();
}

class _UtterBullButtonState extends State<UtterBullButton>
    with SingleTickerProviderStateMixin {
  late AnimationController animController;
  late Animation<double> doubleAnim;
  late Animation<Offset> offsetAnim;

  bool get isEnabled => widget.onPressed != null;

  @override
  void initState() {
    super.initState();

    animController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    doubleAnim =
        CurvedAnimation(parent: animController, curve: Curves.easeInOut);
    offsetAnim =
        animController.drive(Tween(begin: Offset(0, -3), end: Offset(0, 3)));

    animController.addListener(() {
      setState(() {});
    });

    if (isEnabled) {
      //animController.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    animController.dispose();
    super.dispose();
  }

  double radius = 24.0;
  Color get color => isEnabled
      ? (widget.color ?? Theme.of(context).colorScheme.primary)
      : Colors.grey;

  @override
  Widget build(BuildContext context) {
    final main = GestureDetector(
      onTap: isEnabled ? () => widget.onPressed!() : null,
      child: SizedBox(
        height: widget.maxHeight,
        child: AspectRatio(
          aspectRatio: 3,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: _buildOuterEdge(),
          ),
        ),
      ),
    );

    if (!isEnabled) return main;

    return Transform.translate(
      offset: offsetAnim.value,
      child: GestureDetector(
        onTap: isEnabled ? () => widget.onPressed!() : null,
        child: AspectRatio(
          aspectRatio: 3,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: _buildOuterEdge(),
          ),
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
                color: Color.lerp(color, Colors.black, 0.3)!.withAlpha(100),
                offset: const Offset(0, 10)),
          ],
          borderRadius: BorderRadius.circular(radius)),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: _buildOuterLayer(),
      ),
    );
  }

  Widget _buildOuterLayer() {
    // return _buildShinyCorner(Alignment.bottomRight,
    //     child: Padding(
    //       padding: const EdgeInsets.all(8.0),
    //       child: _buildInnerLayer(),
    //     ));
    return Stack(
      children: [
        Shimmer.fromColors(
            enabled: isEnabled && widget.isShimmering,
            baseColor: color,
            highlightColor: Colors.white,
            child: _buildInnerLayer()),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: _buildInnerLayer(),
        )
      ],
    );
  }

  Container _buildShinyCorner(Alignment center, {required Widget child}) {
    return Container(
      decoration: BoxDecoration(
          gradient: RadialGradient(
              center: center,
              radius: animController.value,
              stops: const [0.2, 0.5],
              colors: [Colors.white, color.withAlpha(255)]),
          borderRadius: BorderRadius.circular(radius)),
      child: child,
    );
  }

  Container _buildInnerLayer() {
    return Container(
        decoration: BoxDecoration(
            gradient: widget.gradient ??
                LinearGradient(
                    colors: [Color.lerp(color, Colors.white, 0.7)!, color],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter),
            borderRadius: BorderRadius.circular(radius)),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Stack(children: [_buildContents()]),
        ));
  }

  Widget _buildContents() {
    return Column(
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.isLoading
                  ? UtterBullCircularProgressIndicator()
                  : _buildLeading(),
              Expanded(child: UglyOutlinedText(widget.title))
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLeading() {
    if (widget.leading == null) return Container();
    return AspectRatio(aspectRatio: 1, child: widget.leading);
  }
}

class UglyOutlinedText extends StatelessWidget {
  UglyOutlinedText(this.text,
      {this.outlineColor, this.fillColor, this.maxLines = 1});

  final String text;
  final Color? fillColor;
  final Color? outlineColor;
  final int maxLines;

  final AutoSizeGroup group = AutoSizeGroup();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AutoSizeText(
          text.toUpperCase(),
          minFontSize: 4,
          maxLines: maxLines,
          style: TextStyle(
              fontSize: 100,
              fontWeight: FontWeight.bold,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 4
                ..color = outlineColor ?? Colors.grey.withAlpha(150)),
          textAlign: TextAlign.center,
        ),
        AutoSizeText(
          group: group,
          text.toUpperCase(),
          maxLines: maxLines,
          style: TextStyle(
              fontSize: 100,
              fontWeight: FontWeight.bold,
              foreground: Paint()
                ..style = PaintingStyle.fill
                ..color = fillColor ?? Colors.white),
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
