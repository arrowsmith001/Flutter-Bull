import 'dart:async';
import 'dart:core';
import 'dart:core';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bull/classes/firebase.dart';
import 'package:flutter_bull/utilities/firebase.dart';
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

    // subscriptions.add(repo.streamCurrentPlayerImage().listen((event)
    // {
    //   if(event != null) _model.setImage(event);
    // }));
    //
    // subscriptions.add(repo.streamCurrentPlayer().listen((event)
    // {
    //   _model.player = event;
    //   if(_model.player != null && _model.player!.occupiedRoomCode != null)
    //     {
    //       add(GoToGameRoomEvent());
    //     }
    // }));
    //
    // repo.subscribeToCurrentPlayer().listen((event) {
    //   print(event.snapshot.key.toString() + ' : ' + event.snapshot.value.toString());
    // });
    //
    // _model.addListener(() { add(ProfileImageChangedEvent());  });

    refreshPrefs();
  }

  void refreshPrefs(){
    _model.privacyPolicyAccepted = _prefs.getBool(AppStrings.PRIVACY_POLICY_ACCEPTED)??false;
    _model.profileSetUp = _prefs.getBool(AppStrings.PREFS_FIRST_TIME_PROFILE_SETUP)??false;
    _model.tutorialSetUp = _prefs.getBool(AppStrings.PREFS_TUTORIAL_MODE_ON)??false;
    add(new PrefsUpdated());
  }


  MainMenuModel _model = new MainMenuModel();

  Repository repo;
  PrefsManager get _prefs => PrefsManager();

  List<StreamSubscription> subscriptions = [];
  StreamSubscription<String?>? userIdSub;
  StreamSubscription<Player?>? playerSub;
  StreamSubscription<Map>? playerChangesSub;

  @override
  void onEvent(MainMenuEvent event) {
    super.onEvent(event);
    print('Event received: ' + event.runtimeType.toString() + " at " + DateTime.now().toString());
  }

  @override
  Stream<MainMenuState> mapEventToState(MainMenuEvent event) async* {

    if(event is SetupEvent){

      if(userIdSub != null) await userIdSub!.cancel();
      userIdSub = repo.streamCurrentUserId().listen((userId) {
        if(userId != null)
        {
          add(OnUserIdStreamEvent(userId));
        }
      });
    }

    if(event is OnUserIdStreamEvent)
    {
      _model.uid = event.userId;

      // This is just to initialize the player
      await repo.setPlayerField(_model.uid!, Player.ID, _model.uid);

      if(playerSub != null) await playerSub!.cancel();
      if(playerChangesSub != null) await playerChangesSub!.cancel();

      playerSub = repo.streamPlayer(_model.uid!).listen((player) {
        if (player != null) {
          //print('streamPlayer: ${player.toJson().toString()}' + DateTime.now().toString());
          add(OnPlayerStreamEvent(player));
        }
      });

      playerChangesSub = repo.streamPlayerChanges(_model.uid!).listen((changes) {
            if (changes != null) {
              //print('streamPlayerChanges: ${changes.toString()}' + DateTime.now().toString());
              add(OnPlayerChangeStreamEvent(changes));
            }
          });
    }


    if(event is OnPlayerStreamEvent)
    {
      Player player = event.player;

      if(_model.player == null || _model.player!.profileImage == null)
        {
          print('event is OnPlayerStreamEvent : Initializing player image');

          _model.syncingImage = true;
          yield MainMenuState(_model);

          Image? newProfileImage = await repo.getProfileImage(player.profileId);
          player.profileImage = newProfileImage;

          _model.syncingImage = false;
        }

      _model.setPlayer(player);
      yield PlayerUpdatedState(_model);
    }

    if(event is OnPlayerChangeStreamEvent)
    {
        if(event.changes.containsKey(Player.PROFILE_ID))
          {
            print('OnPlayerChangeStreamEvent: Profile Id Changed');
            String profileId = event.changes[Player.PROFILE_ID];

            _model.syncingImage = true;
            yield MainMenuState(_model);

            _model.player!.profileImage = await repo.getProfileImage(profileId);

            _model.syncingImage = false;
            yield ProfileImageChangedState(_model);
          }
        if(event.changes.containsKey(Player.NAME))
          {
            yield NameChangedState(_model);
          }
    }


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
      await repo.setPlayerField(_model.uid!, Player.NAME, event.text);
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
        String? fileExt = await repo.uploadProfileImage(file);
        await repo.setPlayerField(_model.uid!, Player.PROFILE_ID, fileExt);
      }

    if(event is NewNameSubmittedEvent)
      {
        if(event.name.isNullOrEmpty()) return;
        await repo.setPlayerField(_model.uid!, Player.NAME, event.name);
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
      String? roomCode = await repo.createGame(_model.uid!);
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

  String? uid; // Null or not determines logged-in/logged-out state

  Player? player;
  bool syncingImage = false;

  bool privacyPolicyAccepted = false;
  bool profileSetUp = false;
  bool tutorialSetUp = false;

  setImage(Image newImage){
    bool notify = (newImage != player!.profileImage);
    player!.profileImage = newImage;
    if(notify) notifyListeners();
  }

  String? privacyPolicyString;

  void setUserId(String? userId) {
    this.uid = userId;
  }

  void setPlayer(Player player) {
    if(this.player != null)
    {
      player.profileImage = this.player!.profileImage;
    }

    this.player = player;
  }
}

