import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bull/widgets.dart';
import 'package:flutter_bull/extensions.dart';

class DeveloperPanel extends StatefulWidget {
  DeveloperPanel(BuildContext context);


  @override
  _DeveloperPanelState createState() => _DeveloperPanelState();
}

class _DeveloperPanelState extends State<DeveloperPanel> {

  bool devOptionsOpen = false;

  double l = 0;
  double t = 0;

  @override
  Widget build(BuildContext context) {
    
    double dim = 75;
    Size size = MediaQuery.of(context).size;

    Widget c = Container(
      decoration: BoxDecoration(shape: BoxShape.circle, color: Color.fromARGB(255, 0, 0, 255)),
        height: dim,
        width: dim,
    child: Icon(Icons.settings, size: dim));

    Widget devIcon = Positioned(
      width: 75,
      height: 75,
      top: t, left: l,
      child: GestureDetector(
        onTap: () {
          setState(() {
            devOptionsOpen = true;
          });
        },
        child: Draggable(
          childWhenDragging: EmptyWidget(),
          onDragEnd: (details) {
            setState(() {
              l = details.offset.dx;
              t = details.offset.dy;
            });
          },
          feedback: c,
          child: c,),
      ),
    );

    Widget devOptions =
      Positioned(
        left: 0, top: 0, width: size.width, height: size.height,
          child: Container(
            color: Colors.grey.withOpacity(0.3),
              child: Text('Nothing at the moment').PaddingExt(EdgeInsets.symmetric(vertical: 50, horizontal: 25))
              // TODO DEV OPTIONS TO SIMULATE EVERYTHING
          ),
        );

    Widget exitButton =
        Positioned(
          left: size.width - 75 - 10, top: 10, width: 75, height: 75,
          child: GestureDetector(
            onTap: () => setState(() { devOptionsOpen = false; }),
            child: Container(
              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red)
            ),
          ),
        );

    return Stack(
      children: [

        devIcon,

        devOptionsOpen ? devOptions : EmptyWidget(),

        devOptionsOpen ? exitButton : EmptyWidget(),

      ],
    );
  }
}
