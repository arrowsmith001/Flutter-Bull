import 'package:flutter/src/widgets/editable_text.dart';
import 'package:flutter_bull/classes/firebase.dart';
import 'package:flutter_bull/pages/1MainMenu/_bloc.dart';
import 'package:image_picker/image_picker.dart';

class MainMenuEvent{}

class PrivateMainMenuEvent extends MainMenuEvent {}

class OnUserIdStreamEvent extends PrivateMainMenuEvent {
  OnUserIdStreamEvent(this.userId);
  String? userId;
}
class OnPlayerStreamEvent extends PrivateMainMenuEvent {
  OnPlayerStreamEvent(this.player);
  Player player;
}
class OnPlayerChangeStreamEvent extends PrivateMainMenuEvent {
  OnPlayerChangeStreamEvent(this.changes);
  Map changes;
}



class SetupEvent extends MainMenuEvent {}

class PrefsUpdated extends MainMenuEvent {}







class PrivacyPolicyPressed extends MainMenuEvent {
  PrivacyPolicyPressed(this.accepted);
  bool accepted;
}

class ProfileSetupPressed extends MainMenuEvent {
  ProfileSetupPressed(this.text);
  String? text;
}

class TutorialSetupPressed extends MainMenuEvent {
  TutorialSetupPressed(this.tutorialModeOn);
  bool tutorialModeOn;
}


class CreateGameEvent extends MainMenuEvent {}

class JoinGameEvent extends MainMenuEvent {
  JoinGameEvent(this.code);
  String code;
}

class DebugEvent extends MainMenuEvent {
  DebugEvent({
    this.clearAllPrefs = false
  });

  bool clearAllPrefs;
}

class ImageSelectionRequested extends MainMenuEvent {
  ImageSelectionRequested(this.picker, this.source);
  ImagePicker picker;
  ImageSource source;
}

class NewNameSubmittedEvent extends MainMenuEvent {
  NewNameSubmittedEvent(this.name);
  String name;
}

class GoToGameRoomEvent extends MainMenuEvent{
}




