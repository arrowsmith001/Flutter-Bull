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
import 'package:flutter_bull/classes/firebase.dart';
import 'package:flutter_bull/gen/assets.gen.dart';
import 'package:flutter_bull/gen/fonts.gen.dart';
import 'package:flutter_bull/pages/1MainMenu/widgets.dart';
import 'package:flutter_bull/pages/1MainMenu/background.dart';
import 'package:flutter_bull/pages/1MainMenu/title.dart';
import 'package:flutter_bull/pages/2GameRoom/_game_room.dart';
import 'package:flutter_bull/particles.dart';
import 'package:flutter_bull/utilities/_center.dart';
import 'package:flutter_bull/utilities/firebase.dart';
import 'package:flutter_bull/utilities/interpolators.dart';
import 'package:flutter_bull/utilities/local_res.dart';
import 'package:flutter_bull/utilities/res.dart';
import 'package:flutter_bull/utilities/prefs.dart';
import 'package:flutter_bull/utilities/profile.dart';
import 'package:flutter_bull/widgets.dart';
import 'package:flutter_circular_text/circular_text.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prefs/prefs.dart';
import 'package:provider/provider.dart';
import '../../classes/classes.dart';
import '../../extensions.dart';
import 'dart:ui' as ui;

class MainMenuSettings{
  bool privacyPolicyAccepted = true;
  bool firstTimeProfileSetup = true;
  bool firstTimeTutorialSetup = true;
}

class MainMenu extends StatefulWidget {

  final ManagerCenter m = new ManagerCenter();

  final FirebaseOps ops = new FirebaseOps(); // TODO: DELEEEEEEEEEEEETE

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> with TickerProviderStateMixin {

  late AnimationController _animController, _animController2, _animController3;
  late Animation<double> dialogPopAnim, anim1, anim2, anim3, anim4, anim5, anim6, anim7, anim8, anim1Quick; // _animController1
  late Animation<double> anim1_2; // _animController2
  final Interpolator overshootInterp = OvershootInterpolator();
  final Interpolator hardOvershootInterp = OvershootInterpolator(5);
  final Interpolator decelInterp = DecelerateInterpolator(5);

  late bool privacyPolicy;
  late bool profileSetup;
  late bool tutorialSetup;

  @override
  void initState() {
    super.initState();
    _animController = new AnimationController(vsync: this);
    _animController.addListener(() {setState(() { });});
    _animController.duration = Duration(milliseconds: 5000);
    dialogPopAnim = new Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _animController, curve: Interval(0, 0.1)));

    _animController2 = new AnimationController(vsync: this);
    _animController2.addListener(() {setState(() { });});
    _animController2.duration = Duration(milliseconds: 500);
    anim1_2 = new Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _animController2, curve: Interval(0, 1)));

    // Make cyclic
    _animController3 = new AnimationController(vsync: this);
    _animController3.addListener(() {setState(() { });});
    _animController3.duration = Duration(milliseconds: 3000);
    _animController3.repeat(reverse: true);

    double intervalValue = 0.1, staggerValue = 0.01;
    anim1 = new Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _animController, curve: Interval(staggerValue, staggerValue + intervalValue)));
    anim1Quick = new Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _animController, curve: Interval(0, 0.01)));
    anim2 = new Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _animController, curve: Interval(staggerValue*2, staggerValue*2 + intervalValue)));
    anim3 = new Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _animController, curve: Interval(staggerValue*3, staggerValue*3 + intervalValue)));
    anim4 = new Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _animController, curve: Interval(staggerValue*4, staggerValue*4 + intervalValue)));
    anim5 = new Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _animController, curve: Interval(staggerValue*5, staggerValue*5 + intervalValue)));
    anim6 = new Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _animController, curve: Interval(staggerValue*6, staggerValue*6 + intervalValue)));
    anim7 = new Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _animController, curve: Interval(staggerValue*7, staggerValue*7 + intervalValue)));
    anim8 = new Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _animController, curve: Interval(staggerValue*8, staggerValue*8 + intervalValue)));
    _animController.forward();

    this.privacyPolicy = widget.m.prefs.getBool(AppStrings.PRIVACY_POLICY_ACCEPTED)?? false;
    this.profileSetup = widget.m.prefs.getBool(AppStrings.PREFS_FIRST_TIME_PROFILE_SETUP)?? false;
    this.tutorialSetup = widget.m.prefs.getBool(AppStrings.PREFS_FIRST_TIME_TUTORIAL_SETUP)?? false;

    _textController.addListener(() {
      textEditingValue = _textController.text;
    });
  }

  @override
  void dispose(){
    _animController.dispose();
    _animController2.dispose();
    _animController3.dispose();
    _textController.dispose();
    super.dispose();
  }

  Future onTopBarPressed() async {
    await widget.m.prefs.clear();
    print('Prefs cleared');
  }

  onPrivacyPolicyAcceptedPressed(bool accepted) async {
    if(!accepted) {
      SystemNavigator.pop();
      return;
    }
    await widget.m.prefs.setBool(AppStrings.PRIVACY_POLICY_ACCEPTED, true);
    setState(() {
      privacyPolicy = true;
      _animController.forward(from: 0);
    });
  }

  onProfileSetupPressed(BuildContext context) async {
    if(this._profileImage == null) {
      return;
    }

    if(textEditingValue != null){
      await Provider.of<DatabaseOps>(context, listen: false).setName(textEditingValue!);
    }else if(_profileName == null){
      return;
    }

    await widget.m.prefs.setBool(AppStrings.PREFS_FIRST_TIME_PROFILE_SETUP, true);

    setState(() {
      profileSetup = true;
      _animController.forward(from: 0);
    });
  }

  onTutorialSetupPressed(bool value) async {
    await widget.m.prefs.setBool(AppStrings.PREFS_TUTORIAL_MODE_ON, value);
    await widget.m.prefs.setBool(AppStrings.PREFS_FIRST_TIME_TUTORIAL_SETUP, true);
    setState(() {
      tutorialSetup = true;
      _animController.forward(from: 0);
    });
  }
  
  void onCreateGame(BuildContext context) async {
    setState(() {loading = true;});
    await Provider.of<DatabaseOps>(context, listen: false).createGame();
    await goToGameRoom();
    setState(() {loading = false;});

  }

  Future<void> goToGameRoom() async{
    await Navigator.of(context).push(_mainMenuToGameRoute());
  }

  Route _mainMenuToGameRoute() {

    var ops = Provider.of<DatabaseOps>(context, listen: false);

    return CupertinoPageRoute(builder: (context){
      return MultiProvider(
        providers: [
          ListenableProvider<DatabaseOps>.value(value: ops),
          StreamProvider<Player?>(
            initialData: null,
            create: (_) => ops.streamCurrentPlayer(),
          ),
          StreamProvider<Image?>(
            initialData: null,
            create: (_) => ops.streamCurrentPlayerImage(),
          ),
          StreamProvider<String?>(
            initialData: null,
            create: (_) => ops.streamCurrentPlayerRoomCode(),
          )
        ],
          child: GameRoom());
    });
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => GameRoom(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
    );
  }

  void onJoinGame(BuildContext context) async {
    await widget.m.db.joinGame('');
  }

  // IMAGE SELECTION
  final picker = ImagePicker();
  String? _profileName;
  Image? _profileImage;
  TextEditingController _textController = new TextEditingController();
  String? textEditingValue;

  bool profileEditMenuOpen = false;
  bool loading = false;

  void onProfileImageTapped() {
    if(profileEditMenuOpen)
    {
      setState(() {
        profileEditMenuOpen = false;
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

  void profileImageSelection(BuildContext context, ImageSource source) async {

    setState(() {loading = true;});

    Image? pickedImage;
    try{  pickedImage = await widget.m.profile.pickImage(context, picker, source); }
    catch(e){}

    setState(() {
      loading = false;
      if(pickedImage == null) return;
      _profileImage = pickedImage;
    });
  }

  void onEditName() {

  }

  @override
  Widget build(BuildContext context) {

    // PROVIDED VARIABLES
    Player? player = Provider.of<Player?>(context);
    Image? playerImage = Provider.of<Image?>(context);

    _profileName = player == null ? null : player.name;
    _profileImage = playerImage;

    // SETUP
    bool anySetupRequired = !privacyPolicy || !profileSetup || !tutorialSetup;

    Widget privacyPolicyDialog = MyCupertinoStyleDialogWithButtons(
       columnChildren: [
          MyCupertinoStyleBox(
            borderRadius: MyBorderRadii.TOP_ONLY,

              content:
          Column(children: [

            Text('Utter Bull', style: TextStyle(fontSize: 24, fontFamily: FontFamily.lapsusProBold)).PaddingExt(EdgeInsets.fromLTRB(0,20,0,0)),
            Text('Privacy Policy', style: TextStyle(fontSize: 24)).PaddingExt(EdgeInsets.fromLTRB(0,5,0,10)),
          ],)),

        SingleChildScrollView(
          child: Text(widget.m.resources.fsData.getValue('strings/privacy_policy')),
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

    Widget profileSetupDialog = MyCupertinoStyleDialog(
        [
      Column(
        children: [

          MyCupertinoStyleBox(
            borderRadius: MyBorderRadii.TOP_ONLY,
              content: Text('Set up your profile', style: TextStyle(fontSize: 24, fontFamily: FontFamily.lapsusProBold))
                  .PaddingExt(EdgeInsets.fromLTRB(0,15,0,10))
                  .ScaleExt(hardOvershootInterp.getValue(anim1.value))
          ),

          Text('Just a photo and name, so your friends recognise you!', style: TextStyle(fontSize: 20), textAlign: TextAlign.center,)
              .PaddingExt(EdgeInsets.fromLTRB(0,20,0,0))
              .ScaleExt(hardOvershootInterp.getValue(anim2.value)),

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
              _profileImage == null ? EmptyWidget() : Icon(Icons.done, color: Colors.green,)
            ],
          ).PaddingExt(EdgeInsets.symmetric(vertical: 12))
              .ScaleExt(hardOvershootInterp.getValue(anim3.value))
              .FlexibleExt(),

          GestureDetector(
            onTap: () { profileImageSelection(context, ImageSource.camera); },
            child: Container(
                height: MediaQuery.of(context).size.height / 10,
                decoration: BoxDecoration(
                  //color: Color.fromARGB(101, 229, 220, 220),
                    shape: BoxShape.circle,
                    border: Border.all(color: Color.lerp(Colors.blueAccent, Colors.white, _animController3.value)!, width: 3),
                    image: DecorationImage(
                      fit: BoxFit.scaleDown,
                      image: _profileImage == null ? Assets.images.shutter : _profileImage!.image,
                    ))),
          ).ScaleExt(hardOvershootInterp.getValue(anim4.value)),

          CupertinoButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.image),
                  Text('Choose from gallery', style: TextStyle(color: Colors.black)).PaddingExt(EdgeInsets.symmetric(horizontal: 8))
                ],
              ),
              onPressed: (){ profileImageSelection(context, ImageSource.gallery); }
          ).ScaleExt(hardOvershootInterp.getValue(anim5.value))
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
              _profileName == null ? EmptyWidget() : Icon(Icons.done, color: Colors.green,)
            ],
          ).PaddingExt(EdgeInsets.symmetric(vertical: 12))
              .ScaleExt(hardOvershootInterp.getValue(anim6.value))
              .FlexibleExt(),

          CupertinoTextField(
            placeholder: _profileName != null ? _profileName : 'Enter your name here',
            placeholderStyle: TextStyle(fontFamily: FontFamily.lapsusProBold,color: Colors.grey),
            controller: _textController,
            padding: EdgeInsets.all(18),)
              .PaddingExt(EdgeInsets.symmetric(horizontal: 20))
              .ScaleExt(hardOvershootInterp.getValue(anim7.value))
        ],
      )
          .FlexibleExt(2),

      Text('You can edit these any time').FlexibleExt(),

      MyCupertinoStyleButton(
        onPressed: () => onProfileSetupPressed(context),
      borderRadius: MyBorderRadii.BOTTOM_ONLY,
      text: Text('Finish', textAlign: TextAlign.center, style: TextStyle(fontSize: 32, fontFamily: FontFamily.lapsusProBold,
          color: _profileImage == null || _profileName == null
              ? Colors.grey : Colors.blueAccent)),)
    ]);

    Widget tutorialSetupDialog = MyCupertinoStyleDialogWithButtons(
      columnChildren: [
        MyCupertinoStyleBox(
          borderRadius: MyBorderRadii.TOP_ONLY,
            content: Column(
              children: [
                Text('Welcome to Utter Bull!!',
                    style: TextStyle(fontSize: 24, fontFamily: FontFamily.lapsusProBold))
                    .ScaleExt(hardOvershootInterp.getValue(anim1.value))
                    .PaddingExt(EdgeInsets.fromLTRB(0,20,0,10)),


                SizedBox(child: Assets.images.bullIcon.image(), height: hardOvershootInterp.getValue(anim6.value)*150)
                    .PaddingExt(EdgeInsets.fromLTRB(0,10,0,10))


              ],
            ),
        ),

        Column(
            children: [
              Text("This is a social game to play with a few friends. Make sure you\'re all in the same room or video call.",
                textAlign: TextAlign.center,).PaddingExt(EdgeInsets.symmetric(vertical: 12))
                  .ScaleExt(hardOvershootInterp.getValue(anim2.value)),

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
                      ])).PaddingExt(EdgeInsets.symmetric(vertical: 12)).ScaleExt(hardOvershootInterp.getValue(anim3.value)),

              RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      style: TextStyle(color: Colors.black),
                      children:
                      [
                        TextSpan(text: "All tutorial info can be identified by...")
                      ])).PaddingExt(EdgeInsets.symmetric(vertical: 12))
                  .ScaleExt(hardOvershootInterp.getValue(anim4.value)),
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
              onPressed: () => onTutorialSetupPressed(false)).ScaleExt(hardOvershootInterp.getValue(anim6.value)),

          MyCupertinoStyleButton(
              height: 100,
              glowPosition: Alignment.bottomRight,
              value: _animController3.value,
              color: Color.fromARGB(255, 211, 243, 255),
              borderRadius: MyBorderRadii.BOTTOM_RIGHT_ONLY,
              text: AutoSizeText('Yes! Enable all tutorial info', textAlign: TextAlign.center,
                  minFontSize: 16, style: TextStyle(color: Color.fromARGB(
                      255, 27, 47, 163), fontFamily: FontFamily.lapsusProBold, fontSize: 32)),
              onPressed: () => onTutorialSetupPressed(true)).ScaleExt(hardOvershootInterp.getValue(anim7.value)),



      ]
    );


    // BACKGROUND
    var primaryColor = CupertinoTheme.of(context).primaryColor;
    var fadedPrimaryColor = ui.Color.lerp(primaryColor, Colors.white, 0.2)!;
    var darkenedPrimaryColor = ui.Color.lerp(primaryColor, Colors.black, 0.2)!;

    var backgroundGradientOffset = 0.04;
    var backgroundDecoration = new BoxDecoration(
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


    // USER BAR
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
                    decoration: BoxDecoration(
                        color: Color.fromARGB(205, 255, 116, 116),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.blueAccent, width: 3),
                        image: playerImage == null ? null :
                        DecorationImage(
                          fit: BoxFit.cover,
                          image:  playerImage.image,
                        ))),

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

    Widget UserBar = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

      children: [
        userBarLeft.FlexibleExt(2),

        userBarRight.PaddingExt(EdgeInsets.symmetric(horizontal: 20)).FlexibleExt(1)
      ],
    );

    Widget profileEditMenu = Container(
      child: Align(
        alignment: Alignment.topRight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [

            MyListItem(
              onTap: () { profileImageSelection(context, ImageSource.camera); },
              text: 'New photo from camera', iconData: Icons.camera,)
                .PaddingExt(EdgeInsets.only(bottom: 10, right: 15))
                .TranslateExt(dy: ((1-hardOvershootInterp.getValue(anim1Quick.value))*-20).toDouble()),
            MyListItem(
              onTap: () { profileImageSelection(context, ImageSource.gallery); },
              text: 'New photo from gallery', iconData: Icons.add_photo_alternate_outlined,)
                .PaddingExt(EdgeInsets.only(bottom: 10, right: 15))
                .TranslateExt(dy: ((1-hardOvershootInterp.getValue(anim1Quick.value))*-50).toDouble()),
            MyListItem(
              onTap: () { onEditName(); },
              text: 'Change name', iconData: Icons.edit,)
                .PaddingExt(EdgeInsets.only(bottom: 10, right: 15))
                .TranslateExt(dy: ((1-hardOvershootInterp.getValue(anim1Quick.value))*-100).toDouble()),

          ],
        ),
      ),
    );

    // BUTTONS
    var buttonIconSize = 65.0;
    var minFontSize = 10.0;
    var fontSize = 30.0;

    Widget createGameButton = MainMenuButton("CREATE GAME", Assets.images.bullAddGlowBrown.image(), () async { onCreateGame(context); },
        fontSize: fontSize, minFontSize: minFontSize, imageSize: buttonIconSize);

    Widget joinGameButton = MainMenuButton("JOIN GAME", Assets.images.arrowsGlowBrownEdit.image(), () async { onJoinGame(context); },
        fontSize: fontSize+10, minFontSize: minFontSize, imageSize: buttonIconSize+10);


    // LAYOUT
    const int USER_BAR_FLEX = 0;
    const int TITLE_FLEX = 4;
    const int BUTTONS_FLEX = 0;

    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [

              MainMenuBackgroundEffect(),

              anySetupRequired ?

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  (
                      !privacyPolicy? privacyPolicyDialog.FlexibleExt()
                          : !profileSetup? profileSetupDialog.FlexibleExt()
                          : !tutorialSetup? tutorialSetupDialog.FlexibleExt()
                          : EmptyWidget()
                  )
                ],
              ).ScaleExt(0.6 + 0.4 * overshootInterp.getValue(dialogPopAnim.value))

                  :

              // Main stack
              Stack(
                children: [

                  // Main Column
                  Column(
                    children: [

                      // Invisible user bar, for spacing purposes
                      UserBar
                          .PaddingExt(EdgeInsets.fromLTRB(0, 10, 0, 10))
                          .InvisibleIgnoreExt()
                          .FlexibleExt(USER_BAR_FLEX),

                      Column(
                        children: [
                          UtterBullTitle().FlexibleExt(TITLE_FLEX),
                        ],
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
                      child: Container(color: Colors.black54.withOpacity(0.8),)).OpacityExt(anim1Quick.value) : EmptyWidget(),

                  // Overlaying column
                  Column(
                    children: [

                      // Actual user bar
                      UserBar
                          .PaddingExt(EdgeInsets.fromLTRB(0, 10, 0, 10))
                          .FlexibleExt(USER_BAR_FLEX),

                      // On profile tapped list
                      profileEditMenuOpen ? profileEditMenu.ExpandedExt() : EmptyWidget()
                    ],
                  ),


                  // Overlaying container with progress indicator
                  !loading ? EmptyWidget() : Container(
                    color: Colors.grey.withOpacity(0.3),
                    child: Center(
                      child: CircularProgressIndicator(backgroundColor: Colors.redAccent,),
                    ),
                  ),




                ],
              )
            ],
          )


      ).BoxDecorationContainerExt(backgroundDecoration),
    );

  }








}


