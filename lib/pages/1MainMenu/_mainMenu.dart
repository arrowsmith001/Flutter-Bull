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
import 'package:flutter_bull/gen/assets.gen.dart';
import 'package:flutter_bull/gen/fonts.gen.dart';
import 'package:flutter_bull/pages/1MainMenu/_widgets.dart';
import 'package:flutter_bull/pages/1MainMenu/background.dart';
import 'package:flutter_bull/pages/1MainMenu/title.dart';
import 'package:flutter_bull/particles.dart';
import 'package:flutter_bull/utilities/interpolators.dart';
import 'package:flutter_bull/utilities/localRes.dart';
import 'package:flutter_bull/utilities/res.dart';
import 'package:flutter_bull/utilities/prefs.dart';
import 'package:flutter_bull/utilities/profile.dart';
import 'package:flutter_bull/widgets.dart';
import 'package:flutter_circular_text/circular_text.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prefs/prefs.dart';
import '../../classes.dart';
import '../../extensions.dart';
import 'dart:ui' as ui;

class MainMenuSettings{
  bool privacyPolicyAccepted = true;
  bool firstTimeProfileSetup = true;
  bool firstTimeTutorialSetup = true;
}

class MainMenu extends StatefulWidget {

  final ProfileManager proMan = ProfileManager();
  final PrefsManager prefMan = PrefsManager();
  final ResourceManager resMan = ResourceManager();

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> with SingleTickerProviderStateMixin {

  late AnimationController _animController;
  late Animation<double> dialogPopAnim, anim1, anim2, anim3, anim4;
  final Interpolator overshootInterp = OvershootInterpolator();
  final Interpolator hardOvershootInterp = OvershootInterpolator(5);


  @override
  void initState() {
    super.initState();
    _animController = new AnimationController(vsync: this);
    _animController.addListener(() {setState(() { });});
    _animController.duration = Duration(milliseconds: 5000);
    dialogPopAnim = new Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _animController, curve: Interval(0, 0.1)));

    double intervalValue = 0.1, staggerValue = 0.03;
    anim1 = new Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _animController, curve: Interval(staggerValue, staggerValue + intervalValue)));
    anim2 = new Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _animController, curve: Interval(staggerValue*2, staggerValue*2 + intervalValue)));
    anim3 = new Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _animController, curve: Interval(staggerValue*3, staggerValue*3 + intervalValue)));
    anim4 = new Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _animController, curve: Interval(staggerValue*4, staggerValue*4 + intervalValue)));
    _animController.forward();

    this._profileImage = widget.proMan.profile.image;
    this._profileName = widget.proMan.profile.name;

    this.privacyPolicy = widget.prefMan.getBool(AppStrings.PRIVACY_POLICY_ACCEPTED)?? false;
    this.profileSetup = widget.prefMan.getBool(AppStrings.FIRST_TIME_PROFILE_SETUP)?? false;
    this.tutorialSetup = widget.prefMan.getBool(AppStrings.FIRST_TIME_TUTORIAL_SETUP)?? false;

    _textController.addListener(() {

      String text = _textController.value.text;

      setState(() {
        if(Validators.UsernameValidation(text) == null) this._profileName = text;
        else this._profileName = null;
      });
    });
  }

  @override
  void dispose(){
    _animController.dispose();
    _textController.dispose();
    super.dispose();
  }

  late bool privacyPolicy;
  late bool profileSetup;
  late bool tutorialSetup;

  Future onTopBarPressed() async {
    await widget.prefMan.clear();
    print('Prefs cleared');
  }

  onPrivacyPolicyAcceptedPressed(bool accepted) async {
    if(!accepted) {
      SystemNavigator.pop();
      return;
    }
    await widget.prefMan.setBool(AppStrings.PRIVACY_POLICY_ACCEPTED, true);
    setState(() {
      privacyPolicy = true;
      _animController.forward(from: 0);
    });
  }

  onProfileSetupPressed() async {
    if(this._profileImage == null || this._profileName == null)
    {
      return;
    }

    String text = await widget.proMan.setName(_textController.value.text);

    await widget.prefMan.setBool(AppStrings.FIRST_TIME_PROFILE_SETUP, true);
    setState(() {
      _profileName = text;
      profileSetup = true;
      _animController.forward(from: 0);
    });
  }

  onTutorialSetupPressed(bool value) async {
    await widget.prefMan.setBool(AppStrings.TUTORIAL_MODE_ON, value);
    await widget.prefMan.setBool(AppStrings.FIRST_TIME_TUTORIAL_SETUP, true);
    setState(() {
      tutorialSetup = true;
      _animController.forward(from: 0);
    });
  }
  
  void onCreateGame(){
    print("CREATE GAME PRESSED " + DateTime.now().toString());
  }

  void onJoinGame(){
    print("JOIN GAME PRESSED " + DateTime.now().toString());
  }

  final picker = ImagePicker();
  String? _profileName;
  Image? _profileImage;
  TextEditingController _textController = new TextEditingController();

  void profileImageSelection(ImageSource source) async{

    var pickedImage = await widget.proMan.pickImage(picker, source);
    if(pickedImage == null) return;
    setState(() {
      _profileImage = pickedImage;
    });
  }

  @override
  Widget build(BuildContext context) {

    // SETUP
    bool anySetupRequired = !privacyPolicy || !profileSetup || !tutorialSetup;

    Widget privacyPolicyDialog = Center(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.85),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Column(
            children: [

              Text('Utter Bull', style: TextStyle(fontSize: 24, fontFamily: FontFamily.lapsusProBold)).PaddingExt(EdgeInsets.fromLTRB(0,20,0,0)),
              Text('Privacy Policy', style: TextStyle(fontSize: 24)).PaddingExt(EdgeInsets.fromLTRB(0,5,0,10)),

              SingleChildScrollView(
                child: Text(widget.resMan.fsData.getValue('strings/privacy_policy')),
              ).PaddingExt(EdgeInsets.symmetric(horizontal: 20, vertical: 10)).ExpandedExt(),

              Row(
                children: [
                  CupertinoButton(
                   // color: Color.fromARGB(82, 238, 225, 225),
                    onPressed: () => onPrivacyPolicyAcceptedPressed(true),
                    child: Text('Accept', style: TextStyle(color: Colors.black, fontFamily: FontFamily.lapsusProBold)),)
                  .PaddingExt(EdgeInsets.symmetric(horizontal: 12))
                      .ExpandedExt()
                ],
              ),

              Row(
                children: [
                  CupertinoButton(
                    onPressed: () => onPrivacyPolicyAcceptedPressed(false),
                    child: Text('Reject', style: TextStyle(color: Colors.red, fontFamily: FontFamily.lapsusProBold)),)
                      .PaddingExt(EdgeInsets.symmetric(vertical: 8))
                      .ExpandedExt()
                ],
              ),
            ],
          ),
        )
    ).PaddingExt(EdgeInsets.all(40));

    Widget profileSetupDialog = Center(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.85),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Column(
            children: [

              Column(
                children: [
                  Text('Set up your profile', style: TextStyle(fontSize: 24, fontFamily: FontFamily.lapsusProBold)).PaddingExt(EdgeInsets.fromLTRB(0,20,0,0)),

                  Text('Just a photo and name, so your friends recognise you!', style: TextStyle(fontSize: 20), textAlign: TextAlign.center,).PaddingExt(EdgeInsets.fromLTRB(0,20,0,0)),

                ],
              ).ScaleExt(hardOvershootInterp.getValue(anim1.value)),

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
                  ).PaddingExt(EdgeInsets.symmetric(vertical: 12)).FlexibleExt(),

                  GestureDetector(
                    onTap: () { profileImageSelection(ImageSource.camera); },
                    child: Container(
                        height: 150,
                        decoration: BoxDecoration(
                            //color: Color.fromARGB(101, 229, 220, 220),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.blueAccent, width: 3),
                            image: DecorationImage(
                              fit: BoxFit.scaleDown,
                              image: _profileImage == null ? Assets.images.shutter : _profileImage!.image,
                            ))),
                  ),

                  CupertinoButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.image),
                          Text('Choose from gallery', style: TextStyle(color: Colors.black))
                        ],
                      ),
                      onPressed: (){ profileImageSelection(ImageSource.gallery); })
                ],
              )
                  .ScaleExt(hardOvershootInterp.getValue(anim2.value))
                  .FlexibleExt(3),

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
                  ).PaddingExt(EdgeInsets.symmetric(vertical: 12)).FlexibleExt(),

                  CupertinoTextField(
                    placeholder: 'Enter your name here',
                    placeholderStyle: TextStyle(fontFamily: FontFamily.lapsusProBold,color: Colors.grey),
                    controller: _textController,
                    padding: EdgeInsets.all(18),)
                      .PaddingExt(EdgeInsets.symmetric(horizontal: 20))
                ],
              )
                  .ScaleExt(hardOvershootInterp.getValue(anim3.value))
                  .FlexibleExt(2),

              Row(
                children: [
                  CupertinoButton(
                    onPressed: () => onProfileSetupPressed(),
                    child: Text('Finish',
                        style: TextStyle(
                          fontSize: 32,
                          fontFamily: FontFamily.lapsusProBold,
                            color: _profileImage == null || _profileName == null
                                ? Colors.grey : Colors.blueAccent)),).ExpandedExt()
                ],
              )
                  .ScaleExt(hardOvershootInterp.getValue(anim4.value)),
            ],
          ),
        )
    ).PaddingExt(EdgeInsets.all(40));


    Widget tutorialSetupDialog = Center(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.85),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Column(
            children: [

              Column(
                children: [
                  Text('Welcome to Utter Bull!!', style: TextStyle(fontSize: 24, fontFamily: FontFamily.lapsusProBold)).PaddingExt(EdgeInsets.fromLTRB(0,20,0,0)),

                ],
              ).ScaleExt(hardOvershootInterp.getValue(anim1.value)),

              SizedBox(child: Assets.images.bullIcon.image(), height: 150),

              Column(
                children: [
                  Text("This is a social game to play with a few friends. Make sure you\'re all in the same room or video call.",
                    textAlign: TextAlign.center,).PaddingExt(EdgeInsets.symmetric(vertical: 12)),

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
                          ])).PaddingExt(EdgeInsets.symmetric(vertical: 12)),

                  RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          style: TextStyle(color: Colors.black),
                          children:
                          [
                            TextSpan(text: "All tutorial info can be identified by...")
                          ])).PaddingExt(EdgeInsets.symmetric(vertical: 12)),
                ]
              ).PaddingExt(EdgeInsets.symmetric(horizontal: 16)),

              Container().ExpandedExt(),

              Row(
                children: [
                  CupertinoButton(
                    color: Color.fromARGB(75, 213, 226, 255),
                    padding: EdgeInsets.all(16),
                    onPressed: () => onTutorialSetupPressed(true),
                    child: Text('Yes! Enable all the tutorial info',
                        style: TextStyle(
                            fontSize: 24,
                            fontFamily: FontFamily.lapsusProBold,
                            color: _profileImage == null || _profileName == null
                                ? Colors.grey : Colors.blueAccent)),)
                      .PaddingExt(EdgeInsets.symmetric(horizontal: 8)).ExpandedExt()
                ],
              ),

              Row(
                children: [
                  CupertinoButton(
                    color: Color.fromARGB(55, 255, 186, 156),
                    padding: EdgeInsets.all(16),
                    onPressed: () => onTutorialSetupPressed(false),
                    child: Text('No tutorial info, I\'m already a pro',
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: FontFamily.lapsusProBold,
                            color: Colors.deepOrangeAccent)),)
                      .PaddingExt(EdgeInsets.all(8)).ExpandedExt()
                ],
              )

            ],
          ),
        )
    ).PaddingExt(EdgeInsets.all(40));


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
                    height:75,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(205, 255, 116, 116),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.blueAccent, width: 3),
                        image: _profileImage == null ? null :
                        DecorationImage(
                          fit: BoxFit.cover,
                          image:  _profileImage!.image,
                        ))),

                _profileName == null ? EmptyWidget()
                    : Transform.translate(
                  offset: Offset(0, -5),
                  child: AutoSizeText(_profileName, minFontSize: 10, maxLines: 1,
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          backgroundColor: Colors.blueAccent,
                          fontFamily: FontFamily.lapsusProBold)),
                )
              ],
            ),
            onTap: (){
              profileImageSelection(ImageSource.camera);
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


    // BUTTONS
    var buttonIconSize = 65.0;
    var minFontSize = 10.0;
    var fontSize = 30.0;

    Widget createGameButton = MainMenuButton("CREATE GAME", Assets.images.bullAddGlowBrown.image(), onCreateGame,
        fontSize: fontSize, minFontSize: minFontSize, imageSize: buttonIconSize);

    Widget joinGameButton = MainMenuButton("JOIN GAME", Assets.images.arrowsGlowBrownEdit.image(), onJoinGame,
        fontSize: fontSize+10, minFontSize: minFontSize, imageSize: buttonIconSize+10);


    // LAYOUT
    const int USER_BAR_FLEX = 0;
    const int TITLE_FLEX = 4;
    const int BUTTONS_FLEX = 0;

    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [

              MainMenuBackgroundEffect(),

              anySetupRequired ?

                  Transform.scale(
                    scale: 0.6 + 0.4 * overshootInterp.getValue(dialogPopAnim.value),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        (
                            !privacyPolicy? privacyPolicyDialog.FlexibleExt()
                                : !profileSetup? profileSetupDialog.FlexibleExt()
                                : !tutorialSetup? tutorialSetupDialog.FlexibleExt()
                                : EmptyWidget()
                        )
                      ],
                    ),
                  )

                  :

              // Main Column
              Column(
                children: [

                  UserBar
                      .PaddingExt(EdgeInsets.fromLTRB(0, 25, 0, 20))
                      .FlexibleExt(USER_BAR_FLEX),

                  Column(
                    children: [
                      //Container().ExpandedExt(),

                      UtterBullTitle()
                      //.PaddingExt(EdgeInsets.fromLTRB(0, 50, 0, 0))
                          .FlexibleExt(TITLE_FLEX),

                      Container().ExpandedExt(),
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
              )
            ],
          )


      ).BoxDecorationContainerExt(backgroundDecoration),
    );

  }



}
