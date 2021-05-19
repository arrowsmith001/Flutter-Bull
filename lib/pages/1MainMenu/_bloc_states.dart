import 'package:flutter/src/widgets/image.dart';
import 'package:flutter_bull/classes/firebase.dart';
import 'package:flutter_bull/pages/1MainMenu/_bloc.dart';

class MainMenuState{
  const MainMenuState(this.model);
  final MainMenuModel model;
}

class InitialState extends MainMenuState{
  const InitialState(MainMenuModel model) : super(model);

}

class DialogState extends MainMenuState {
  const DialogState(MainMenuModel model) : super(model);
}

class PrivacyPolicyState extends DialogState{
  const PrivacyPolicyState(MainMenuModel model) : super(model);
}

class ProfileSetupState extends DialogState{
  const ProfileSetupState(MainMenuModel model) : super(model);
}

class TutorialSetupState extends DialogState{
  const TutorialSetupState(MainMenuModel model) : super(model);
}

class MenuState extends MainMenuState{
  const MenuState(MainMenuModel model) : super(model);
}

class ProfileImageChangedState extends MainMenuState{
  const ProfileImageChangedState(MainMenuModel model) : super(model);
}

class GoToGameRoomState extends MainMenuState{
  const GoToGameRoomState(MainMenuModel model) : super(model);
}