import 'dart:async';
import 'dart:core';
import 'dart:core';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bull/classes/firebase.dart';
import 'package:flutter_bull/utilities/local_res.dart';
import 'package:flutter_bull/utilities/prefs.dart';
import 'package:flutter_bull/utilities/repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bull/extensions.dart';
import 'package:provider/provider.dart';

import '_bloc_events.dart';
import '_bloc_states.dart';

class MainMenuBloc extends Bloc<MainMenuEvent, MainMenuState> {
  MainMenuBloc({required this.repo}) : super(InitialState(new MainMenuModel())){

    subscriptions.add(repo.streamCurrentPlayerImage().listen((event)
    {
      if(event != null) _model.setImage(event);
    }));

    subscriptions.add(repo.streamCurrentPlayer().listen((event)
    {
      _model.player = event;
      if(_model.player != null && _model.player!.occupiedRoomCode != null)
        {
          add(GoToGameRoomEvent());
        }
    }));

    _model.addListener(() { add(ProfileImageChangedEvent());  });

    refreshPrefs();
  }

  void refreshPrefs(){
    _model.privacyPolicyAccepted = _prefs.getBool(AppStrings.PRIVACY_POLICY_ACCEPTED)??false;
    _model.profileSetUp = _prefs.getBool(AppStrings.PREFS_FIRST_TIME_PROFILE_SETUP)??false;
    _model.tutorialSetUp = _prefs.getBool(AppStrings.PREFS_TUTORIAL_MODE_ON)??false;
    add(new PrefsUpdated());
  }


  MainMenuModel _model = new MainMenuModel();
  List<StreamSubscription> subscriptions = [];

  Repository repo;
  PrefsManager get _prefs => PrefsManager();


  @override
  Stream<MainMenuState> mapEventToState(MainMenuEvent event) async* {

    print('Event received: ' + event.runtimeType.toString() + " at " + DateTime.now().toString());

    if(event is PrefsUpdated)
    {
        if(_model.privacyPolicyAccepted == false)
          {
            _model.privacyPolicyString = await repo.getPrivacyPolicyString();
            yield PrivacyPolicyState(_model);
          }
        else if(_model.profileSetUp == false)
          {
            yield ProfileSetupState(_model);
          }
        else if(_model.tutorialSetUp == false)
          {
            yield TutorialSetupState(_model);
          }
        else yield MenuState(_model);
      }

    if(event is PrivacyPolicyPressed)
    {
      bool accepted = event.accepted;
      await _prefs.setBool(AppStrings.PRIVACY_POLICY_ACCEPTED, accepted);
      refreshPrefs();
    }

    if(event is ProfileSetupPressed)
    {
      if(event.text.isNullOrEmpty() && (_model.player == null || _model.player!.name.isNullOrEmpty())) return;
      await _prefs.setBool(AppStrings.PREFS_FIRST_TIME_PROFILE_SETUP, true);
      refreshPrefs();
    }

    if(event is TutorialSetupPressed)
    {
      await _prefs.setBool(AppStrings.PREFS_TUTORIAL_MODE_ON, true);
      refreshPrefs();
    }

    if(event is ImageSelectionRequested)
      {
        PickedFile? pickedFile;
        pickedFile = await event.picker.getImage(source: event.source);

        if(pickedFile == null) return;

        _model.syncingImage = true;
        yield MainMenuState(_model);

        File file = new File(pickedFile.path);
        await repo.uploadProfileImage(file);

        _model.player!.profileImage = Image.file(file);
        _model.syncingImage = false;
        yield MainMenuState(_model);
      }

    if(event is ProfileImageChangedEvent)
      {
        yield ProfileImageChangedState(_model);
      }

    if(event is NewNameSubmittedEvent)
      {
        if(event.name.isNullOrEmpty()) return;
        repo.uploadPlayerName(event.name);
      }

    if(event is DebugEvent)
      {
        if(event.clearAllPrefs == true)
          {
            await _prefs.clear();
            print('Prefs cleared');
          }
      }

    if(event is GoToGameRoomEvent)
      {
        yield GoToGameRoomState(_model);
      }

    if(event is CreateGameEvent)
    {
      String? roomCode = await repo.createGame();
      if(roomCode != null) yield GoToGameRoomState(_model);
    }

    // if(event is RoomC)
    // {
    //   await repo.createGame();
    //   yield GoToGameRoomState(_model);
    // }

  }

  @override
  Future<void> close() {
    for(var s in subscriptions) s.cancel();
    _model.dispose();
    return super.close();
  }


}




class MainMenuModel extends ChangeNotifier {
  bool privacyPolicyAccepted = false;
  bool profileSetUp = false;
  bool tutorialSetUp = false;

  setImage(Image newImage){
    bool notify = (newImage != player!.profileImage);
    player!.profileImage = newImage;
    if(notify) notifyListeners();
  }

  Player? player;

  bool syncingImage = false;

  String? privacyPolicyString;
}

