import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bull/classes/firebase.dart';
import 'package:flutter_bull/firebase/_bloc.dart';
import 'package:flutter_bull/pages/2GameRoom/_bloc.dart';
import 'package:flutter_bull/pages/2GameRoom/_bloc_events.dart';
import 'package:flutter_bull/pages/2GameRoom/_bloc_states.dart';
import 'package:flutter_bull/pages/2GameRoom/routes.dart';
import 'package:flutter_bull/pages/2x1Lobby/_page.dart';
import 'package:flutter_bull/pages/2x3Choose/routes.dart';
import 'package:flutter_bull/pages/widgets.dart';
import 'package:flutter_bull/firebase/provider.dart';
import 'package:flutter_bull/utilities/misc.dart';
import 'package:flutter_bull/widgets.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:math' as math;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bull/classes/firebase.dart';
import 'package:flutter_bull/gen/assets.gen.dart';
import 'package:flutter_bull/gen/fonts.gen.dart';
import 'package:flutter_bull/pages/2GameRoom/_page.dart';
import 'package:flutter_bull/utilities/interpolators.dart';
import 'package:flutter_bull/utilities/local_res.dart';
import 'package:flutter_bull/utilities/repository.dart';
import 'package:flutter_bull/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prefs/prefs.dart';
import 'package:provider/provider.dart';
import '../../classes/classes.dart';
import '../../extensions.dart';
import 'dart:ui' as ui;

import '../../routes.dart';

class ChooseIntro extends StatefulWidget {

  @override
  _ChooseIntroState createState() => _ChooseIntroState();
}

class _ChooseIntroState extends State<ChooseIntro> with TickerProviderStateMixin {

  GameRoomBloc get _bloc => BlocProvider.of<GameRoomBloc>(context, listen: false);
  final String thisPageName = ChoosePages.INTRO;

  late AnimationController _explosionAnimController;
  late Animation _explosionAnim;
  late Duration _explosionAnimDuration = Duration(seconds: 1);

  late PlayerSelectorController playerSelectorController;
  late List<Player?> shuffledPlayerList;

  @override
  void initState() {
    super.initState();
    playerSelectorController = new PlayerSelectorController(vsync: this);

    _explosionAnimController = new AnimationController(vsync: this);
    _explosionAnimController.duration = _explosionAnimDuration;
    _explosionAnimController.addListener(() {setState(() {});});
    _explosionAnimController.value = 0;
    _explosionAnim = CurvedAnimation(parent: _explosionAnimController, curve: Curves.easeInQuad);

    // Compose random player list
    shuffledPlayerList = List.generate(_bloc.model.roomPlayerCount, (i) => _bloc.model.getPlayerFromOrder(i));
    shuffledPlayerList.shuffle(Random(_bloc.model.getRoundSpecificSeed()));
    shuffledPlayerList.removeWhere((p) => _bloc.model.whichTurnWasThisPlayer(p!.id!)! < _bloc.model.room!.turn!);

    _beginFakeChoose(_bloc.model); // TODO Handle errors
  }

  @override
  dispose(){
    _explosionAnimController.dispose();
    super.dispose();
  }

  static const int SPINNER_ANIM_DURATION = 2000;
  static const int SPINNER_REVS = 8;

  Future<void> _beginFakeChoose(GameRoomModel model) async {

    if(model.isLastTurn){
      // TODO Do something different on last turn
    }

    // Enter with explosion
    TickerFuture tf = _explosionAnimController.reverse(from: 1);
    await tf.whenComplete(() => null);

    _showSpinner = true;
    tf = playerSelectorController.animateSpinnerTo(
        shuffledPlayerList.indexWhere((p) => model.getPlayerWhoseTurn()!.id == p!.id),
        shuffledPlayerList.length, revs: SPINNER_REVS, mils: SPINNER_ANIM_DURATION);

    await tf.whenComplete(() => null);
    await Future.delayed(Duration(seconds: 1));
    if(model.room!.phase! == RoomPhases.CHOOSE) _bloc.add(SetPagePhaseOrTurnEvent(phase: RoomPhases.CHOSEN));
    Navigator.of(context).pushNamedAndRemoveUntil(ChoosePages.MAIN, (route) => false);
  }

  void goToPlay() {
    _bloc.add(StartRoundEvent());
  }

  Player? selectedPlayer;
  late bool _showSpinner = false;

  @override
  Widget build(BuildContext context) {

    // TODO Make choose/play minimally viable <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

    return BlocConsumer<GameRoomBloc, GameRoomState>(
        builder: (context, state) {

          if(state.model.room == null) return MyLoadingIndicator();

          bool sufficientInfo = true; // TODO Be stricter here

          //List<Player?> playersInOrder = List.from(state.model.room!.playerOrder!.map((id) => state.model.getPlayer(id)));
          //for(int i = 0; i < 2; i++) playersInOrder += playersInOrder;
          //playersInOrder.removeWhere((element) => playersInOrder.indexOf(element) % 2 == 0);
          //while(playersInOrder.length > 6) playersInOrder.removeLast();
          //while(playersInOrder.length < 10) playersInOrder.add(playersInOrder.getRandom());

          var playerRing = new PlayerSelector(
            shuffledPlayerList, state.model.room!.turn!, MediaQuery.of(context).size,
                showSpinner: _showSpinner,
                explosionFactor: _explosionAnim.value,
                controller: playerSelectorController,
                onSelectedPlayerChanged: (player) => _onSelectedPlayerChanged(player),
              );

          return Scaffold(
              backgroundColor: Color.fromARGB(255, 231, 255, 225),
              body: !sufficientInfo ? MyLoadingIndicator()
                  : SafeArea(
                    child: Column(
                children: [

                    AppStyles.MyText('Choosing next player:', color: Colors.black),
                    Container(
                      child: selectedPlayer == null ? EmptyWidget()
                          : Column(
                        children: [
                          Avatar(
                            selectedPlayer!.profileImage,
                            clippedRectRadius: 32,
                            borderColor: Colors.transparent,
                            shape: BoxShape.rectangle,)
                              .HeroExt(selectedPlayer?.id!??'').ExpandedExt(),
                          AppStyles.MyText(selectedPlayer!.name!, color: Colors.black)
                        ],
                      ).PaddingExt(EdgeInsets.all(16)),)
                        .ExpandedExt(),

                        playerRing.ExpandedExt(),


                ],
              ),
                  )

          );
        },
        listener: (context, state) {

          GameRoomRoutes.pageListener(context, state, thisPageName);

        });
  }

  double _m = 0;
  int _i = 0;

  int incr = 0;

  _onSelectedPlayerChanged(Player? player) {

    setState(() {
      selectedPlayer = player;
    });
  }




}

enum SpinnerSetting { free, fixed }
class PlayerSelectorController extends ChangeNotifier {
  PlayerSelectorController({required this.vsync}){

    animController.addListener(() {
      setSpinnerAngle(ui.lerpDouble(_tStart, _angle, animation.value)!);
      notifyListeners();
    });

    animController.addStatusListener((status) {
      if(status == AnimationStatus.completed) setSpinnerAngle(_angle);
    });
  }

  late AnimationController animController = new AnimationController(vsync: vsync);
  late Animation<double> animation = new CurvedAnimation(parent: animController, curve: Curves.easeOut);

  TickerProvider vsync;
  SpinnerSetting setting = SpinnerSetting.free;

  double _t = 0;
  int _i = 0;

  static const double twoPi = math.pi*2;

  void setSpinnerAngle(double t) {
    _t = t % twoPi;
    setting = SpinnerSetting.free;
    //print('t:' + _t.toString());
    notifyListeners();
  }

  void setSpinnerTo(int i) {
    _i = i;
    setting = SpinnerSetting.fixed;
    //print('i:' + _i.toString());
    notifyListeners();
  }

  late double _tStart;
  late double _angle;
  TickerFuture animateSpinnerTo(int i, int n, {revs: 0, mils: 1000}){
    //print('ANIMATING TO I = ' + i.toString());

    _tStart = _t % twoPi;
    _angle = _getAngleFromI(i, n);
    //print('_tStart: ${_tStart.toDouble()},  angle: ${_angle.toString()}');
    while(_angle < _tStart) _angle += math.pi*2;
    _angle += math.pi*2*revs;
    // while(angle > _tStart - math.pi*2) angle -= math.pi*2;
    // print('_tStart: ${_tStart.toDouble()},  angle: ${angle.toString()}');
    animController.duration = new Duration(milliseconds: mils);
    return animController.forward(from: 0);
  }


  @override
  dispose()
  {
    animController.dispose();
    super.dispose();
  }

  _getAngleFromI(int i, int n) => ((i.toDouble() / n) * 2 * math.pi) % twoPi;

  double getAngle([int n = 0]) {
    switch(setting)
    {
      case SpinnerSetting.fixed:
        _t = _getAngleFromI(_i, n);
        return _t;
      case SpinnerSetting.free:
        return _t;
    }
  }


}

class PlayerSelector extends StatefulWidget {
  PlayerSelector(this.players, this.turn, this.size,
      {required this.controller, required this.onSelectedPlayerChanged, this.explosionFactor = 0, this.showSpinner = true});
  final List<Player?> players;
  final int turn;
  final Function(Player?) onSelectedPlayerChanged;
  final PlayerSelectorController controller;
  final Size size;
  final double explosionFactor;
  final bool showSpinner;

  @override
  _PlayerSelectorState createState() => _PlayerSelectorState();
}

class _PlayerSelectorState extends State<PlayerSelector> with SingleTickerProviderStateMixin {

  static const double twoPi = math.pi*2;
  static const double H_PADDING = 20;

  late PlayerSelectorController controller;
  late AnimationController _animController;

  late int n;
  late double oneFracArc;
  late Size size;
  late double width;
  late double halfWidth;
  late double dim;
  late double halfDim;
  late double mid;
  late Offset center;
  late double r;

  @override
  initState(){
    super.initState();
    this.controller = widget.controller;

    controller.addListener(() {setState(() {
      _selectPlayerMaybe(controller.getAngle(n));
    });});

    // controller.animController.addListener(() {
    //   _selectPlayerMaybe(controller.getAngle(n));
    // });

    _animController = new AnimationController(vsync: this);
    _animController.addListener(() {setState(() {
      //_selectPlayerMaybe(controller.getAngle(n));
    });});

    _calc();
    _beginRoutine();

  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  void _beginRoutine(){

  }

  _calc(){
    // Pre-calculate positions
    n = widget.players.length;
    playerOffsets = new List.generate(n, (index) => new Offset(0,0));
    oneFracArc = twoPi * 1.0/n;

    size = widget.size;
    width = size.width - H_PADDING * 2;
    halfWidth = width/2;

    dim = ((twoPi * halfWidth) / (n + math.pi + 1));
    //dim = 100;
    halfDim = dim/2;
    mid = halfWidth - halfDim;
    center = new Offset(H_PADDING + halfWidth, halfWidth); // Center of ring
    r = (halfWidth - halfDim); // Placement distance from center

    // Edge case: 1 player only
    if(n == 1)
      {
        playerOffsets[0] = new Offset(center.dx - halfDim, center.dy - halfDim);
        return;
      }

    for(int i = 0; i < n; i++)
    {
      double frac = (i).toDouble()/n;
      double sinFrac = (frac)*twoPi;

      double bottom = center.dy + r * math.sin(sinFrac);
      double left = center.dx + r * math.cos(sinFrac);

      playerOffsets[i] = (new Offset( left - halfDim,bottom - halfDim));
    }
  }

  late List<Offset> playerOffsets;

  Player? selectedPlayer;
  void _selectPlayer(Player? player) {
    bool changed = false;
    if(player == null && selectedPlayer == null) return;
    else if(player != null && selectedPlayer == null) changed = true;
    else if(player == null && selectedPlayer != null) changed = true;
    else if(player!.id! != selectedPlayer!.id!) changed = true;
    this.selectedPlayer = player;
    if(changed) widget.onSelectedPlayerChanged.call(selectedPlayer);
  }

  void _selectPlayerMaybe(double rot){
    int i = (n.toDouble() * rot / twoPi).round() % n;
    setState(() {
      _selectPlayer(widget.players[i]);
    });
    // double U = oneFracArc*(i-0.5);
    // double L = oneFracArc*(i+0.5);
    // if(rot <= L
    //     && rot >= U )
    // {
    //   _selectPlayer(player);
    // }
    //
    // // Edge case (holy shit why the fuck does my code even work)
    // if(i == 0)
    //   if(rot - twoPi <= -U && rot - twoPi >= -L)
    //     _selectPlayer(player);
  }

  @override
  Widget build(BuildContext context) {
      var playersInOrder = widget.players;
      var turn = widget.turn;

      double t = 0; // explosionFactor
      double rot = controller.getAngle(n); // selectorRotationFactor

      List<Positioned> playerRing = List.generate(playersInOrder.length, (i)
      {
        Player? player = playersInOrder[i];
        Image? image = player == null ? null : player.profileImage;
        String? heroTag = player == null ? null : player.id!;
        bool playerIsSelected = selectedPlayer == null || player == null ? false : player.id! == selectedPlayer!.id!;

        //print((rot + twoPi % twoPi).toString() + ': L: ${(L+ twoPi % twoPi).toString()}, U: ${(U+ twoPi % twoPi).toString()}');
        //if(rot * n > i) _selectPlayer(player);

        double left = playerOffsets[i].dx;
        double bottom = playerOffsets[i].dy;

        Offset vec = new Offset(left + halfDim - center.dx, bottom + halfDim - center.dy);

        return Positioned(
          child: Avatar(image,
              borderColor: playerIsSelected ? Colors.yellowAccent : Avatar.DEFAULT_BORDER_COLOR,
              size: Size(dim, dim)).OpacityExt((1-t)),
          bottom: bottom + widget.explosionFactor*vec.dy,
          left: left + widget.explosionFactor*vec.dx,
        );
    });

      double smallDim = 10;
      Positioned debugPoint = Positioned(
        left: center.dx - smallDim/2, bottom: center.dy - smallDim/2,
        child: Container(
          height: smallDim, width: smallDim,
          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blueAccent),
        ),
      );

      double largeSquareContainerDim = 150;
        Positioned middleSpinner = new Positioned(
        left: center.dx - largeSquareContainerDim/2, bottom: center.dy - largeSquareContainerDim/2,
        child: Transform.rotate(
          angle: -rot + math.pi,
          child: Container(
            alignment: Alignment.center,
              height: largeSquareContainerDim, width: largeSquareContainerDim,
            child: Transform.translate(
              offset: Offset(-43,-6),
              child: Container(
                width: 110, height: 100,
                  decoration: BoxDecoration(
                      //color: Colors.yellow,
                      image: DecorationImage(
                          image: Assets.images.spinnerArrow,
                          colorFilter: ColorFilter.mode(Colors.orangeAccent, BlendMode.srcIn)
                      )
                  )
              ),
            ),

          ),
        ),
      );

    if(widget.showSpinner) playerRing.addAll([middleSpinner]);

    //playerRing.addAll([debugPoint]); // Debug only TODO Remove

      return Container(
        child: Stack(
          clipBehavior: Clip.none,
          children: playerRing
        ),
      );
  }


}
