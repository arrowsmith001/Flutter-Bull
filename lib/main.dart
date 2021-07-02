import 'dart:async';
import 'dart:typed_data';
import 'dart:math' as math;
import 'package:arrowsmith/arrowsmith.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bull/firebase/_bloc.dart';
import 'package:flutter_bull/gen/assets.gen.dart';
import 'package:flutter_bull/pages/0Loading/_bloc.dart';
import 'package:flutter_bull/pages/0Loading/_page.dart';
import 'package:flutter_bull/pages/1MainMenu/_bloc.dart';
import 'package:flutter_bull/pages/1MainMenu/_page.dart';
import 'package:flutter_bull/pages/2GameRoom/_bloc.dart';
import 'package:flutter_bull/particles.dart';
import 'package:flutter_bull/utilities/game.dart';
import 'package:flutter_bull/utilities/local_res.dart';
import 'package:flutter_bull/firebase/provider.dart';
import 'package:flutter_bull/utilities/repository.dart';
import 'package:flutter_bull/utilities/res.dart';
import 'package:flutter_bull/utilities/prefs.dart';
import 'package:flutter_bull/utilities/profile.dart';
import 'package:flutter_bull/widgets.dart';
import 'package:multiple_stream_builder/multiple_stream_builder.dart';
import 'package:prefs/prefs.dart';
import 'package:provider/provider.dart';
import 'classes/classes.dart';
import 'classes/firebase.dart';
import 'developer.dart';
import 'package:extensions/extensions.dart';
import 'dart:ui' as ui;


void main() {
    WidgetsFlutterBinding.ensureInitialized();
    runApp(MyApp());
}

class MyApp extends StatelessWidget {

    @override
    Widget build(BuildContext context) {
      return _buildApp();
  }


  bool inserted = false;

  Widget _buildApp(){

      bool devMode = GameParams.DEV_MODE;

      Widget app = CupertinoApp(
        title: 'Utter Bull',
        theme: CupertinoThemeData(
            scaffoldBackgroundColor: AppColors.MainColor,
            primaryColor: AppColors.MainColor
        ),
        home: LayoutBuilder(
          builder: (context, constraints) {

            // TODO Remove this before release
            if(devMode && !inserted)
              {
                if(kReleaseMode) throw Exception('Remove all references to developer panel');
                else WidgetsBinding.instance!.addPostFrameCallback((_) => _insertOverlay(context));
              }

            return Loading();
          }
        ),
      );

      return RepositoryProvider(
        lazy: true,
        create: (_) => Repository(),
        child: MultiBlocProvider(
            providers: [
              BlocProvider<FirebaseBloc>(lazy: true, create: (_) => FirebaseBloc(repo: RepositoryProvider.of<Repository>(_))),

              BlocProvider<LoadingBloc>(lazy: true, create: (_) => LoadingBloc()),

              BlocProvider<MainMenuBloc>(lazy: true, create: (_)
              {
                var firebaseBloc = BlocProvider.of<FirebaseBloc>(_);
                return MainMenuBloc(new MainMenuModel(firebaseBloc.model), firebaseBloc: firebaseBloc);
              }),

              BlocProvider<GameRoomBloc>(lazy: true, create: (_)
              {
                var firebaseBloc = BlocProvider.of<FirebaseBloc>(_);
                return GameRoomBloc(new GameRoomModel(firebaseBloc.model), firebaseBloc: firebaseBloc);
              }),
            ],
            child: app),
      );
  }


    // TODO Remove all this before release
    void _insertOverlay(BuildContext context) {
      if(kReleaseMode) throw Exception('Remove all references to developer panel');
      inserted = true;
      return Overlay.of(context)!.insert(
        OverlayEntry(builder: (context) {
          final size = MediaQuery.of(context).size;
          return DeveloperPanel(context);
        }),
      );
    }

}

//
// void main() async {
//     WidgetsFlutterBinding.ensureInitialized();
//     await Firebase.initializeApp();
//     runApp(MyApp());
// }
// class MyApp extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Test',
//       home: Test(),
//     );
//   }
// }
//
// class Test extends StatefulWidget {
//
//   static const String FIREBASE_DATABASE_URL = 'https://flutter-bull-default-rtdb.europe-west1.firebasedatabase.app/'; // Your own Firebase Realtime Database URL goes here
//   final String TEST_PATH = 'my/test/path'; // Your own test path, as you see fit
//
//   final DatabaseReference databaseReference = FirebaseDatabase(databaseURL: FIREBASE_DATABASE_URL).reference();
//
//   @override
//   _TestState createState() => _TestState();
// }
//
// class _TestState extends State<Test> {
//
//
//   static const String alphabet = 'abcdefghijklmnopqrstuvwxyz';
//   List<String> list = List.generate(alphabet.length, (i) => alphabet[i]);
//
//   _setList() async {
//     await widget.databaseReference.child(widget.TEST_PATH).set(list);
//   }
//
//   _removeListItem1(int i) async {
//
//     await widget.databaseReference
//         .child(widget.TEST_PATH)
//         .runTransaction((mutableData) async {
//
//       assert(mutableData.value is List);
//       List<String> list = List.from(mutableData.value);
//       list.removeAt(i);
//       mutableData.value = list;
//       return await mutableData;
//     });
//   }
//
//   _removeListItem2(int i) async {
//
//     list.removeAt(i);
//     _setList();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Center(
//           child: Column(
//             children: [
//
//               ElevatedButton(
//                   onPressed: _setList,
//                   child: Text('Please set list on realtime database')),
//
//               Expanded(
//                 child: StreamBuilder<Event>(
//                   stream: widget.databaseReference.child(widget.TEST_PATH).onValue,
//                     builder: (context, snap) {
//
//                       if(!snap.hasData || snap.data!.snapshot.value == null) return Center(child: Text('Press button above'),);
//
//                       List<String> value = List.from(snap.data!.snapshot.value);
//
//                      return ListView.builder(
//                           itemCount: value.length,
//                           itemBuilder: (context, i) =>
//                               ListTile(
//                                   onTap: () => _removeListItem2(i),
//                                   title: Text('($i)   ' + value[i]))
//                      );
//
//                     }
//                 ),
//               ),
//
//               StreamBuilder<Event>(
//                 stream: widget.databaseReference.child(widget.TEST_PATH).onChildRemoved,
//                   builder: (context, snap){
//
//                   String message = 'No changes made';
//
//                     if(snap.hasData){
//
//                       dynamic key = snap.data!.snapshot.key;
//                       dynamic value = snap.data!.snapshot.value;
//
//                       message = 'Latest child removed: \n ${value.toString()} at ${key.toString()}';
//                     }
//
//                     return Text(message, style: TextStyle(fontSize: 32), textAlign: TextAlign.center);
//
//                   })
//
//             ],
//           ),
//         )
//       ),
//     );
//   }
// }
//






