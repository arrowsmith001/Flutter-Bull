import 'package:flutter/material.dart';
import 'package:flutter_bull/classes/firebase.dart';
import 'package:flutter_bull/utilities/firebase.dart';
import 'package:flutter_bull/widgets.dart';
import 'package:provider/provider.dart';

class GameRoom extends StatefulWidget {

  @override
  _GameRoomState createState() => _GameRoomState();
}

class _GameRoomState extends State<GameRoom> {
  @override
  Widget build(BuildContext context) {

    return StreamBuilder<Room?>(
      stream: Provider.of<DatabaseOps>(context).streamRoom(Provider.of<String?>(context)),
      builder: (context, snap) {

        var room = snap.data;

        return SafeArea(
          child: Scaffold(
            body: Container(
                child: room == null || room.code == null ? EmptyWidget()
                    : Text('Lets play: ' + room!.code!)
            ),
          ),
        );
      },
      initialData: null,
    );
  }
}
