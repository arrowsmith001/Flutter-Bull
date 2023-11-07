import 'package:flutter/material.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/style/utter_bull_theme.dart';
import 'package:logger/logger.dart';

class UtterBullWebContainer extends StatefulWidget {
  const UtterBullWebContainer(
      {super.key, required this.child, required this.drag});

  final Widget child;
  final bool drag;

  @override
  State<UtterBullWebContainer> createState() => UtterBullWebContainerState();
}

class UtterBullWebContainerState extends State<UtterBullWebContainer>
    with MediaDimensions, SingleTickerProviderStateMixin {
  late final AnimationController animController =
      AnimationController(vsync: this, duration: Duration(milliseconds: 500));

  late Animation<Offset> animation =
      CurvedAnimation(parent: animController, curve: Curves.easeOut)
          .drive(Tween(begin: Offset.zero, end: Offset.zero));

  Widget get child => widget.child;

  late final Offset center = Offset(width / 2, height / 2);
  Offset offset = Offset.zero;
  bool isDragging = false;
  double fontsize = 22;
  bool leftVisible = true;
  @override
  Widget build(BuildContext context) {
    final Widget left = Visibility(
      visible: leftVisible,
      child: Stack(
        children: [
          Positioned.fill(
              child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Welcome, and thank you for showing interest in my game!",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: fontsize),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "As you can see, Utter Bull is primarily designed with mobile in mind. This web deployed version is primarily for selective user testing.",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: fontsize),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Please contact me directly if you wish to play test my game. It requires at least 3 people.",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: fontsize),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "arrowsmith001dev@gmail.com",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: fontsize),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              leftVisible = false;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Ok",
                              style: TextStyle(fontSize: 32),
                            ),
                          )),
                    ),
                  )
                ]),
          ))
        ],
      ),
    );
    final Widget right = Stack(
      children: [
        Positioned.fill(
            child: Align(
          alignment: Alignment.centerLeft,
          child: Text(""),
        ))
      ],
    );

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        decoration: UtterBullGlobal.gameViewDecoration,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(child: left),
            Flexible(
              child: !widget.drag
                  ? child
                  : AnimatedBuilder(
                      animation: animController,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: isDragging ? offset : animation.value,
                          child: child,
                        );
                      },
                      child: Draggable(
                        onDragEnd: (details) {
                          isDragging = false;
                          animation = CurvedAnimation(
                                  parent: animController,
                                  curve: Curves.elasticOut)
                              .drive(Tween(
                                  begin: details.offset, end: Offset.zero));
                          animController.forward(from: 0);
                        },
                        onDragUpdate: (event) {
                          setState(() {
                            this.offset = event.globalPosition - center;
                          });
                        },
                        onDragStarted: () {
                          isDragging = true;
                        },
                        feedback: SizedBox.shrink(),
                        child: child,
                      ),
                    ),
            ),
            Expanded(child: right),
          ],
        ),
      ),
    );

    // return MouseRegion(
    //   onHover: (event) => ,
    //   child: GestureDetector(
    //     onHorizontalDragStart: (details) {
    //       this.startOffset = kMous
    //     },
    //     onHorizontalDragUpdate: (deets) {
    //       setState(() {
    //         offset = Offset(deets.globalPosition.dx, 0);
    //         Logger().d(offset);
    //       });
    //     },
    //     child: Transform.translate(
    //       offset: offset,
    //       child: child,
    //     ),
    //   ),
    // );
  }
}
