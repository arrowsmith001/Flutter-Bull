import 'package:flutter/cupertino.dart';
import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bull/classes/firebase.dart';
import 'package:flutter_bull/firebase/_bloc.dart';
import 'package:flutter_bull/pages/2GameRoom/_bloc.dart';
import 'package:flutter_bull/pages/2GameRoom/_bloc_events.dart';
import 'package:flutter_bull/pages/2GameRoom/_bloc_states.dart';
import 'package:flutter_bull/pages/2GameRoom/routes.dart';
import 'package:flutter_bull/pages/2x1Lobby/_page.dart';
import 'package:flutter_bull/pages/widgets.dart';
import 'package:flutter_bull/firebase/provider.dart';
import 'package:flutter_bull/utilities/game.dart';
import 'package:flutter_bull/utilities/misc.dart';
import 'package:flutter_bull/utilities/res.dart';
import 'package:flutter_bull/widgets.dart';
import 'package:flutter_circular_text/circular_text/model.dart';
import 'package:flutter_circular_text/circular_text/widget.dart';
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
import 'package:rxdart/rxdart.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../../classes/classes.dart';
import '../../extensions.dart';
import 'dart:ui' as ui;

import '../../routes.dart';
import 'misc.dart';


const double AVATAR_DIM = 125;
const double AVATAR_RADIUS_OFFSET = 25;
const double AVATAR_PADDING = 8;
const double AVATAR_TOTAL_DIM = AVATAR_DIM + AVATAR_RADIUS_OFFSET*2 + 2*AVATAR_PADDING;

const bool REVERSE_ANIMATED_LIST = true;


class Lobby extends StatefulWidget {

  @override
  _LobbyState createState() => _LobbyState();
}

class _LobbyState extends State<Lobby> with TickerProviderStateMixin {

  GameRoomBloc get _bloc => BlocProvider.of<GameRoomBloc>(context, listen: false);
  final String thisPageName = RoomPages.LOBBY;
  late AnimationController _animController;
  late AnimationController _startButtonAnimController;
  late Animation _flashAnim;
  OvershootInterpolator interp = new OvershootInterpolator(2);

  late List<String> playerIdsLocal;

  static const int PLAYER_LIST_ANIMATION_DURATION_MILLISECONDS = 250;

  @override
  void initState() {
    super.initState();

    playerIdsLocal = List.from(_bloc.model.room!.playerIds!);

    _animController = new AnimationController(vsync: this);
    _animController.addListener(() {setState(() { });});
    _animController.duration = Duration(milliseconds: 1500);
    _animController.repeat();
    _flashAnim = CurvedAnimation(parent: _animController, curve: Curves.slowMiddle);

    _startButtonAnimController = new AnimationController(vsync: this);
    _startButtonAnimController.addListener(() {setState(() { });});
    _startButtonAnimController.duration = Duration(milliseconds: 250);

    _exposeStartGameButtonIfAppropriate(false);
  }

  @override
  void dispose(){
    _animController.dispose();
    super.dispose();
  }

  void _exposeStartGameButtonIfAppropriate(bool equalityOnly){
    bool expose = equalityOnly ? playerIdsLocal.length == GameParams.MINIMUM_PLAYERS_FOR_GAME : playerIdsLocal.length >= GameParams.MINIMUM_PLAYERS_FOR_GAME;
    if(expose) _startButtonAnimController.forward(from: 0);
  }

  void startGame() {
    _bloc.add(StartGameRequestedEvent());
  }

  GlobalKey<AnimatedListState> _listKey = GlobalKey();
  ScrollController _scrollController = new ScrollController();

  void _onPlayerRemoved(int index, String userId, GameRoomModel model) async {

    if (_listKey.currentState != null) {

      _listKey.currentState!.removeItem(index,
              (context, animation) => _buildListItem(context, index, animation, null),
          duration: Duration(milliseconds: PLAYER_LIST_ANIMATION_DURATION_MILLISECONDS));

      playerIdsLocal.remove(userId);
    }

  }

  // void _onPlayerRemovedFinished(String userId){
  //   print('_onPlayerRemovedFinished' + ' ' + userId);
  //   playerListItemStateKeys.remove(userId);
  //   playerIdsLocal.remove(userId);
  //   setState(() {});
  // }

  void _onPlayerAdded(int index, String userId, GameRoomModel model) async {
    if (_listKey.currentState != null) {

      playerIdsLocal.add(userId);
      _listKey.currentState!.insertItem(index, duration: Duration(milliseconds: PLAYER_LIST_ANIMATION_DURATION_MILLISECONDS));
      _exposeStartGameButtonIfAppropriate(true);

      _showNotif(userId, NotifType.PlayerAdded);

      await Future.delayed(Duration(milliseconds: PLAYER_LIST_ANIMATION_DURATION_MILLISECONDS)); // TODO Make syncronous if possible
      double val = _scrollController.position.maxScrollExtent;// + AVATAR_DIM + 2 * AVATAR_PADDING;
      if(_scrollController.position.userScrollDirection == ScrollDirection.idle) _scrollController.animateTo(val, duration: Duration(milliseconds: 250), curve: Curves.easeInExpo);

    }
  }



  Widget _buildListItem(BuildContext context, int i, Animation<double>? animation, GameRoomModel? model, [bool animationListReversed = false]) {
    Player? player = model != null && i < playerIdsLocal.length ? model.getPlayer(playerIdsLocal[i]) : null;
    int playerScore = player == null || model == null ? 0 : model.getPlayerScore(player.id!) ?? 0;
    Animation<double>? anim = animation == null ? null : CurvedAnimation(parent: animation, curve: OvershootCurve());
    int position = (i == 0) ? (animationListReversed ? AnimatedListItem.LOWEST : AnimatedListItem.HIGHEST)
        : i == playerIdsLocal.length - 1 ? (!animationListReversed ? AnimatedListItem.LOWEST : AnimatedListItem.HIGHEST)
        : AnimatedListItem.MIDDLE;
    AnimatedListItem item =  AnimatedListItem(player: player, score: playerScore, index: i, animation: anim, reversed: animationListReversed, position: position);
    return item;
  }

  PanelController _panelController = new PanelController();
  bool _panelIsOpen = false;


  void _setLocalSetting(String roomSetting, dynamic arg) {
    setState(() {
      _settingsLocal[roomSetting] = arg;
    });

    _refreshSettings();

  }

  void _onNewSettings(Map<String, dynamic> newSettings) {
    setState(() {
      for(String k in _settings.keys) _settings[k] = newSettings[k];
    });
    _refreshSettings();
  }

  void _refreshSettings(){
    setState(() {
      localSettingsDifferentFromGlobalSettings = !_settingsLocal.keys.every((k) => _settingsLocal[k] == _settings[k]);
    });
  }

  void _onDefaultSettings() {
    // TODO Fix this, jumps to 9 for some reason, also sets all truths possible default wrong
    Map<String, dynamic> defaultSettings = GameParams.DEFAULT_GAME_SETTINGS;
    setState(() {
      for(String k in _settingsLocal.keys) _settingsLocal[k] = defaultSettings[k];
    });
    _refreshSettings();
  }

  void _onSaveSettingsChanges() {
    _bloc.add(NewRoomSettingsEvent(_settingsLocal));
  }

  late Map<String, dynamic> _settings = {
    Room.SETTINGS_ROUND_TIMER : _bloc.model.room!.settings[Room.SETTINGS_ROUND_TIMER],
    Room.SETTINGS_ALL_TRUTHS_POSSIBLE : _bloc.model.room!.settings[Room.SETTINGS_ALL_TRUTHS_POSSIBLE],
    Room.SETTINGS_LEWD_HINTS_ENABLED : _bloc.model.room!.settings[Room.SETTINGS_LEWD_HINTS_ENABLED],
  };
  late Map<String, dynamic> _settingsLocal = {
    Room.SETTINGS_ROUND_TIMER : _settings[Room.SETTINGS_ROUND_TIMER],
    Room.SETTINGS_ALL_TRUTHS_POSSIBLE : _settings[Room.SETTINGS_ALL_TRUTHS_POSSIBLE],
    Room.SETTINGS_LEWD_HINTS_ENABLED : _settings[Room.SETTINGS_LEWD_HINTS_ENABLED],
  };
  late bool localSettingsDifferentFromGlobalSettings = false;
  bool isUsingSlider = false;

  Widget _buildGameSettingsList(ScrollController sc, GameRoomModel model) {

    const double LIST_ITEM_PADDING = 32.0;

    const Color TRACK_COLOR = const Color.fromARGB(178, 28, 28, 106);
    const Color MARKER_COLOR = const Color.fromARGB(255, 68, 116, 220);

    bool amIHost = model.amIHost; // TODO Differentiate host control
    amIHost = true;

    var outerDeco = BoxDecoration(border: Border.all(color: Colors.white.withOpacity(0.3), width: 3), borderRadius: MyBorderRadii.all(16.0));
    var innerDeco = BoxDecoration(border: Border.all(color: Colors.white.withOpacity(0.8), width: 1), borderRadius: MyBorderRadii.all(8.0));

    var roundTimerDoubleLocal = _settingsLocal[Room.SETTINGS_ROUND_TIMER].toDouble();
    var allTruthsEnabledLocal = _settingsLocal[Room.SETTINGS_ALL_TRUTHS_POSSIBLE];
    var lewdnessOnLocal = _settingsLocal[Room.SETTINGS_LEWD_HINTS_ENABLED];
    var roundTimerDouble = _settings[Room.SETTINGS_ROUND_TIMER].toDouble();
    var allTruthsEnabled = _settings[Room.SETTINGS_ALL_TRUTHS_POSSIBLE];
    var lewdnessOn = _settings[Room.SETTINGS_LEWD_HINTS_ENABLED];
    var settingsItem1 = Column(
      children: [
        Text('Round Timer', style: AppStyles.defaultStyle(color: Colors.white),),
        AppStyles.MyText('The number of minutes of voting time', fontSize: 20),
        Row(
          children: [
            SliderTheme(
                data: SliderThemeData(
                    activeTrackColor: TRACK_COLOR,
                    activeTickMarkColor: MARKER_COLOR,
                    inactiveTickMarkColor: MARKER_COLOR,
                    disabledActiveTickMarkColor: MARKER_COLOR,
                    disabledInactiveTickMarkColor: MARKER_COLOR,
                    trackHeight: 20,
                    trackShape: MySliderTrack(),
                    thumbShape: RoundTimerSliderThumbShape(roundTimerDoubleLocal, enabledThumbRadius: 50)
                ),
                child: Slider(
                  divisions: GameParams.MAXIMUM_ROUND_TIMER - GameParams.MINIMUM_ROUND_TIMER,
                  onChangeStart: (value) {setState(() {isUsingSlider = true;});}, // TODO Make slider less janky i.e. not make the page scroll with it
                  onChangeEnd: (value) {setState(() {isUsingSlider = false;});},
                  min: GameParams.MINIMUM_ROUND_TIMER.toDouble(),
                  max: GameParams.MAXIMUM_ROUND_TIMER.toDouble(),
                  onChanged: (double value) {
                    _setLocalSetting(Room.SETTINGS_ROUND_TIMER, value);
                  },
                  value: roundTimerDoubleLocal,

                )).FlexibleExt(9)
          ],
        ),
      ],
    );
    var settingsItem2 = Column(
      children: [
        Text('\"All truths\" possible?', style: AppStyles.defaultStyle(color: Colors.white),),
        AppStyles.MyText('Include the possibility of every player being asked to write a truth?', fontSize: 20),
        Row(
          children: [

            GestureDetector(
              onTap: () => _setLocalSetting(Room.SETTINGS_ALL_TRUTHS_POSSIBLE, true),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: MyBorderRadii.all(16.0),
                    border: Border.all(color: !allTruthsEnabledLocal ? Colors.transparent : Colors.white, width: 3),
                    gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.lightBlueAccent, Colors.indigoAccent])),
                child: Column(
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Text('YES', style: AppStyles.defaultStyle(),).PaddingExt(EdgeInsets.only(left: 8)).FlexibleExt(),
                      !allTruthsEnabled ? EmptyWidget() : Assets.images.tickIconTrans.image(height: 25, color: Colors.white).PaddingExt(EdgeInsets.only(right: 8))
                    ],),
                    Assets.images.angels.image().PaddingExt(EdgeInsets.symmetric(vertical: 10, horizontal: 10))
                  ],
                ),
              )

              ,
            ).PaddingExt(EdgeInsets.symmetric(vertical: 10, horizontal: 10)).FlexibleExt(),

            GestureDetector(
              onTap: () => _setLocalSetting(Room.SETTINGS_ALL_TRUTHS_POSSIBLE, false),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: MyBorderRadii.all(16.0),
                    border: Border.all(color: allTruthsEnabledLocal ? Colors.transparent : Colors.white, width: 3),
                    gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.redAccent.shade200, Color.fromARGB(
                        255, 198, 31, 31)])),
                child: Column(
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Text('NO', style: AppStyles.defaultStyle(),).PaddingExt(EdgeInsets.only(left: 8)).FlexibleExt(),
                      allTruthsEnabled ? EmptyWidget() : Assets.images.tickIconTrans.image(height: 25, color: Colors.white).PaddingExt(EdgeInsets.only(right: 8))
                    ],),
                    Assets.images.angel.image().PaddingExt(EdgeInsets.symmetric(vertical: 10, horizontal: 10))
                  ],
                ),
              )
              ,
            ).PaddingExt(EdgeInsets.symmetric(vertical: 10, horizontal: 10))
                .FlexibleExt(),

          ],
        ),
      ],
    );
    var settingsItem3 = Column(
      children: [
        Text('Include \"adult\" hints?', style: AppStyles.defaultStyle(color: Colors.white),),
        AppStyles.MyText('When writing statements, you can get hints to use for inspiration. Should they be completely clean, or can they include naughty stuff?', fontSize: 20),
        Row(
          children: [

            GestureDetector(
              onTap: () => _setLocalSetting(Room.SETTINGS_LEWD_HINTS_ENABLED, false),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: MyBorderRadii.all(16.0),
                    border: Border.all(color: lewdnessOnLocal ? Colors.transparent : Colors.white, width: 3),
                    gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color.fromARGB(255, 249, 139, 255), Color.fromARGB(
                        255, 222, 47, 232)])),
                child: Column(
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Text('CLEAN', style: AppStyles.defaultStyle(),).PaddingExt(EdgeInsets.only(left: 8)).FlexibleExt(),
                      lewdnessOn ? EmptyWidget() : Assets.images.tickIconTrans.image(height: 25, color: Colors.white).PaddingExt(EdgeInsets.only(right: 8))
                    ],),
                    Assets.images.lewdnessOff.image(height: 65).PaddingExt(EdgeInsets.symmetric(vertical: 10, horizontal: 10))
                  ],
                ),
              )

              ,
            ).PaddingExt(EdgeInsets.symmetric(vertical: 10, horizontal: 10)).FlexibleExt(),

            GestureDetector(
              onTap: () => _setLocalSetting(Room.SETTINGS_LEWD_HINTS_ENABLED, true),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: MyBorderRadii.all(16.0),
                    border: Border.all(color: !lewdnessOnLocal ? Colors.transparent : Colors.white, width: 3),
                    gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color.fromARGB(
                        255, 196, 37, 37), Color.fromARGB(
                        255, 130, 7, 7)])),
                child: Column(
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      AutoSizeText('ADULT', minFontSize: 10, maxLines: 1, style: AppStyles.defaultStyle(),).PaddingExt(EdgeInsets.only(left: 8)).FlexibleExt(),
                      !lewdnessOn ? EmptyWidget() : Assets.images.tickIconTrans.image(height: 25, color: Colors.white).PaddingExt(EdgeInsets.only(right: 8))
                    ],),
                    Assets.images.lewdnessV2.image(height: 65).PaddingExt(EdgeInsets.symmetric(vertical: 10, horizontal: 10))
                  ],
                ),
              )
              ,
            ).PaddingExt(EdgeInsets.symmetric(vertical: 10, horizontal: 10))
                .FlexibleExt(),

          ],
        ),
      ],
    );

    return Column(
      children: [
        Row(
          children: [
            MyCupertinoStyleButton(
                height: 60,
                color: Colors.lightBlue.shade300,
                text: AutoSizeText('Reset Defaults', minFontSize: 12, style: AppStyles.defaultStyle(fontSize: 54),).PaddingExt(EdgeInsets.symmetric(horizontal: 8)),
                onPressed: () => _onDefaultSettings()
            ).PaddingExt(EdgeInsets.symmetric(horizontal: 8)).FlexibleExt(),
            MyCupertinoStyleButton(
                height: 60,
                color: localSettingsDifferentFromGlobalSettings && amIHost ? Colors.lightBlue.shade300 : Colors.grey,
                text: AutoSizeText('Save Changes', minFontSize: 12, style: AppStyles.defaultStyle(fontSize: 54),).PaddingExt(EdgeInsets.symmetric(horizontal: 8)),
                onPressed: localSettingsDifferentFromGlobalSettings && amIHost ? () => _onSaveSettingsChanges() : null
            ).PaddingExt(EdgeInsets.symmetric(horizontal: 8)).FlexibleExt(),
          ],
        ),
        SingleChildScrollView(
          controller: sc,
          child: Container(
            decoration: outerDeco,
            child: Container(
              decoration: innerDeco,
              child: Column(
                children: [
                  settingsItem1.PaddingExt(EdgeInsets.only(top: LIST_ITEM_PADDING, left: 12, right: 12)),
                  settingsItem2.PaddingExt(EdgeInsets.only(top: LIST_ITEM_PADDING, left: 12, right: 12)),
                  settingsItem3.PaddingExt(EdgeInsets.only(top: LIST_ITEM_PADDING, bottom: LIST_ITEM_PADDING/2, left: 12, right: 12)),
                ],
              ),
            ).PaddingExt(EdgeInsets.all(4)),
          ).PaddingExt(EdgeInsets.symmetric(vertical: 16)),
        ).ExpandedExt()
      ],
    ).PaddingExt(EdgeInsets.all(16));
  }

  BehaviorSubject<Notif> _notifStreamController = new BehaviorSubject();
  void _showNotif(String userId, NotifType type) {
    Notif newNotif = new Notif(userId: userId, notifType: type);
    setState(() {
      _notifStreamController.add(newNotif);
    });
  }

  double _panelSlideValue = 0;
  double _panelSlideProgress = 0;

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<GameRoomBloc, GameRoomState>(
      listener: (context, state) async{

        GameRoomRoutes.pageListener(context, state, thisPageName);

        if(state is NewRoomState) {
          setState(() {
            _listKey = new GlobalKey();
          });
        }

        if(state is RoomPlayerRemovedState) {
          _onPlayerRemoved(state.index, state.userId, state.model);
        }

        if(state is RoomPlayerAddedState) {
          _onPlayerAdded(state.index, state.userId, state.model);
        }

        if(state is RoomSettingsChangedState) {
            Map<String, dynamic> newSettings = state.newSettings;
            _onNewSettings(newSettings);
          }
      },

      builder: (context, state) {

        GameRoomModel? model = state.model;
        Room? room = model == null ? null : model.room;

        if(room == null || model == null) return Center(child:  MyLoadingIndicator(),);

        const double SLIDE_HANDLE_HEIGHT = 10;
        const double SLIDE_HANDLE_V_PADDING = 10;
        const double TOP_BIT_ROOMCODE_HEIGHT = 100;
        const double TOP_BIT_ROOMCODE_V_PADDING = 10;
        const double TOP_BIT_HEIGHT = SLIDE_HANDLE_HEIGHT + TOP_BIT_ROOMCODE_HEIGHT  + 2*(SLIDE_HANDLE_V_PADDING + TOP_BIT_ROOMCODE_V_PADDING);

        // TODO Position list on right
        Widget list = AnimatedList(
          //clipBehavior: Clip.none,
          scrollDirection: Axis.vertical,
          physics: AlwaysScrollableScrollPhysics(),
          controller: _scrollController,
          reverse: REVERSE_ANIMATED_LIST,
          shrinkWrap: false,
          key: _listKey,
          initialItemCount: playerIdsLocal.length,
          itemBuilder: (BuildContext context, int i, Animation<double> animation)
          {
            return _buildListItem(context, i, animation, model, REVERSE_ANIMATED_LIST);
          },
        );

        //list = _buildWrapOfLocalPlayers(model);

        Widget body = Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 13, 23, 132),
                  Color.fromARGB(255, 143, 147, 246),
                  Color.fromARGB(255, 143, 147, 246),
                  Color.fromARGB(255, 56, 65, 220),
                ],
              )
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  list.ExpandedExt(),
                  //panel,
                ],
              ),
            ).PaddingExt(EdgeInsets.only(bottom: TOP_BIT_HEIGHT)),
          ),
        );

        Widget notifDisplay = NotifCenter(this._notifStreamController.stream);
        //notifDisplay = Container(color: AppColors.DebugColor,);

        double PANEL_MAX_HEIGHT = MediaQuery.of(context).size.height - 200;
        Color buttonColor = Color.fromARGB(255, 66, 151, 255);
        double startButtonFlashValue = math.sin(_flashAnim.value * math.pi * 2);
        bool enoughPlayersForAGame = _bloc.model.roomPlayerCount >= GameParams.MINIMUM_PLAYERS_FOR_GAME;

        Widget startGameButton = model.amIHost && enoughPlayersForAGame ?
        Positioned(bottom: TOP_BIT_HEIGHT + _panelSlideValue + 16,
          child: ElevatedButton(
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color.lerp(buttonColor, Colors.white, 0.2*startButtonFlashValue))),
            onPressed: !_panelIsOpen ? () => startGame() : null,
            child: Text('START GAME',
              style: AppStyles.defaultStyle(fontSize: 48),),)
              .OpacityExt((1 - _panelSlideProgress))
              .TranslateExt(dy: 50 * (1-_startButtonAnimController.value))
              .ScaleExt(_startButtonAnimController.value),  )
              : EmptyWidget();

        Widget WaitingRoom =
          Scaffold(
            //floatingActionButton: model.amIHost ? FloatingActionButton(onPressed: () => startGame()) : null,
            body: Stack(
              alignment: Alignment.topCenter,
              children: [
                SlidingUpPanel(
                  onPanelSlide: (d) {
                    setState(() {
                      _panelSlideValue = d * (PANEL_MAX_HEIGHT - TOP_BIT_HEIGHT);
                      _panelSlideProgress = d;
                    });
                  },
                  onPanelOpened: () {
                    _panelIsOpen = true;
                  },
                  onPanelClosed: () {
                    _panelIsOpen = false;
                  },
                  controller: _panelController,
                  isDraggable: true,//!isUsingSlider,
                  parallaxEnabled: true,
                  boxShadow: null,
                  minHeight: TOP_BIT_HEIGHT,
                  maxHeight: PANEL_MAX_HEIGHT,
                  color: Colors.transparent,
                  slideDirection: SlideDirection.UP,
                  body: body,
                  panelBuilder: (sc) {

                    return Container(
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 49, 49, 147),
                            // gradient: RadialGradient(colors: [ Colors.indigo, Color.fromARGB(255, 174, 187, 243),], focal: Alignment.bottomCenter, radius: 5, stops: [0, 0.4]),
                            borderRadius: MyBorderRadii.topOnly(30)

                        ),

                        child: room.code == null ? EmptyWidget()
                            : Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [

                            GestureDetector(
                              onTap: () {
                                if(_panelIsOpen) _panelController.close();
                                else _panelController.open();
                                _panelIsOpen = !_panelIsOpen;
                              },

                              child: Column(
                                children: [
                                  Container(
                                    height: SLIDE_HANDLE_HEIGHT,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.3),
                                        borderRadius: MyBorderRadii.all(10.0)
                                    ),
                                  ).PaddingExt(EdgeInsets.symmetric(vertical: SLIDE_HANDLE_V_PADDING)),

                                  Container(
                                    alignment: Alignment.topCenter,
                                    height: TOP_BIT_ROOMCODE_HEIGHT,
                                    child: AutoSizeText(room.code!,
                                        minFontSize: 24,
                                        style: TextStyle(
                                            fontSize: 72,
                                            color: Colors.white,
                                            fontFamily: FontFamily.lapsusProBold)),
                                  )
                                ],
                              ),
                            ),

                            _buildGameSettingsList(sc, model).ExpandedExt()

                          ],
                        )
                            .PaddingExt(EdgeInsets.symmetric(horizontal: 15, vertical: TOP_BIT_ROOMCODE_V_PADDING))
                    );
                  },

                ),
                SafeArea(child: notifDisplay,),
                startGameButton,
              ],
            ),
          );

        return WaitingRoom;
      },
    );
  }

}

enum NotifType {
  PlayerAdded, PlayerRemoved, SettingsChanged, MessageOnly
}
class Notif {
  Notif({this.userId, this.notifType = NotifType.MessageOnly, this.customMessage = 'This is a notification'});
  final NotifType notifType;
  final String? userId;
  final String? customMessage;
}

// TODO Improve whole notif system
class NotifCenter extends StatefulWidget {
  NotifCenter(this.notifStream);
  final Stream<Notif> notifStream;

  @override
  _NotifCenterState createState() => _NotifCenterState();
}

class _NotifCenterState extends State<NotifCenter> {

  static const int NOTIF_LIFETIME_MILLISECONDS = 3000;

  List<Widget> notifWidgets = [];
  StreamSubscription? sub;
  @override
  void initState() {
    // TODO: implement initState
    sub = widget.notifStream.listen((notif) {
      _onNewNotif(notif);
    });
  }

  void _onNewNotif(final Notif notif) async {
    final String? userId = notif.userId;
    Widget? notifWidget;

    switch(notif.notifType)
    {
      case NotifType.PlayerAdded:
        Widget nameWidget = BlocBuilder<GameRoomBloc, GameRoomState>(
            builder: (context, state){
              Player? player = state.model.getPlayer(userId);
              if(player == null) return EmptyWidget();
              return Text(player.name! + ' joined the game!', style: AppStyles.defaultStyle(fontSize: 32));
            }
        );
        Widget imageWidget = BlocBuilder<GameRoomBloc, GameRoomState>(
            builder: (context, state){
              Player? player = state.model.getPlayer(userId);
              if(player == null) return EmptyWidget();
              return player.profileImage!;
            }
        );
        notifWidget = NotifWidget(nameWidget, imageWidget);
        break;
      case NotifType.PlayerRemoved:
        // TODO: Handle this case.
        break;
      case NotifType.SettingsChanged:
        // TODO: Handle this case.
        break;
      case NotifType.MessageOnly:
        // TODO: Handle this case.
        break;
    }

    notifWidgets.add(notifWidget!);
    await Future.delayed(Duration(milliseconds: NOTIF_LIFETIME_MILLISECONDS));
    notifWidgets.remove(notifWidget);
  }

  @override
  void dispose() {
    // TODO: implement disposed
    if(sub != null) sub!.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Notif>(
      stream: widget.notifStream,
        builder: (context, snap)
        {
          if(!snap.hasData || snap.data == null) return EmptyWidget();
          return ListView.builder(
            itemCount: notifWidgets.length,
              itemBuilder: (context, i) => notifWidgets[i]);
        });
  }
}

class NotifWidget extends StatefulWidget {
  NotifWidget(this.title, this.image);
  final Widget title;
  final Widget? image;

  @override
  _NotifWidgetState createState() => _NotifWidgetState();
}

class _NotifWidgetState extends State<NotifWidget> with SingleTickerProviderStateMixin {
  static const int ENTRANCE_DURATION_MILLISECONDS = 350;

  late AnimationController _animController;
  @override
  void initState() {
    super.initState();
    _animController = new AnimationController(vsync: this);
    _animController.duration = Duration(milliseconds: ENTRANCE_DURATION_MILLISECONDS);
    _animController.forward(from: 0);
  }
  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    //double dx = (1-_animController.value)*MediaQuery.of(context).size.width;
    return Container(
      height: 75,
      color: Colors.pinkAccent,
      child: Row(
        children: [
          widget.image  == null ? EmptyWidget() : widget.image!.SizedBoxExt(height: 75, width: 75),
          widget.title.PaddingExt(EdgeInsets.all(8)).ExpandedExt()
        ],
      ),
    )
    ;
  }
}

class AnimatedListItem extends StatefulWidget {

  AnimatedListItem({required this.player, required this.animation, required this.index, this.score = 0, this.reversed = false, this.position = MIDDLE});
  final Animation<double>? animation;
  final Player? player;
  final int score;
  final int index;
  final bool reversed;
  final int position;

  static const int HIGHEST = 1;
  static const int MIDDLE = 0;
  static const int LOWEST = -1;

  @override
  _AnimatedListItemState createState() => _AnimatedListItemState();
}

class _AnimatedListItemState extends State<AnimatedListItem> with TickerProviderStateMixin {
  late AnimationController _animController;

  @override
  initState(){
    super.initState();

    _animController = new AnimationController(vsync: this);
    _animController.duration = Duration(seconds: 40);
    _animController.addListener(() {setState(() {
      radialOffsetValue = 360*_animController.value;
    });});
    //animation = new CurvedAnimation(parent: _animController, curve: OvershootCurve());
    _animController.repeat();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  double radialOffsetValue = 0;

  @override
  Widget build(BuildContext context) {
    //if(animation != null) animation.addListener(() {setState(() {});});

    double width = MediaQuery.of(context).size.width;

    final Player? player = widget.player;
    final Image? image = player == null ? null : player.profileImage;

    double screenHeight = MediaQuery.of(context).size.width;
    double dim = AVATAR_DIM;

    var avatar = Avatar(image,
        size: Size(dim,dim),
        loading: image == null,
        defaultImage: null)
        .SizedBoxExt(height: dim, width: dim);
    //.PaddingExt(EdgeInsets.all(spacing));

    String playerName = player == null || player.name == null ? '' : player.name!;
    var name = Container(
      decoration: BoxDecoration(color: AppColors.MainColor),
      child: Center(
        child: AutoSizeText(playerName,
            maxLines: 1,
            minFontSize: 10,
            style: TextStyle(fontSize: 50, color: Colors.white, fontFamily: FontFamily.lapsusProBold))
            .PaddingExt(EdgeInsets.symmetric(horizontal: 8)),
      ),
    );

    String scoreString = widget.score.toString();
    var score = Container(
      decoration: BoxDecoration(color: AppColors.ScoreColor),
      child: Center(
        child: AutoSizeText(scoreString,
            maxLines: 1,
            minFontSize: 10,
            style: TextStyle(fontSize: 50, color: Colors.white, fontFamily: FontFamily.lapsusProBold))
        ,
      ),
    );

    const double MINIMUM_NAME_TAG_WIDTH = 60;
    const double MAXIMUM_NAME_TAG_WIDTH = 150;
    double nameTagWidth = ui.lerpDouble(MINIMUM_NAME_TAG_WIDTH, MAXIMUM_NAME_TAG_WIDTH, Utils.howLongIsThisName(playerName))!;

    // TODO Style waiting room page ////////////////////////////////////////////////////////

    double nameLengthFactor = Utils.howLongIsThisName(playerName);
    double squishFactor = 3;

    var circularText = CircularText(
      radius: (AVATAR_DIM / 2) + AVATAR_RADIUS_OFFSET,
      children: [

        TextItem(
            startAngle: 270 + radialOffsetValue - Utils.howLongIsThisName(playerName) * 50,
            space: 12 - nameLengthFactor * squishFactor,
            text: Text(playerName, style: AppStyles.defaultStyle(fontSize: 24),)),

        TextItem(
            startAngle: 90 + radialOffsetValue - Utils.howLongIsThisName(playerName) * 50,
            space: 12 - nameLengthFactor * squishFactor,
            text: Text(playerName, style: AppStyles.defaultStyle(fontSize: 24),))
      ],);

    var finalWidget = Stack(
      children: [
        Center(child: avatar.PaddingExt(EdgeInsets.all(AVATAR_RADIUS_OFFSET))),
        Center(child: circularText,),
      ],
    ).SizedBoxExt(height: AVATAR_TOTAL_DIM, width: AVATAR_TOTAL_DIM);

    // To address clipping on the bottom item due to the vertical offset
    if(widget.position == AnimatedListItem.LOWEST)
    {
      finalWidget = finalWidget.PaddingExt(EdgeInsets.only(bottom: AVATAR_TOTAL_DIM));
    }

    // finalWidget = Row(children: [ finalWidget ])
    //     .ScaleExt(widget.animation?.value??1);

    finalWidget = finalWidget.ScaleExt(widget.animation?.value??1);

    double dx1, dx2, dy;

    // dx1: Space evenly
    double a = (width - 2*AVATAR_TOTAL_DIM) / 3;
    if(widget.index % 2 == 0) dx1 = -((a/2) + AVATAR_TOTAL_DIM/2);
    else dx1 = (a/2) + AVATAR_TOTAL_DIM/2;

    // dx2: Space only just enough to separate from center
    dx2 = AVATAR_TOTAL_DIM/2;
    if(widget.index % 2 == 0) dx2 = -dx2;

    // dy: Overlap by half of dimension
    dy = widget.index * AVATAR_TOTAL_DIM/2;
    dy = -dy;

    return Align(alignment: Alignment.topCenter, heightFactor: 0.5, child: finalWidget.TranslateExt(dx: dx2, dy: 0));
  }
}
