import 'package:flutter/src/widgets/image.dart';
import 'package:flutter_bull/classes/firebase.dart';
import 'package:flutter_bull/firebase/_bloc.dart';
import 'package:flutter_bull/pages/1MainMenu/_bloc.dart';

class MainMenuState{
  const MainMenuState(this.model);
  final MainMenuModel model;
}

class InitialState extends MainMenuState{
  const InitialState(MainMenuModel model) : super(model);
}

class PlayerUpdatedState extends MainMenuState{
  const PlayerUpdatedState(MainMenuModel model) : super(model);
}

class NewUserIdState extends MainMenuState{
  const NewUserIdState(MainMenuModel model) : super(model);
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

class UserProfileImageChangedState extends MainMenuState{
  const UserProfileImageChangedState(MainMenuModel model) : super(model);
}
class UserNameChangedState extends MainMenuState{
  const UserNameChangedState(MainMenuModel model) : super(model);
}

class NewRoomState extends MainMenuState{
  const NewRoomState(MainMenuModel model) : super(model);
}

class GameLeftState extends MainMenuState {
  const GameLeftState(bool success, MainMenuModel model) : super(model);
}


class LoadingState extends MainMenuState {
  const LoadingState(MainMenuModel model, {this.loading = false, this.message}) : super(model);
  final bool loading;
  final String? message;
}

