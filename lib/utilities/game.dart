import 'dart:math';

import 'package:flutter_bull/classes/firebase.dart';

// TODO Apply game settings
class RoleAssigner {

  RoleAssigner(this.playerIds);

  final List<String> playerIds;

  Map<String, String>? playerTargets;
  Map<String, bool>? playerTruths;

  void assignRoles() {

    playerTruths = {};
    int liarCount = 0;
    for(String id in playerIds)
      {
        double random = Random().nextDouble();
        bool truth = random < 0.5;
        playerTruths!.addAll({id : truth});
        if(!truth) liarCount++;
      }

    if(liarCount == 1)
      {
        // Randomly assign one other liar
        List<String> truthers = List<String>.from(playerTruths!.keys).where((id) => playerTruths![id]!).toList();
        int randomIndex = Random().nextInt(truthers.length);
        playerTruths![truthers[randomIndex]] = false;
      }


    // Pair up liars
    List<String> liars = List<String>.from(playerTruths!.keys).where((id) => !playerTruths![id]!).toList();
    List<int> targetIndices = List<int>.generate(liars.length, (index) => index);

    bool isDerangement = false; // Derangement == a permutation where every position is changed
    while(!isDerangement)
      {
        targetIndices.shuffle();
        isDerangement = true;
        for(int i = 0; i < targetIndices.length; i++)
          {
            if(targetIndices[i] == i)
              {
                isDerangement = false;
                break;
              }
          }
      }

    List<String> targets = List<String>.generate(liars.length, (index) => liars[targetIndices[index]]);
    playerTargets = Map<String, String>.fromIterables(liars, targets);

    // Add truthers for completeness
    for(String id in playerIds)
      {
        if(!playerTargets!.containsKey(id)) playerTargets!.addAll({id : id});
      }
  }



}