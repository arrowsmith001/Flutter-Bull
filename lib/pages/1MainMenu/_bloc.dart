import 'dart:async';
import 'dart:core';
import 'dart:core';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bull/classes/firebase.dart';
import 'package:flutter_bull/firebase/_bloc.dart';
import 'package:flutter_bull/firebase/_bloc_states.dart' as fbStates;
import 'package:flutter_bull/firebase/_bloc_events.dart' as fbEvents;
import 'package:flutter_bull/firebase/provider.dart';
import 'package:flutter_bull/utilities/local_res.dart';
import 'package:flutter_bull/utilities/prefs.dart';
import 'package:flutter_bull/utilities/repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:extensions/extensions.dart';
import 'package:provider/provider.dart';

import '_bloc_events.dart';
import '_bloc_states.dart';

class MainMenuBloc extends Bloc<MainMenuEvent, MainMenuState> {
  FirebaseBloc firebaseBloc;

  MainMenuBloc(this.model, {required this.firebaseBloc}) : super(InitialState(model)){

    this.firebaseBloc.bs.listen((state) {
      add(FirebaseStateEvent(state));
    });

    refreshPrefs();
  }

  void refreshPrefs(){
    model.privacyPolicyAccepted = _prefs.getBool(AppStrings.PRIVACY_POLICY_ACCEPTED)??false;
    model.profileSetUp = _prefs.getBool(AppStrings.PREFS_FIRST_TIME_PROFILE_SETUP)??false;
    model.tutorialSetUp = _prefs.getBool(AppStrings.PREFS_TUTORIAL_MODE_ON)??false;
    add(new PrefsUpdated());
  }


  PrefsManager get _prefs => PrefsManager();


  @override
  void onEvent(MainMenuEvent event) {
    super.onEvent(event);
    print('Event received: ' + event.runtimeType.toString() + " at " + DateTime.now().toString());
  }


  MainMenuModel model;


  @override
  Stream<MainMenuState> mapEventToState(MainMenuEvent event) async* {

    if(event is FirebaseStateEvent)
      {
        fbStates.FirebaseState state = event.state;
        model.dataModel = state.model;

        if(state is fbStates.ProfileImageUpdatedState)
        {
          if(state.model.isUser(state.userId))
          {
            yield UserProfileImageChangedState(model);
          }
        }

        if(state is fbStates.NameChangedState)
        {
          if(state.model.isUser(state.userId))
          {
            yield UserNameChangedState(model);
          }
        }

        if(state is fbStates.PrivacyPolicyStringRetrievedState)
        {
          model.privacyPolicyString = state.privacyPolicy;
          yield PrivacyPolicyState(model);
        }

        if(state is fbStates.GameCreatedState)
        {
          //if(state.roomCode != null) yield GoToGameRoomState(model);
          // else print('Game creation unsuccessful');
          print(state.roomCode != null ? 'Game creation successful' : 'Game creation unsuccessful');
        }

        if(state is fbStates.GameJoinedState)
        {
          //if(state.success) yield GoToGameRoomState(model);
          // else print('Room join unsuccessful');
          print(state.success ? 'Room join successful' : 'Room join unsuccessful');
        }

        if(state is fbStates.NewRoomState)
        {
          yield NewRoomState(model);
        }

        if(state is fbStates.GameLeftState)
        {
          yield GameLeftState(state.success, model);
        }

        yield MainMenuState(model);
      }

    if(event is PrefsUpdated)
    {
        if(model.privacyPolicyAccepted == false)
          {
            firebaseBloc.add(fbEvents.PrivacyPolicyStringRequestedEvent());
          }
        else if(model.profileSetUp == false)
          {
            yield ProfileSetupState(model);
          }
        else if(model.tutorialSetUp == false)
          {
            yield TutorialSetupState(model);
          }
        else yield MenuState(model);
      }

    if(event is PrivacyPolicyPressed)
    {
      bool accepted = event.accepted;
      await _prefs.setBool(AppStrings.PRIVACY_POLICY_ACCEPTED, accepted);
      refreshPrefs();
    }

    if(event is ProfileSetupPressed)
    {
      if(event.text.isNullOrEmpty() && (model.user == null || model.user!.name.isNullOrEmpty())) return;
      if(!event.text.isNullOrEmpty()) firebaseBloc.add(fbEvents.ChangeUsernameEvent(event.text!));
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

        File file = new File(pickedFile.path);
        firebaseBloc.add(fbEvents.ImagePicked(file));
      }

    if(event is NewNameSubmittedEvent)
      {
        if(event.name.isNullOrEmpty()) return;
        firebaseBloc.add(fbEvents.ChangeUsernameEvent(event.name));
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
        yield NewRoomState(model);
      }

    if(event is CreateGameEvent)
    {
      firebaseBloc.add(fbEvents.CreateGameRequested());
    }

    if(event is JoinGameEvent)
    {
      firebaseBloc.add(fbEvents.JoinGameRequested(event.code));
    }

    if(event is LeaveGameEvent)
      {
        firebaseBloc.add(fbEvents.LeaveGameRequested());

      }

    // if(event is RoomC)
    // {
    //   await repo.createGame();
    //   yield GoToGameRoomState(_model);
    // }

  }





}

class MainMenuModel {
  MainMenuModel(this.dataModel);
  DataModel dataModel;

  // Variables
  bool privacyPolicyAccepted = false;
  bool profileSetUp = false;
  bool tutorialSetUp = false;
  String? privacyPolicyString;

  Player? get user  => dataModel.user;


}

