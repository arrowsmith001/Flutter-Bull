import 'package:flutter_bull/src/model/game_result.dart';
import 'package:flutter_bull/src/model/game_room.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '4_result_view_model.freezed.dart';

@freezed
class ResultViewModel with _$ResultViewModel {

   factory ResultViewModel({
    required GameRoom game, 
    required  List<PlayerWithAvatar> players,
      required String userId,
      GameResult? result,
  }) => ResultViewModel._
  (
    playerBreakdown: new List.empty()
  ); 


  factory ResultViewModel._(
    {
      required List<PlayerBreakdownViewModel> playerBreakdown
    }
  ) = _ResultViewModel;
}


@freezed
class PlayerBreakdownViewModel with _$PlayerBreakdownViewModel 
{
   factory PlayerBreakdownViewModel({
    required PlayerWithAvatar playerWithAvatar,
    required int score,
    required int previousScore,
    required int scoreDifference
  }) = _PlayerBreakdownViewModel; 
}