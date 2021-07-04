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
import 'package:flutter_bull/utilities/local_res.dart';
import 'package:flutter_bull/utilities/repository.dart';
import 'package:flutter_bull/widgets/misc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prefs/prefs.dart';
import 'package:provider/provider.dart';
import '../../classes/classes.dart';
import 'package:extensions/extensions.dart';
import 'package:design/design.dart';
import 'dart:ui' as ui;

import '../../routes.dart';
import '_bloc.dart';

// TODO Make MainMenu impeccable. Establish style. <<<<<<<<<<<<<<<<<<<<<
// TODO Implement notification center for error messages <<<<<<<<<<<<<<<<<<<<<<<<< line 610

class MainMenu extends StatefulWidget {

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> with TickerProviderStateMixin {

  MainMenuBloc get _bloc => BlocProvider.of<MainMenuBloc>(context, listen: false);

  late AnimationController _animController, _animController2, _animController3, _animController4;
  late List<Animation<double>> anims1;
  late Animation<double> dialogPopAnim, anim1_Quick; // _animController1
  late Animation<double> anim2_1; // _animController2
  final Curve overshootInterp = OvershootCurve();
  final Curve hardOvershootInterp = OvershootCurve(5);
  final Curve decelInterp = DecelerateCurve(5);
  final Curve antiOverInterp = AnticipateOvershootCurve(3);

  @override
  void initState() {
    super.initState();

    _bloc.add(SetupEvent());

    _animController = new AnimationController(vsync: this, duration: const Duration(milliseconds: 5000));
    _animController.addListener(() {setState(() { });});
    dialogPopAnim = new Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _animController, curve: Interval(0, 0.1)));

    // Profile pop
    _animController2 = new AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _animController2.addListener(() {setState(() { });});
    _animController2.value = 1;
    anim2_1 = new Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _animController2, curve: Interval(0, 1)));

    // Cyclic
    _animController3 = new AnimationController(vsync: this, duration: const Duration(milliseconds: 3000));
    _animController3.addListener(() {setState(() { });});
    _animController3.repeat(reverse: true);

    // Button panel
    _animController4 = new AnimationController(vsync: this, duration: const Duration(milliseconds: 750));
    _animController4.addListener(() {setState(() { });});

    double intervalValue = 0.1, staggerValue = 0.01;
    anim1_Quick = new Tween<double>(begin: 0, end: 1).animate(new CurvedAnimation(parent: _animController, curve: Interval(0, 0.01)));
    anims1 = List.generate(8, (i) => new Tween<double>(begin: 0, end: 1).animate(
        new CurvedAnimation(parent: _animController,
            curve: Interval((i+1)*staggerValue, (i+1)*staggerValue + intervalValue))));
    _animController.forward();

  }

  @override
  void dispose(){
    _animController.dispose();
    _animController2.dispose();
    _animController3.dispose();
    _animController4.dispose();
    _profileSetupNameController.dispose();
    _nameTextController.dispose();
    _roomCodeTextController.dispose();
    super.dispose();
  }


  String? errorMessage;
  void _blocListen(BuildContext context, MainMenuState s) {
    //if(isInMenuState) print(s.model.userEstablished.toString() + ' ' + s.model.roomEstablished.toString());
    if(s is DialogState || s is MenuState) {
      _animController.forward(from: 0);
    }
    if(s is UserProfileImageChangedState) {_animController2.forward(from: 0);}
    if(s is NewRoomState) goToGameRoom();
    if(s is GameLeftState) _animController4.reverse(from: 1);

    if(s is ErrorState){
      // TODO Make error appear
      setState(() {
        errorMessage = s.message;
      });
    }

    // if(s.model.menuState is MenuState){
    //   if(!s.model.userEstablished) setLoading(true, 'Loading user account...');
    //   else if(!s.model.roomEstablished) setLoading(true, 'Loading current game...');
    //   else setLoading(false, null);
    // }
    //
    // if(s is LoadingState)
    //   {
    //     setLoading(s.loading, s.message);
    //   }

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
    setState(() {
      creatingGame = true;
    });
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
      joiningGame = true;
    });
    _bloc.add(JoinGameEvent(code));
  }

  void onResumeGame() {
    resumingGame = true;
    goToGameRoom();
  }

  void onLeaveGame() {
    leavingGame = true;
    _bloc.add(LeaveGameEvent());
  }

  bool loading = true;
  String? loadingMessage;

  bool goingToGameRoom = false;
  bool creatingGame = false;
  bool joiningGame = false;
  bool resumingGame = false;
  bool leavingGame = false;

  // TODO Either forbid popping scope to main menu, or reset variables to allow re-creating rooms
  Future<void> goToGameRoom() async {
    if(!_animController4.isCompleted) _animController4.forward(from: 0);
    if(goingToGameRoom) {
      print('goToGameRoom denied: goingToGameRoom == true');
      return;
    }
    if(!creatingGame && !joiningGame && !resumingGame)  {
      print('goToGameRoom denied: creatingGame == ${creatingGame.toString()}, joiningGame == ${joiningGame.toString()}, resumingGame == ${resumingGame.toString()}, ');
      return;
    }
    setState(() {
      goingToGameRoom = true;
      creatingGame = false;
      joiningGame = false;
    });
    await Navigator.of(context).push(Routes.MainMenu_To_GameRoom(context));
    goingToGameRoom = false;
  }

  // IMAGE SELECTION
  TextEditingController _profileSetupNameController = new TextEditingController();

  bool profileEditMenuOpen = false;

  void onProfileImageTapped() {
    setState(() {
      enteringRoomCode = false;
      if(profileEditMenuOpen)
      {
        profileEditMenuOpen = false;
        editingName = false;
        _animController.reverse(from: 1);
      }
      else
      {
        profileEditMenuOpen = true;
        _animController.forward(from: 0);
      }
    });
  }

  ImagePicker picker = new ImagePicker();
  void profileImageSelection(ImageSource source) {
    _bloc.add(ImageSelectionRequested(picker, source));
  }

  Widget _buildPlayerAvatar(BuildContext context, MainMenuModel model,
      {double borderWidth = 5, bool animate = true, double dim = 50}) {
    Player? player = model.user;
    Image? profileImage = player == null ? null : player.profileImage;
    return Avatar(profileImage,
        size: Size(dim, dim),
        borderWidth: borderWidth,
        borderFlashValue: animate ? _animController3.value : 0);
  }

  Widget _buildProfileAvatarSelect(BuildContext context, MainMenuModel model) {
    Player? player = model.user;
    Image? profileImage = player == null ? null : player.profileImage;
    return Avatar(profileImage,
        size: Size(500, 500),
        defaultImage: Assets.images.shutter,
        borderWidth: 5,
        borderFlashValue: _animController3.value);
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

  // Todo combine
  Widget buildEnterNameTextField(MainMenuModel model) {
    // TODO React to name change event
    if(model.user != null && model.user!.name != null) {
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
    ).xPadding(EdgeInsets.all(8));
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
    ).xPadding(EdgeInsets.all(8));
  }


  BoxDecoration getBackgroundDecoration(BuildContext context){
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

  Widget _buildPrivacyPolicyDialog(BuildContext context, MainMenuModel model){
    return MyCupertinoStyleDialogWithButtons(
        columnChildren: [
          MyCupertinoStyleBox(
              borderRadius: MyBorderRadii.TOP_ONLY,

              content:
              Column(children: [

                Text('Utter Bull', style: TextStyle(fontSize: 24, fontFamily: FontFamily.lapsusProBold)).xPadding(EdgeInsets.fromLTRB(0,20,0,0)),
                Text('Privacy Policy', style: TextStyle(fontSize: 24)).xPadding(EdgeInsets.fromLTRB(0,5,0,10)),
              ],)),

          SingleChildScrollView(
            child: Text(model.privacyPolicyString??'Error: Privacy policy not found.'),
          ).xPadding(EdgeInsets.symmetric(horizontal: 20, vertical: 10)).xExpanded(),

        ],
        buttons: [

          MyCupertinoStyleButton(
              height: 100,
              glowPosition: Alignment.bottomLeft,
              value: _animController3.value,
              //color: Color.fromARGB(255, 255, 206, 206),
              borderRadius: MyBorderRadii.BOTTOM_LEFT_ONLY,
              text: AutoSizeText('I\'m not okay with that', textAlign: TextAlign.center,
                  minFontSize: 16, style: TextStyle(color: Colors.red, fontFamily: FontFamily.lapsusProBold, fontSize: 32)),
              onPressed: () => onPrivacyPolicyAcceptedPressed(false)),

          MyCupertinoStyleButton(
              height: 100,
              glowPosition: Alignment.bottomRight,
              value: _animController3.value,
              //color: Color.fromARGB(255, 211, 243, 255),
              borderRadius: MyBorderRadii.BOTTOM_RIGHT_ONLY,
              text: AutoSizeText('I\'m cool with that', textAlign: TextAlign.center,
                  minFontSize: 16, style: TextStyle(color: Color.fromARGB(
                      255, 27, 47, 163), fontFamily: FontFamily.lapsusProBold, fontSize: 32)),
              onPressed: () => onPrivacyPolicyAcceptedPressed(true)),


        ],
        flexList: [1, 2]
    );
  }

  Widget _buildProfileSetupDialog(BuildContext context, MainMenuModel model){
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
                      .xPadding(EdgeInsets.fromLTRB(0,15,0,10))
                      .xScale(hardOvershootInterp.transform(anims1[0].value))
              ),

              Text('Just a photo and name, so your friends recognise you!', style: TextStyle(fontSize: 20), textAlign: TextAlign.center,)
                  .xPadding(EdgeInsets.fromLTRB(0,20,0,0))
                  .xScale(hardOvershootInterp.transform(anims1[1].value)),

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
              ).xPadding(EdgeInsets.symmetric(vertical: 12))
                  .xScale(hardOvershootInterp.transform(anims1[2].value))
                  .xFlexible(),

              GestureDetector(
                onTap: () { profileImageSelection(ImageSource.camera); },
                child: _buildProfileAvatarSelect(context, model),
              )
                  .xScale(hardOvershootInterp.transform(anim2_1.value))
                  .xScale(hardOvershootInterp.transform(anims1[3].value))
                  .xExpanded(),

              CupertinoButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.image),
                      Text('Choose from gallery', style: TextStyle(color: Colors.black)).xPadding(EdgeInsets.symmetric(horizontal: 8))
                    ],
                  ),
                  onPressed: (){ profileImageSelection(ImageSource.gallery); }
              ).xScale(hardOvershootInterp.transform(anims1[4].value))
            ],
          )
              .xFlexible(4),

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
              ).xPadding(EdgeInsets.symmetric(vertical: 12))
                  .xScale(hardOvershootInterp.transform(anims1[5].value))
                  .xFlexible(),

              CupertinoTextField(
                autocorrect: false,
                style: TextStyle(fontSize: 24, fontFamily: FontFamily.lapsusProBold,),
                decoration: BoxDecoration(color:Colors.white),
                placeholder: name == null ? 'Enter your name here' : name,
                placeholderStyle: TextStyle(fontSize: 24, fontFamily: FontFamily.lapsusProBold,color: Colors.black.withOpacity(0.3)),
                controller: _profileSetupNameController,
                padding: EdgeInsets.all(18),)
                  .xPadding(EdgeInsets.symmetric(horizontal: 20))
                  .xScale(hardOvershootInterp.transform(anims1[6].value))
            ],
          )
              .xFlexible(2),

          Text('You can edit these any time').xFlexible(),

          MyCupertinoStyleButton(
            onPressed: () => onProfileSetupPressed(context),
            borderRadius: MyBorderRadii.BOTTOM_ONLY,
            text: Text('Finish', textAlign: TextAlign.center, style: TextStyle(fontSize: 32, fontFamily: FontFamily.lapsusProBold,
                color: profileImage == null || name == null
                    ? Colors.grey : Colors.blueAccent)),)
        ]);
  }

  Widget _buildTutorialSetup(BuildContext context){
    return MyCupertinoStyleDialogWithButtons(
        columnChildren: [
          MyCupertinoStyleBox(
            borderRadius: MyBorderRadii.TOP_ONLY,
            content: Column(
              children: [
                Text('Welcome to Utter Bull!!',
                    style: TextStyle(fontSize: 24, fontFamily: FontFamily.lapsusProBold))
                    .xScale(hardOvershootInterp.transform(anims1[0].value))
                    .xPadding(EdgeInsets.fromLTRB(0,20,0,10)),


                SizedBox(child: Assets.images.bullIcon.image(), height: hardOvershootInterp.transform(anims1[1].value)*150)
                    .xPadding(EdgeInsets.fromLTRB(0,10,0,10))


              ],
            ),
          ),

          Column(
              children: [
                Text("This is a social game to play with a few friends. Make sure you\'re all in the same room or video call.",
                  textAlign: TextAlign.center,).xPadding(EdgeInsets.symmetric(vertical: 12))
                    .xScale(hardOvershootInterp.transform(anims1[2].value)),

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
                        ])).xPadding(EdgeInsets.symmetric(vertical: 12)).xScale(hardOvershootInterp.transform(anims1[3].value)),

                RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        style: TextStyle(color: Colors.black),
                        children:
                        [
                          TextSpan(text: "All tutorial info can be identified by...")
                        ])).xPadding(EdgeInsets.symmetric(vertical: 12))
                    .xScale(hardOvershootInterp.transform(anims1[4].value)),
              ]
          ).xPadding(EdgeInsets.symmetric(horizontal: 16)),

          Container().xExpanded(),

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
              onPressed: () => onTutorialSetupPressed(false)).xScale(hardOvershootInterp.transform(anims1[5].value)),

          MyCupertinoStyleButton(
              height: 100,
              glowPosition: Alignment.bottomRight,
              value: _animController3.value,
              color: Color.fromARGB(255, 211, 243, 255),
              borderRadius: MyBorderRadii.BOTTOM_RIGHT_ONLY,
              text: AutoSizeText('Yes! Enable all tutorial info', textAlign: TextAlign.center,
                  minFontSize: 16, style: TextStyle(color: Color.fromARGB(
                      255, 27, 47, 163), fontFamily: FontFamily.lapsusProBold, fontSize: 32)),
              onPressed: () => onTutorialSetupPressed(true)).xScale(hardOvershootInterp.transform(anims1[6].value)),



        ]
    );
  }

  Widget _buildUserBar(BuildContext context, MainMenuModel model){
    Player? player = model.user;
    Image? playerImage = player == null ? null : player.profileImage;

    var userBarLeft = GestureDetector(
      onTap: () async {
        onTopBarPressed();
      },

      child: Stack(
        children: [
          Container(
              child: errorMessage == null ? null
                  : AutoSizeText(errorMessage!, minFontSize: 10, style: AppStyles.defaultStyle())
                  .xPadOnly(right: 75, left: 12, top: 4, bottom: 4),
              height:75,
              decoration: BoxDecoration(
                  color: Color.fromARGB(205, 255, 116, 116),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(100), bottomRight: Radius.circular(100)))
          ),

          Positioned(
            right: 0,
            child: Transform.rotate(
              angle: math.pi,
              child: Container(
                height:75,
                width:75,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: Assets.images.info),
                      color: Color.fromARGB(159, 255, 255, 255),
                      shape: BoxShape.circle
                   ),
          ),
            )),

        ],
      ),
    );

    const double USER_BAR_AVATAR_DIM = 125;
    var userBarRight = Stack(
      children: [

        GestureDetector(
            child: Column(
              children: [

                Container(
                    height: USER_BAR_AVATAR_DIM,
                    child: _buildPlayerAvatar(context, model, animate: false, dim: USER_BAR_AVATAR_DIM),
                ).xScale(hardOvershootInterp.transform(_animController2.value)),

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
        userBarLeft.xFlexible(2),

        userBarRight.xPadding(EdgeInsets.symmetric(horizontal: 20)).xFlexible(1)
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
                .xPadding(EdgeInsets.only(bottom: 10, right: 15))
                .xTranslate(dy: ((1-hardOvershootInterp.transform(anim1_Quick.value))*-20).toDouble()),
            MyListItem(
              onTap: () { profileImageSelection(ImageSource.gallery); },
              text: 'New photo from gallery', iconData: Icons.add_photo_alternate_outlined,)
                .xPadding(EdgeInsets.only(bottom: 10, right: 15))
                .xTranslate(dy: ((1-hardOvershootInterp.transform(anim1_Quick.value))*-50).toDouble()),
            MyListItem(
              onTap: () { onEditName(); },
              text: 'Change name', iconData: Icons.edit,)
                .xPadding(EdgeInsets.only(bottom: 10, right: 15))
                .xTranslate(dy: ((1-hardOvershootInterp.transform(anim1_Quick.value))*-100).toDouble()),

          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;

    // BUTTONS
    var buttonIconSize = 65.0;
    var minFontSize = 10.0;
    var fontSize = 30.0;

    Widget createGameButton = MainMenuButton("CREATE GAME", Assets.images.bullAddGlowBrown.image(), () => onCreateGame(),
        fontSize: fontSize, minFontSize: minFontSize, imageSize: buttonIconSize);

    Widget joinGameButton = MainMenuButton("JOIN GAME", Assets.images.arrowsGlowBrownEdit.image(), () => onJoinGame(),
        fontSize: fontSize+10, minFontSize: minFontSize, imageSize: buttonIconSize+10);

    Widget resumeGameButton = MainMenuButton("RESUME", Assets.images.arrowsGlowBrownEdit.image(), () => onResumeGame(),
        fontSize: fontSize+16, minFontSize: minFontSize, fontColor: Colors.lightGreenAccent, imageSize: buttonIconSize+10);

    Widget leaveGameButton = MainMenuButton("LEAVE GAME", Assets.images.arrowsGlowBrownEdit.image(), () => onLeaveGame(),
        fontSize: fontSize, minFontSize: minFontSize, fontColor: Colors.white, imageSize: buttonIconSize+10);

    Widget buttonPanel1 = Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [

        createGameButton,

        joinGameButton,

      ],
    );

    Widget buttonPanel2 = Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [

        leaveGameButton,

        resumeGameButton,

      ],
    );

    const int USER_BAR_FLEX = 0;
    const int TITLE_FLEX = 4;
    const int BUTTONS_FLEX = 0;

    var utterBullAspectRatio = 1.5;//1.25;
    var utterBullTitle = Container(
      //color: AppColors.DebugColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AspectRatio(
              aspectRatio: utterBullAspectRatio,
              child: Container(color: Colors.pink,
                  child: UtterBullTitle(size: Size(size.width, size.width/utterBullAspectRatio)))).xFlexible(),
        ],
      ),
    );


    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
        body: BlocConsumer<MainMenuBloc, MainMenuState>(
          listener: (context, s) => _blocListen(context, s),
          builder: (context, state)
          {
            Player? player = state.model.user;
            Image? playerImage = player == null ? null : player.profileImage;
            bool currentlyOccupyingRoom = player != null && player.occupiedRoomCode != null;

            bool isInMenuState = state.model.menuState is MenuState;

            return Stack(
              children: [

                MainMenuBackgroundEffect(),

                SafeArea(
                  child: LayoutBuilder(
                      builder: (context, constraints){

                        if(state.model.menuState is InitialState) return MyLoadingIndicator();

                        if(state.model.menuState is DialogState)
                        {

                          Widget? dialog;

                          if(state.model.menuState is PrivacyPolicyState) dialog = _buildPrivacyPolicyDialog(context, state.model);
                          if(state.model.menuState is ProfileSetupState) dialog = _buildProfileSetupDialog(context, state.model);
                          if(state.model.menuState is TutorialSetupState) dialog = _buildTutorialSetup(context);

                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              dialog!.xFlexible()
                            ],
                          ).xScale(0.6 + 0.4 * overshootInterp.transform(dialogPopAnim.value));

                        }

                        return Stack(
                          children: [

                            // Main Column
                            Column(
                              children: [

                                // Invisible user bar, for spacing purposes
                                _buildUserBar(context, state.model)
                                    .xPadding(EdgeInsets.fromLTRB(0, 10, 0, 10))
                                    .xInvisibleIgnore()
                                    .xFlexible(USER_BAR_FLEX),

                                utterBullTitle.xExpanded(),

                                // Join/Create Game Buttons
                                AnimatedBuilder(
                                  child: _animController4.value < 0.5 ? buttonPanel1 : buttonPanel2,
                                  animation: _animController4,
                                  builder: (BuildContext context, Widget? child) {
                                    double val = antiOverInterp.transform(math.sin(math.pi*_animController4.value));
                                    return Transform.translate(
                                        child: Opacity(
                                          child: child,
                                          opacity: (1 - val).clamp(0.0, 1.0),
                                        ),
                                        offset: Offset(0, 50*val));
                                  },
                                ).xPadding(new EdgeInsets.fromLTRB(0,0,0,20)).xFlexible(BUTTONS_FLEX)

                              ],
                            ),


                          ],
                        );


                        // Main stack

                      }),
                ),


                // Grey translucent layer
                GestureDetector(
                    onTap: () {
                      if(enteringRoomCode) setState(() {
                        enteringRoomCode = false;
                      });
                      else onProfileImageTapped();
                    },
                    child: Container(color: AppColors.translucentGreyBg))
                    .xOpacity(anim1_Quick.value)
                    .xEmptyUnless(profileEditMenuOpen || enteringRoomCode),

                // Overlaying column
                SafeArea(
                  child: Column(
                    children: [

                      // Actual user bar
                      Container(
                        child: _buildUserBar(context, state.model),
                      ).xFlexible(USER_BAR_FLEX),

                      // On profile tapped list
                      buildProfileEditMenu(context).xEmptyUnless(profileEditMenuOpen).xExpanded()
                    ],
                  ),
                )
                    .xEmptyUnless(isInMenuState),

                // Name text field
                SafeArea(
                  child: buildEnterNameTextField(state.model)
                    .xEmptyUnless(editingName),
                ),

                // Room code text field
                SafeArea(
                  child: buildEnterRoomCodeTextField(state.model)
                      .xEmptyUnless(enteringRoomCode),
                ),

                //Center(child: MyLoadingIndicator(const Size(75, 75)))

                // Overlaying container with progress indicator
                Container(
                  color: AppColors.translucentGreyBg,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      state.model.loadingMessage != null ? AppStyles.MyText(state.model.loadingMessage!) : EmptyWidget(),
                      MyLoadingIndicator(color: Colors.white)
                    ],
                  ),
                ).xEmptyUnless(state.model.loading),

              ],
            );

          },
        )


    ).xBoxDecorContainer(getBackgroundDecoration(context));

  }








}


