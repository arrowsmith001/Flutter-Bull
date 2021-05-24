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
import 'package:flutter_bull/pages/1MainMenu/_bloc_events.dart';
import 'package:flutter_bull/pages/1MainMenu/_bloc_states.dart';
import 'package:flutter_bull/pages/widgets.dart';
import 'package:flutter_bull/pages/1MainMenu/background.dart';
import 'package:flutter_bull/pages/1MainMenu/title.dart';
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
import '_bloc.dart';

class MainMenu extends StatefulWidget {

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> with TickerProviderStateMixin {

  MainMenuBloc get _bloc => BlocProvider.of<MainMenuBloc>(context, listen: false);

  late AnimationController _animController, _animController2, _animController3;
  late Animation<double> dialogPopAnim, anim1_1, anim1_2, anim1_3, anim1_4, anim1_5, anim1_6, anim1_7, anim1_8, anim1_Quick; // _animController1
  late Animation<double> anim2_1; // _animController2
  final Interpolator overshootInterp = OvershootInterpolator();
  final Interpolator hardOvershootInterp = OvershootInterpolator(5);
  final Interpolator decelInterp = DecelerateInterpolator(5);

  @override
  void initState() {
    super.initState();

    _bloc.add(SetupEvent());

    _animController = new AnimationController(vsync: this);
    _animController.addListener(() {setState(() { });});
    _animController.duration = Duration(milliseconds: 5000);
    dialogPopAnim = new Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _animController, curve: Interval(0, 0.1)));

    _animController2 = new AnimationController(vsync: this);
    _animController2.addListener(() {setState(() { });});
    _animController2.duration = Duration(milliseconds: 500);
    _animController2.value = 1;
    anim2_1 = new Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _animController2, curve: Interval(0, 1)));

    // Cyclic
    _animController3 = new AnimationController(vsync: this);
    _animController3.addListener(() {setState(() { });});
    _animController3.duration = Duration(milliseconds: 3000);
    _animController3.repeat(reverse: true);

    double intervalValue = 0.1, staggerValue = 0.01;
    anim1_Quick = new Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _animController, curve: Interval(0, 0.01)));
    anim1_1 = new Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _animController, curve: Interval(staggerValue, staggerValue + intervalValue)));
    anim1_2 = new Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _animController, curve: Interval(staggerValue*2, staggerValue*2 + intervalValue)));
    anim1_3 = new Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _animController, curve: Interval(staggerValue*3, staggerValue*3 + intervalValue)));
    anim1_4 = new Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _animController, curve: Interval(staggerValue*4, staggerValue*4 + intervalValue)));
    anim1_5 = new Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _animController, curve: Interval(staggerValue*5, staggerValue*5 + intervalValue)));
    anim1_6 = new Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _animController, curve: Interval(staggerValue*6, staggerValue*6 + intervalValue)));
    anim1_7 = new Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _animController, curve: Interval(staggerValue*7, staggerValue*7 + intervalValue)));
    anim1_8 = new Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _animController, curve: Interval(staggerValue*8, staggerValue*8 + intervalValue)));
    _animController.forward();

  }


  @override
  void dispose(){
    _animController.dispose();
    _animController2.dispose();
    _animController3.dispose();
    _profileSetupNameController.dispose();
    _nameTextController.dispose();
    _roomCodeTextController.dispose();
    super.dispose();
  }

  Future onTopBarPressed() async {
    _bloc.add(DebugEvent(clearAllPrefs: true));
  }

  onPrivacyPolicyAcceptedPressed(bool accepted) async {
    _bloc.add(PrivacyPolicyPressed(accepted));
  }

  onProfileSetupPressed(BuildContext context) async {
    _bloc.add(ProfileSetupPressed(_profileSetupNameController.text));
  }

  onTutorialSetupPressed(bool tutorialModeOn) async {
    _bloc.add(TutorialSetupPressed(tutorialModeOn));
  }


  void onCreateGame() async {
    _bloc.add(CreateGameEvent());
  }

  void onJoinGame() async {
    setState(() {
      enteringRoomCode = true;
    });
  }

  TextEditingController _roomCodeTextController = TextEditingController();
  bool enteringRoomCode = false;

  void onRoomCodeSubmitted(String code) async {
    setState(() {
      enteringRoomCode = false;
    });
    _bloc.add(JoinGameEvent(code));
  }


  bool goingToGameRoom = false;
  Future<void> goToGameRoom() async{
    if(goingToGameRoom) return;
    goingToGameRoom = true;
    await Navigator.of(context).push(Routes.MainMenu_To_GameRoom(context));
    goingToGameRoom = false;
  }

  // IMAGE SELECTION
  TextEditingController _profileSetupNameController = new TextEditingController();

  bool profileEditMenuOpen = false;
  bool loading = false;

  void onProfileImageTapped() {
    if(profileEditMenuOpen)
    {
      setState(() {
        profileEditMenuOpen = false;
        editingName = false;
        _animController.reverse(from: 1);
      });
    }
    else
    {
      setState(() {
        profileEditMenuOpen = true;
        _animController.forward(from: 0);
      });
    }
  }

  void profileImageSelection(ImageSource source) {
    _bloc.add(ImageSelectionRequested(new ImagePicker(), source));
  }

  Widget buildPlayerAvatar(BuildContext context, MainMenuModel model, {double borderWidth = 5, bool animate = true}) {
    Player? player = model.user;
    Image? profileImage = player == null ? null : player.profileImage;
    return Avatar(profileImage,
        defaultImage: Assets.images.shutter,
        borderWidth: borderWidth,
        borderFlashValue: animate ? _animController3.value : 0);
  }


  TextEditingController _nameTextController = TextEditingController();
  bool editingName = false;

  void onEditName() {
    setState(() {
      editingName = true;
    });
  }

  void onNameSubmitted(String text) {
    _bloc.add(NewNameSubmittedEvent(text));
    setState(() {
      editingName = false;
    });
  }

  // Todo generalize
  Widget buildEnterNameTextField(MainMenuModel model) {
    // TODO React to name change event
    if(model.user != null && model.user!.name == null) {
      _nameTextController.text = model.user!.name!;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text('Enter new name:',
            style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontFamily: FontFamily.lapsusProBold),
            textAlign: TextAlign.start),

        CupertinoTextField(
            autofocus: true,
            onSubmitted: (text){
              onNameSubmitted(text);
            },
            controller: _nameTextController,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3),
            ),
            style: TextStyle(fontSize: 64, color: Colors.white)

        )

      ],
    ).PaddingExt(EdgeInsets.all(8));
  }
  Widget buildEnterRoomCodeTextField(MainMenuModel model) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text('Enter room code:',
            style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontFamily: FontFamily.lapsusProBold),
            textAlign: TextAlign.start),

        CupertinoTextField(
            autofocus: true,
            onSubmitted: (code){
              onRoomCodeSubmitted(code);
            },
            controller: _roomCodeTextController,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3),
            ),
            style: TextStyle(fontSize: 64, color: Colors.white)

        )

      ],
    ).PaddingExt(EdgeInsets.all(8));
  }



  BoxDecoration getBackgroundDecoration(){
    // BACKGROUND
    var primaryColor = CupertinoTheme.of(context).primaryColor;
    var fadedPrimaryColor = ui.Color.lerp(primaryColor, Colors.white, 0.2)!;
    var darkenedPrimaryColor = ui.Color.lerp(primaryColor, Colors.black, 0.2)!;

    var backgroundGradientOffset = 0.04;
    return BoxDecoration(
        gradient: LinearGradient(
            colors: [
              fadedPrimaryColor,
              primaryColor,
              primaryColor,
              fadedPrimaryColor
            ],
            stops: [
              0, backgroundGradientOffset, 1-backgroundGradientOffset, 1
            ])
    );
  }

  Widget buildPrivacyPolicyDialog(BuildContext context, MainMenuModel model){
    return MyCupertinoStyleDialogWithButtons(
        columnChildren: [
          MyCupertinoStyleBox(
              borderRadius: MyBorderRadii.TOP_ONLY,

              content:
              Column(children: [

                Text('Utter Bull', style: TextStyle(fontSize: 24, fontFamily: FontFamily.lapsusProBold)).PaddingExt(EdgeInsets.fromLTRB(0,20,0,0)),
                Text('Privacy Policy', style: TextStyle(fontSize: 24)).PaddingExt(EdgeInsets.fromLTRB(0,5,0,10)),
              ],)),

          SingleChildScrollView(
            child: Text(model.privacyPolicyString??'Error: Privacy policy not found.'),
          ).PaddingExt(EdgeInsets.symmetric(horizontal: 20, vertical: 10)).ExpandedExt(),

        ],
        buttons: [

          MyCupertinoStyleButton(
              height: 100,
              glowPosition: Alignment.bottomLeft,
              value: _animController3.value,
              color: Color.fromARGB(255, 255, 206, 206),
              borderRadius: MyBorderRadii.BOTTOM_LEFT_ONLY,
              text: AutoSizeText('I\'m not okay with that', textAlign: TextAlign.center,
                  minFontSize: 16, style: TextStyle(color: Colors.red, fontFamily: FontFamily.lapsusProBold, fontSize: 32)),
              onPressed: () => onPrivacyPolicyAcceptedPressed(false)),

          MyCupertinoStyleButton(
              height: 100,
              glowPosition: Alignment.bottomRight,
              value: _animController3.value,
              color: Color.fromARGB(255, 211, 243, 255),
              borderRadius: MyBorderRadii.BOTTOM_RIGHT_ONLY,
              text: AutoSizeText('I\'m cool with that', textAlign: TextAlign.center,
                  minFontSize: 16, style: TextStyle(color: Color.fromARGB(
                      255, 27, 47, 163), fontFamily: FontFamily.lapsusProBold, fontSize: 32)),
              onPressed: () => onPrivacyPolicyAcceptedPressed(true)),


        ],
        flexList: [1, 2]
    );
  }

  Widget buildProfileSetupDialog(BuildContext context, MainMenuModel model){
    Player? player = model.user;
    String? name = player == null ? null : player.name;
    Image? profileImage = player == null ? null : player.profileImage;

    return MyCupertinoStyleDialog(
        [
          Column(
            children: [

              MyCupertinoStyleBox(
                  borderRadius: MyBorderRadii.TOP_ONLY,
                  content: Text('Set up your profile', style: TextStyle(fontSize: 24, fontFamily: FontFamily.lapsusProBold))
                      .PaddingExt(EdgeInsets.fromLTRB(0,15,0,10))
                      .ScaleExt(hardOvershootInterp.getValue(anim1_1.value))
              ),

              Text('Just a photo and name, so your friends recognise you!', style: TextStyle(fontSize: 20), textAlign: TextAlign.center,)
                  .PaddingExt(EdgeInsets.fromLTRB(0,20,0,0))
                  .ScaleExt(hardOvershootInterp.getValue(anim1_2.value)),

            ],
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Photo', style: TextStyle(
                      fontSize: 24,
                      fontFamily: FontFamily.lapsusProBold,
                      fontWeight: FontWeight.bold)),
                  profileImage == null ? EmptyWidget() : Icon(Icons.done, color: Colors.green,)
                ],
              ).PaddingExt(EdgeInsets.symmetric(vertical: 12))
                  .ScaleExt(hardOvershootInterp.getValue(anim1_3.value))
                  .FlexibleExt(),

              GestureDetector(
                onTap: () { profileImageSelection(ImageSource.camera); },
                child: buildPlayerAvatar(context, model),
              )
                  .ScaleExt(hardOvershootInterp.getValue(anim2_1.value))
                  .ScaleExt(hardOvershootInterp.getValue(anim1_4.value))
                  .ExpandedExt(),

              CupertinoButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.image),
                      Text('Choose from gallery', style: TextStyle(color: Colors.black)).PaddingExt(EdgeInsets.symmetric(horizontal: 8))
                    ],
                  ),
                  onPressed: (){ profileImageSelection(ImageSource.gallery); }
              ).ScaleExt(hardOvershootInterp.getValue(anim1_5.value))
            ],
          )
              .FlexibleExt(4),

          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Name', style: TextStyle(
                      fontSize: 24,
                      fontFamily: FontFamily.lapsusProBold,
                      fontWeight: FontWeight.bold)),
                  _profileSetupNameController.value.text == '' ? EmptyWidget() : Icon(Icons.done, color: Colors.green,)
                ],
              ).PaddingExt(EdgeInsets.symmetric(vertical: 12))
                  .ScaleExt(hardOvershootInterp.getValue(anim1_6.value))
                  .FlexibleExt(),

              CupertinoTextField(
                placeholder: name == null ? 'Enter your name here' : name,
                placeholderStyle: TextStyle(fontFamily: FontFamily.lapsusProBold,color: Colors.grey),
                controller: _profileSetupNameController,
                padding: EdgeInsets.all(18),)
                  .PaddingExt(EdgeInsets.symmetric(horizontal: 20))
                  .ScaleExt(hardOvershootInterp.getValue(anim1_7.value))
            ],
          )
              .FlexibleExt(2),

          Text('You can edit these any time').FlexibleExt(),

          MyCupertinoStyleButton(
            onPressed: () => onProfileSetupPressed(context),
            borderRadius: MyBorderRadii.BOTTOM_ONLY,
            text: Text('Finish', textAlign: TextAlign.center, style: TextStyle(fontSize: 32, fontFamily: FontFamily.lapsusProBold,
                color: profileImage == null || name == null
                    ? Colors.grey : Colors.blueAccent)),)
        ]);
  }

  Widget buildTutorialSetup(BuildContext context){
    return MyCupertinoStyleDialogWithButtons(
        columnChildren: [
          MyCupertinoStyleBox(
            borderRadius: MyBorderRadii.TOP_ONLY,
            content: Column(
              children: [
                Text('Welcome to Utter Bull!!',
                    style: TextStyle(fontSize: 24, fontFamily: FontFamily.lapsusProBold))
                    .ScaleExt(hardOvershootInterp.getValue(anim1_1.value))
                    .PaddingExt(EdgeInsets.fromLTRB(0,20,0,10)),


                SizedBox(child: Assets.images.bullIcon.image(), height: hardOvershootInterp.getValue(anim1_6.value)*150)
                    .PaddingExt(EdgeInsets.fromLTRB(0,10,0,10))


              ],
            ),
          ),

          Column(
              children: [
                Text("This is a social game to play with a few friends. Make sure you\'re all in the same room or video call.",
                  textAlign: TextAlign.center,).PaddingExt(EdgeInsets.symmetric(vertical: 12))
                    .ScaleExt(hardOvershootInterp.getValue(anim1_2.value)),

                RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        style: TextStyle(color: Colors.black),
                        children:
                        [
                          TextSpan(text: 'If you\'ve never played Utter Bull, it is '),
                          TextSpan(text: 'highly', style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: ' recommended that you '),
                          TextSpan(text: 'enable tutorial hints', style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold)),
                          TextSpan(text: ' throughout your first game. You can disable these any time.')
                        ])).PaddingExt(EdgeInsets.symmetric(vertical: 12)).ScaleExt(hardOvershootInterp.getValue(anim1_3.value)),

                RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        style: TextStyle(color: Colors.black),
                        children:
                        [
                          TextSpan(text: "All tutorial info can be identified by...")
                        ])).PaddingExt(EdgeInsets.symmetric(vertical: 12))
                    .ScaleExt(hardOvershootInterp.getValue(anim1_4.value)),
              ]
          ).PaddingExt(EdgeInsets.symmetric(horizontal: 16)),

          Container().ExpandedExt(),

        ],
        flexList: [1, 2],
        buttons: [

          MyCupertinoStyleButton(
              height: 100,
              glowPosition: Alignment.bottomLeft,
              value: _animController3.value,
              color: Color.fromARGB(255, 255, 206, 206),
              borderRadius: MyBorderRadii.BOTTOM_LEFT_ONLY,
              text: AutoSizeText('No tutorial info, I\'m already a pro', textAlign: TextAlign.center,
                  minFontSize: 16, style: TextStyle(color: Colors.red, fontFamily: FontFamily.lapsusProBold, fontSize: 32)),
              onPressed: () => onTutorialSetupPressed(false)).ScaleExt(hardOvershootInterp.getValue(anim1_6.value)),

          MyCupertinoStyleButton(
              height: 100,
              glowPosition: Alignment.bottomRight,
              value: _animController3.value,
              color: Color.fromARGB(255, 211, 243, 255),
              borderRadius: MyBorderRadii.BOTTOM_RIGHT_ONLY,
              text: AutoSizeText('Yes! Enable all tutorial info', textAlign: TextAlign.center,
                  minFontSize: 16, style: TextStyle(color: Color.fromARGB(
                      255, 27, 47, 163), fontFamily: FontFamily.lapsusProBold, fontSize: 32)),
              onPressed: () => onTutorialSetupPressed(true)).ScaleExt(hardOvershootInterp.getValue(anim1_7.value)),



        ]
    );
  }

  Widget buildUserBar(BuildContext context, MainMenuModel model){
    Player? player = model.user;
    Image? playerImage = player == null ? null : player.profileImage;

    var userBarLeft = GestureDetector(
      onTap: () async {
        onTopBarPressed();
      },
      child: Container( height:75,
          decoration: BoxDecoration(
              color: Color.fromARGB(205, 255, 116, 116),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.only(topRight: Radius.circular(100), bottomRight: Radius.circular(100)))
      ),
    );

    var userBarRight = Stack(
      children: [

        GestureDetector(
            child: Column(
              children: [

                Container(
                    height:125,
                    child: buildPlayerAvatar(context, model, animate: false),
                ).ScaleExt(hardOvershootInterp.getValue(_animController2.value)),

                player == null || player.name == null ? EmptyWidget()
                    : Transform.translate(
                  offset: Offset(0, -20),
                  child: AutoSizeText(player.name, minFontSize: 10, maxLines: 1,
                      style: TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                          backgroundColor: Colors.blueAccent,
                          fontFamily: FontFamily.lapsusProBold)),
                )
              ],
            ),
            onTap: (){
              onProfileImageTapped();
            }),


      ],
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

      children: [
        userBarLeft.FlexibleExt(2),

        userBarRight.PaddingExt(EdgeInsets.symmetric(horizontal: 20)).FlexibleExt(1)
      ],
    );
  }

  Widget buildProfileEditMenu(BuildContext context){
    return Container(
      child: Align(
        alignment: Alignment.topRight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [

            MyListItem(
              onTap: () { profileImageSelection(ImageSource.camera); },
              text: 'New photo from camera', iconData: Icons.camera,)
                .PaddingExt(EdgeInsets.only(bottom: 10, right: 15))
                .TranslateExt(dy: ((1-hardOvershootInterp.getValue(anim1_Quick.value))*-20).toDouble()),
            MyListItem(
              onTap: () { profileImageSelection(ImageSource.gallery); },
              text: 'New photo from gallery', iconData: Icons.add_photo_alternate_outlined,)
                .PaddingExt(EdgeInsets.only(bottom: 10, right: 15))
                .TranslateExt(dy: ((1-hardOvershootInterp.getValue(anim1_Quick.value))*-50).toDouble()),
            MyListItem(
              onTap: () { onEditName(); },
              text: 'Change name', iconData: Icons.edit,)
                .PaddingExt(EdgeInsets.only(bottom: 10, right: 15))
                .TranslateExt(dy: ((1-hardOvershootInterp.getValue(anim1_Quick.value))*-100).toDouble()),

          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {


    // BUTTONS
    var buttonIconSize = 65.0;
    var minFontSize = 10.0;
    var fontSize = 30.0;

    Widget createGameButton = MainMenuButton("CREATE GAME", Assets.images.bullAddGlowBrown.image(), () async { onCreateGame(); },
        fontSize: fontSize, minFontSize: minFontSize, imageSize: buttonIconSize);

    Widget joinGameButton = MainMenuButton("JOIN GAME", Assets.images.arrowsGlowBrownEdit.image(), () async { onJoinGame(); },
        fontSize: fontSize+10, minFontSize: minFontSize, imageSize: buttonIconSize+10);


    const int USER_BAR_FLEX = 0;
    const int TITLE_FLEX = 4;
    const int BUTTONS_FLEX = 0;


    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [

              MainMenuBackgroundEffect(),

              BlocConsumer<MainMenuBloc, MainMenuState>(
                  buildWhen: (s1, s2) {
                    return s2 is DialogState || s2 is MenuState;
                  },
                  listener: (context, s){
                    if(s is DialogState || s is MenuState) _animController.forward(from: 0);
                    if(s is UserProfileImageChangedState) {_animController2.forward(from: 0);}
                    if(s is GoToGameRoomState) goToGameRoom();

                  },
                  builder: (context, state){

                    Player? player = state.model.user;
                    Image? playerImage = player == null ? null : player.profileImage;

                    if(state is InitialState) return EmptyWidget();

                    if(state is DialogState)
                    {

                      Widget? dialog;

                      if(state is PrivacyPolicyState) dialog = buildPrivacyPolicyDialog(context, state.model);
                      if(state is ProfileSetupState) dialog = buildProfileSetupDialog(context, state.model);
                      if(state is TutorialSetupState) dialog = buildTutorialSetup(context);

                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          dialog!.FlexibleExt()
                        ],
                      ).ScaleExt(0.6 + 0.4 * overshootInterp.getValue(dialogPopAnim.value));

                    }

                    return Stack(
                      children: [

                        // Main Column
                        Column(
                          children: [

                            // Invisible user bar, for spacing purposes
                            buildUserBar(context, state.model)
                                .PaddingExt(EdgeInsets.fromLTRB(0, 10, 0, 10))
                                .InvisibleIgnoreExt()
                                .FlexibleExt(USER_BAR_FLEX),

                            Container(
                              //color: AppColors.DebugColor,
                              child: Column(
                                children: [
                                  UtterBullTitle().ExpandedExt(),
                                ],
                              ),
                            ).ExpandedExt(),

                            // Join/Create Game Buttons
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [

                                createGameButton,

                                joinGameButton,

                              ],
                            ).PaddingExt(new EdgeInsets.fromLTRB(0,0,0,20)).FlexibleExt(BUTTONS_FLEX)

                          ],
                        ),


                        // Grey translucent layer
                        profileEditMenuOpen ? GestureDetector(
                            onTap: () { onProfileImageTapped(); },
                            child: Container(color: Colors.black54.withOpacity(0.8),))
                            .OpacityExt(anim1_Quick.value) : EmptyWidget(),

                        // Overlaying column
                        Column(
                          children: [

                            // Actual user bar
                            buildUserBar(context, state.model)
                                .PaddingExt(EdgeInsets.fromLTRB(0, 10, 0, 10))
                                .FlexibleExt(USER_BAR_FLEX),

                            // On profile tapped list
                            profileEditMenuOpen ? buildProfileEditMenu(context).ExpandedExt() : EmptyWidget()
                          ],
                        ),


                        // Overlaying container with progress indicator
                        !loading ? EmptyWidget() : Container(
                          color: Colors.grey.withOpacity(0.3),
                          child: Center(
                            child: CircularProgressIndicator(backgroundColor: Colors.redAccent,),
                          ),
                        ),

                        !editingName ? EmptyWidget() :
                        buildEnterNameTextField(state.model),

                        !enteringRoomCode ? EmptyWidget() :
                        buildEnterRoomCodeTextField(state.model)


                      ],
                    );

                    // Main stack

                  })


            ],
          )


      ).BoxDecorationContainerExt(getBackgroundDecoration()),
    );

  }








}


