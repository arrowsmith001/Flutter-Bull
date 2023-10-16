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
      super.key,
      required this.title,
      this.leading,
      this.below,
      this.maxHeight,
      this.isLoading = false,
      this.isShimmering = true,
      this.aspectRatio = 3,
      this.color,
      this.gradient});

  final VoidCallback? onPressed;
  final String title;
  final Widget? leading;
  final Widget? below;
  final double? maxHeight;
  final double aspectRatio;
  final bool isLoading;
  final bool isShimmering;
  final Color? color;
  final Gradient? gradient;

  @override
  _UtterBullButtonState createState() => _UtterBullButtonState();
}

class _UtterBullButtonState extends State<UtterBullButton>
    with SingleTickerProviderStateMixin {
  late AnimationController animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 25),
      reverseDuration: const Duration(milliseconds: 100));

  late Animation<double> doubleAnim = CurvedAnimation(
          parent: animController,
          curve: Curves.linear,
          reverseCurve: Curves.decelerate)
      .drive(Tween(begin: 1, end: reactionEndScale));

  late Animation<Offset> offsetAnim =
      animController.drive(Tween(begin: Offset(0, -3), end: Offset(0, 3)));

  late Animation<Color?> colorAnim =
      ColorTween(begin: baseColor, end: reactionColor).animate(animController);

  final double reactionEndScale = 0.95;
  late final Color baseColor =
      widget.color ?? Theme.of(context).colorScheme.primary;
  late final Color reactionColor = Color.lerp(baseColor, Colors.white, 0.5)!;

  bool get isEnabled => widget.onPressed != null;

  @override
  void initState() {
    super.initState();

    if (isEnabled) {
      //animController.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    animController.dispose();
    super.dispose();
  }

  void _onPressed() async {
    if (animController.isAnimating) {
      animController.stop();
    }
    animController
        .forward(from: 0)
        .then((_) => animController.reverse(from: 1));
    widget.onPressed!();
  }

  double radius = 24.0;
  Color get color => isEnabled ? colorAnim.value! : Colors.grey;

  @override
  Widget build(BuildContext context) {
    final main = GestureDetector(
      onTap: isEnabled && widget.onPressed != null ? () => _onPressed() : null,
      child: SizedBox(
        height: widget.maxHeight,
        child: AspectRatio(
          aspectRatio: widget.aspectRatio,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: _buildOuterEdge(),
          ),
        ),
      ),
    );

    // final Widget transformedMain = Transform.translate(
    //   offset: offsetAnim.value,
    //   child: GestureDetector(
    //     onTap: isEnabled ? () => widget.onPressed!() : null,
    //     child: AspectRatio(
    //       aspectRatio: widget.aspectRatio,
    //       child: Padding(
    //         padding: const EdgeInsets.all(4.0),
    //         child: _buildOuterEdge(),
    //       ),
    //     ),
    //   ),
    // );

    return AnimatedBuilder(
        animation: doubleAnim,
        builder: (context, _) {
          return Transform.scale(
            scale: doubleAnim.value,
            child: main,
          );
        });
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

  Widget _buildInnerLayer() {
    final lightenedColor = Color.lerp(color, Colors.white, 0.7)!;

    return AnimatedBuilder(
        animation: colorAnim,
        builder: (context, _) {
          return Container(
              decoration: BoxDecoration(
                  gradient: widget.gradient ??
                      LinearGradient(
                          colors: [lightenedColor, color],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter),
                  borderRadius: BorderRadius.circular(radius)),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Stack(children: [_buildContents()]),
              ));
        });
  }

  Widget _buildContents() {
    final text = UglyOutlinedText(text: widget.title);
    return Column(
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.isLoading
                  ? UtterBullCircularProgressIndicator()
                  : _buildLeading(),
              Expanded(child: LayoutBuilder(builder: (context, constraints) {
                final hFull = constraints.biggest.height;
                final wFull = constraints.biggest.width;

                return text;

                return Container(
                  color: Colors.pink,
                  height: hFull,
                  width: wFull,
                  child: AnimatedSwitcher(
                      layoutBuilder: (currentChild, previousChildren) =>
                          currentChild!,
                      transitionBuilder: (child, animation) {
                        return AnimatedBuilder(
                          animation: animation,
                          builder: (context, _) {
                            bool isWidgetEmpty =
                                (child.key as ValueKey<bool>).value == true;

                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                LayoutBuilder(builder: (context, c2) {
                                  final h = c2.biggest.height;
                                  final w = c2.biggest.width;

                                  return Container(
                                      color: Colors.green,
                                      height: h,
                                      width: w,
                                      child: text);
                                })
                              ],
                            );
                          },
                        );
                      },
                      duration: Duration(milliseconds: 500),
                      child: Container(
                        key: ValueKey<bool>(widget.below == null),
                        child: widget.below,
                      )),
                );
              }))
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
  UglyOutlinedText(
      {
        this.text,
      this.textSpan,
      this.outlineColor,
      this.fillColor,
      this.textAlign,
      this.maxLines = 1,
      super.key});
  final TextSpan? textSpan;
  final String? text;
  final TextAlign? textAlign;
  final Color? fillColor;
  final Color? outlineColor;
  final int maxLines;

  final AutoSizeGroup group = AutoSizeGroup();

  @override
  Widget build(BuildContext context) {
    if(textSpan != null)
    {
 return Stack(
      alignment: Alignment.center,
      children: [
        AutoSizeText.rich(
          textSpan!,
          minFontSize: 4,
          maxLines: maxLines,
          style: TextStyle(
              fontSize: 100,
              fontWeight: FontWeight.bold,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 4
                ..color = outlineColor ?? Colors.grey.withAlpha(150)
                ),
          textAlign: textAlign ?? TextAlign.center,
        ),
        AutoSizeText.rich(
          group: group,
          textSpan!,
          maxLines: maxLines,
          style: TextStyle(
              fontSize: 100,
              fontWeight: FontWeight.bold,
              // foreground: Paint()
              //   ..style = PaintingStyle.fill
              //   ..color = fillColor ?? Colors.white
                ),
          textAlign: textAlign ?? TextAlign.center,
        )
      ],
    );
    }
    return Stack(
      alignment: Alignment.center,
      children: [
        AutoSizeText(
          text!.toUpperCase(),
          minFontSize: 4,
          maxLines: maxLines,
          style: TextStyle(
              fontSize: 100,
              fontWeight: FontWeight.bold,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 4
                ..color = outlineColor ?? Colors.grey.withAlpha(150)),
          textAlign: textAlign ?? TextAlign.center,
        ),
        AutoSizeText(
          group: group,
          text!.toUpperCase(),
          maxLines: maxLines,
          style: TextStyle(
              fontSize: 100,
              fontWeight: FontWeight.bold,
              foreground: Paint()
                ..style = PaintingStyle.fill
                ..color = fillColor ?? Colors.white),
          textAlign: textAlign ?? TextAlign.center,
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
