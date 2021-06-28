
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bull/classes/firebase.dart';
import 'package:flutter_bull/pages/2GameRoom/_bloc_states.dart';
import 'package:flutter_bull/pages/2x1Lobby/_page.dart';
import 'package:flutter_bull/pages/2x2Write/_page.dart';
import 'package:flutter_bull/pages/2x3Choose/_1_main.dart';
import 'package:flutter_bull/pages/2x3Choose/_page.dart';
import 'package:flutter_bull/pages/2x4Play/_1_main.dart';
import 'package:flutter_bull/pages/2x4Play/_page.dart';
import 'package:flutter_bull/pages/2x5Reveals/_page.dart';
import 'package:extensions/extensions.dart';
import 'package:design/design.dart';
import 'package:flutter_bull/utilities/design.dart';

class GameRoomRoutes {

  static Route generate(RouteSettings settings) {

    final Widget prevPage = settings.arguments as Widget;
    print('Page type: ' + prevPage.runtimeType.toString());

    // TODO Do cool transitions
    return PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 800),
      transitionsBuilder: (context, anim1, anim2, child){
        Size size = MediaQuery.of(context).size;

        switch(settings.name)
        {
          case '/': return Container(color: Colors.purpleAccent);

          case RoomPages.LOBBY:
            var prev = ClipPath(child: prevPage, clipper: PieClipper(anim1.value));
            return Stack(
              alignment: Alignment.center,
              children: [
                child, prev
              ],
            );

          case RoomPages.WRITE:
            Animation anim = CurvedAnimation(parent: anim1, curve: Curves.elasticInOut);
            return child.xScale(anim.value);

          case RoomPages.CHOOSE:
            return child;

          case RoomPages.PLAY:
          final Tween<Offset> offsetTween = Tween<Offset>(begin: Offset(0.0, 0.0), end: Offset(0.0, 1.0));
          final Animation<Offset> slideInFromTheRightAnimation = offsetTween.animate(CurvedAnimation(parent: anim1, curve: Curves.easeInOut));
          var prev = SlideTransition(position: slideInFromTheRightAnimation, child: prevPage is Choose ? Choose(true) : prevPage);
          return Stack(
            alignment: Alignment.center,
            children: [
              child, prev
            ],
          );

          case RoomPages.REVEALS:
            var prev = ClipPath(child: prevPage, clipper: PieClipper(anim1.value));
            return Stack(
              alignment: Alignment.center,
              children: [
                child, prev
              ],
            );

          default: return child;
        }
      },

        pageBuilder: (context, anim1, anim2) {

         return getPage(settings.name);

    }
    );
  }



  static pageListener(BuildContext context, GameRoomState state, String prevPageName) {
    if(state is RoomPageChangedState)
      {
        Widget pageWidget = getPage(prevPageName);
        print('pageListener: ' + pageWidget.runtimeType.toString());
        String? pageName = state.newPage;
        SchedulerBinding.instance!.addPostFrameCallback((_) {
          Navigator.of(context).pushNamedAndRemoveUntil(pageName, (route) => false, arguments: pageWidget);
        });
      }

  }
}

Widget getPage(String? pageName){
  switch(pageName)
  {
    case '/': return Container(color: Colors.purpleAccent);

    case RoomPages.LOBBY: return Lobby();

    case RoomPages.WRITE: return Write();

    case RoomPages.CHOOSE: return Choose();

    case RoomPages.PLAY: return Play();

    case RoomPages.REVEALS: return Reveals();
  }

  return Container(color: Colors.white, child: Center(
      child: Text("Error: Unknown route name " + (pageName??'null'))));
}

// class MyCustomPageRoute extends CupertinoPageRoute {
//   final Widget prevPage;
//   MyCustomPageRoute({required this.prevPage, required WidgetBuilder builder, required RouteSettings settings}) : super(builder: builder, settings: settings);
//
//   @override
//   Widget buildTransitions(BuildContext context, Animation<double> anim1, Animation<double> anim2, Widget currentPage) {
//     var prev = ClipPath(child: prevPage, clipper: PieClipper(anim1.value));
//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         currentPage, prev
//       ],
//     );
//   }
// }
