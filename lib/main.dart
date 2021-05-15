import 'dart:async';
import 'dart:typed_data';
import 'dart:math' as math;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bull/gen/assets.gen.dart';
import 'package:flutter_bull/pages/1MainMenu/_mainMenu.dart';
import 'package:flutter_bull/particles.dart';
import 'package:flutter_bull/utilities/localRes.dart';
import 'package:flutter_bull/utilities/res.dart';
import 'package:flutter_bull/utilities/prefs.dart';
import 'package:flutter_bull/utilities/profile.dart';
import 'package:multiple_stream_builder/multiple_stream_builder.dart';
import 'package:prefs/prefs.dart';
import 'package:provider/provider.dart';
import 'extensions.dart';
import 'dart:ui' as ui;
import 'package:image/image.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


    @override
    Widget build(BuildContext context) {


     final Future<FirebaseApp> _fbInit = Firebase.initializeApp();


      var loading = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                //Text(snaps.item1 == null || snaps.item1.connectionState != ConnectionState.done ? "Setting up Firebase..." : "Firebase Setup", textDirection: TextDirection.ltr),
                //Text(snaps.item2 == null ? "Loading Profile..." : "Profile loaded", textDirection: TextDirection.ltr),
                //Text("Loading resources..." + snaps.item3.data.toString(), textDirection: TextDirection.ltr),
              ],
            ).ExpandedExt()
          ],
        ),
      );

      return FutureBuilder(
        future: _fbInit,
        builder: (context, snap){

          if(snap.hasError){
            print(snap.error);
          }

          if(snap.hasData && !snap.hasError && snap.connectionState == ConnectionState.done)
            {
              ResourceManager resMan = new ResourceManager();
              ProfileManager proMan = new ProfileManager();
              PrefsManager prefMan = new PrefsManager();

              final Stream<bool> loadProfile = proMan.loadProfileFromPreferences().asStream();
              final Stream<double> loadResources = resMan.loadAllResources();
              final Stream prefs = prefMan.initializePrefs().asStream();

              return StreamBuilder3<bool?, double?, dynamic>(
                  streams: Tuple3(loadProfile, loadResources, prefs),
                  initialData: Tuple3(null, 0, null),
                  builder: (context, snaps){


                    bool stream2Done = snaps.item1 != null;
                    bool stream3Done = snaps.item2.data == 1.0;
                    bool stream4Done = snaps.item3 != null;

                    print(stream2Done.toString() + " " + stream3Done.toString() + " " + stream4Done.toString());

                    if(stream2Done && stream3Done && stream4Done)
                    {
                      return CupertinoApp(
                        title: 'Utter Bull',
                        theme: CupertinoThemeData(
                            primaryColor: AppColors.MainColor
                        ),
                        home: MainMenu(),
                      );
                    }

                    return loading;
                  });
            }
          return loading;
        },
      );





     // return FutureBuilder(
     //   //future: Future.wait([_fbInit, loadProfile]),
     //     builder: (context, AsyncSnapshot<List<dynamic>> snap)
     //   {
     //
     //   if(snap.data?[0].hasError?? false){
     //     print("Firebase error");
     //     return Text("Firebase error", textDirection: TextDirection.ltr);
     //   }
     //
     //   if(snap.data?[0].connectionState == ConnectionState.done)
     //     {
     //       return StreamBuilder<double>(
     //           stream: loadResources,
     //           builder: (ctx, snap){
     //
     //             if(!snap.hasData || snap.data != 1.0) {
     //
     //               double value = snap.data??0;
     //
     //               int progress = (100 * value).round();
     //               return Center(
     //                 child: Column(
     //                   mainAxisAlignment: MainAxisAlignment.center,
     //                   children: [
     //                     Column(
     //                       mainAxisAlignment: MainAxisAlignment.center,
     //                       children: [
     //                         CircularProgressIndicator(value: snap.data??0),
     //                         Text(progress.toString() + "%", textDirection: TextDirection.ltr)
     //                       ],
     //                     ).ExpandedExt()
     //                   ],
     //                 ),
     //               );
     //             }
     //
     //             //return app;
     //
     //           });
     //     }
     //
     //     return Center(
     //       child: Column(
     //         mainAxisAlignment: MainAxisAlignment.center,
     //         children: [
     //           Column(
     //             mainAxisAlignment: MainAxisAlignment.center,
     //             children: [
     //               CircularProgressIndicator(),
     //               Text("Setting up Firebase...", textDirection: TextDirection.ltr)
     //             ],
     //           ).ExpandedExt()
     //         ],
     //       ),
     //     );
     //
     // });

  }
}







