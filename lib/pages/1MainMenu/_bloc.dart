import 'dart:async';
import 'dart:core';
import 'dart:core';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bull/classes/firebase.dart';
import 'package:flutter_bull/firebase/_bloc.dart';
import 'package:flutter_bull/firebase/_bloc_states.dart' as fbState;
import 'package:flutter_bull/firebase/_bloc_events.dart' as fbEvent;
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

    if(!model.userEstablished) model.addLoadTask(MainMenuModel.LOAD_TASK_ESTABLISH_USER);

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
        fbState.FirebaseState state = event.state;
        model.dataModel = state.model;

        if(state is fbState.OnUserStreamState){
          model.removeLoadTask(MainMenuModel.LOAD_TASK_ESTABLISH_USER);
        }
        if(state is fbState.SubscribingToRoomStartState){
          model.addLoadTask(MainMenuModel.LOAD_TASK_ESTABLISH_ROOM);
        }
        if(state is fbState.NewRoomState){
          model.removeLoadTask(MainMenuModel.LOAD_TASK_ESTABLISH_ROOM);
        }
        if(state is fbState.CreateGameStartedState){
          model.addLoadTask(MainMenuModel.LOAD_TASK_CREATE_GAME);
        }
        if(state is fbState.GameCreatedState){
          model.removeLoadTask(MainMenuModel.LOAD_TASK_CREATE_GAME);
        }
        if(state is fbState.JoinGameStartedState){
          model.addLoadTask(MainMenuModel.LOAD_TASK_JOIN_GAME);
        }
        if(state is fbState.GameJoinedState){
          model.removeLoadTask(MainMenuModel.LOAD_TASK_JOIN_GAME);
        }
        if(state is fbState.LeaveGameStartedState){
          model.addLoadTask(MainMenuModel.LOAD_TASK_LEAVE_GAME);
        }
        if(state is fbState.GameLeftState){
          model.removeLoadTask(MainMenuModel.LOAD_TASK_LEAVE_GAME);
        }

        if(state is fbState.ProfileImageUpdatedState)
        {
          if(state.model.isUser(state.userId))
          {
            yield UserProfileImageChangedState(model);
          }
        }

        if(state is fbState.PlayerNameChangedState)
        {
          if(state.model.isUser(state.userId))
          {
            yield UserNameChangedState(model);
          }
        }

        if(state is fbState.PrivacyPolicyStringRetrievedState)
        {
          model.privacyPolicyString = state.privacyPolicy;
          model.menuState = PrivacyPolicyState(model);
          yield model.menuState;
        }

        if(state is fbState.GameCreatedState)
        {
          //if(state.roomCode != null) yield GoToGameRoomState(model);
          // else print('Game creation unsuccessful');
          print(state.roomCode != null ? 'Game creation successful' : 'Game creation unsuccessful');
        }

        if(state is fbState.GameJoinedState)
        {
          //if(state.success) yield GoToGameRoomState(model);
          // else print('Room join unsuccessful');
          print(state.success ? 'Room join successful' : 'Room join unsuccessful');
        }

        if(state is fbState.NewRoomState)
        {
          yield NewRoomState(model);
        }

        if(state is fbState.GameLeftState)
        {
          yield GameLeftState(state.success, model);
        }

        if(state is fbState.ImagePickedStartedState)
        {
          print('ImagePickedStartedState');
          model.addLoadTask(MainMenuModel.LOAD_TASK_SELECT_IMAGE);
        }
        if(state is fbState.ImagePickedFinishedState)
        {
          print('ImagePickedFinishedState');
          model.removeLoadTask(MainMenuModel.LOAD_TASK_SELECT_IMAGE);
        }
        if(state is fbState.SyncingImageStartedState)
        {
          print('SyncingImageStartedState');
          model.addLoadTask(MainMenuModel.LOAD_TASK_SYNC_IMAGE);
        }
        if(state is fbState.SyncingImageFinishedState)
        {
          print('SyncingImageFinishedState');
          model.removeLoadTask(MainMenuModel.LOAD_TASK_SYNC_IMAGE);
        }

        yield MainMenuState(model);
      }

    if(event is PrefsUpdated)
    {
      print('PrefsUpdated ${model.privacyPolicyAccepted.toString()} '
          '${model.profileSetUp.toString()} '
          '${model.tutorialSetUp.toString()} ');
        if(model.privacyPolicyAccepted == false)
          {
            firebaseBloc.add(fbEvent.PrivacyPolicyStringRequestedEvent());
          }
        else if(model.profileSetUp == false)
          {
            model.menuState = ProfileSetupState(model);
            yield model.menuState;
          }
        else if(model.tutorialSetUp == false)
          {
            model.menuState = TutorialSetupState(model);
            yield model.menuState;
          }
        else {
          model.menuState = MenuState(model);
          yield model.menuState;
        }
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
      if(!event.text.isNullOrEmpty()) firebaseBloc.add(fbEvent.ChangeUsernameEvent(event.text!));
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
        try{
          PickedFile? pickedFile;
          pickedFile = await event.picker.getImage(source: event.source);

          if(pickedFile == null) return;

          File file = new File(pickedFile.path);
          firebaseBloc.add(fbEvent.ImagePicked(file));
        }catch(e){
          print('ERROR at MainMenuBloc me2s ImageSelectionRequested: ' + e.toString());
        }
      }

    if(event is NewNameSubmittedEvent)
      {
        if(event.name.isNullOrEmpty()) return;
        firebaseBloc.add(fbEvent.ChangeUsernameEvent(event.name));
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
      firebaseBloc.add(fbEvent.CreateGameRequested());
    }

    if(event is JoinGameEvent)
    {
      firebaseBloc.add(fbEvent.JoinGameRequested(event.code));
    }

    if(event is LeaveGameEvent)
      {
        firebaseBloc.add(fbEvent.LeaveGameRequested());

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

  static const String LOAD_TASK_SELECT_IMAGE = 'Selecting display pic...';
  static const String LOAD_TASK_SYNC_IMAGE = 'Syncing display pic...';
  static const String LOAD_TASK_ESTABLISH_USER = 'Loading user...';
  static const String LOAD_TASK_ESTABLISH_ROOM = 'Loading game...';
  static const String LOAD_TASK_CREATE_GAME = 'Creating game...';
  static const String LOAD_TASK_JOIN_GAME = 'Joining game...';
  static const String LOAD_TASK_LEAVE_GAME = 'Leaving game...';

  List<String> loadTasks = [];
  bool get loading => loadTasks.isNotEmpty;
  String? get loadingMessage => loadTasks.isEmpty ? null : loadTasks.join('\n');

  // Variables
  bool privacyPolicyAccepted = false;
  bool profileSetUp = false;
  bool tutorialSetUp = false;
  String? privacyPolicyString;

  Player? get user  => dataModel.user;

  bool get userEstablished => dataModel.userEstablished;
  bool get roomEstablished => dataModel.roomEstablished;

  late MainMenuState menuState = InitialState(this);

  void removeLoadTask(String task) {
    loadTasks.remove(task);
  }
  void addLoadTask(String task) {
    if(!loadTasks.contains(task)) loadTasks.add(task);
  }
}

