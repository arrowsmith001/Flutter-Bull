import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bull/utilities/prefs.dart';
import 'package:flutter_bull/utilities/repository.dart';
import 'package:flutter_bull/utilities/res.dart';

import '_bloc_events.dart';
import '_bloc_states.dart';

class LoadingBloc extends Bloc<LoadingEvent, LoadingState>{
  LoadingBloc() : super(InitialState());

  Future<void> initializeFirebaseApp() async {
      await Firebase.initializeApp();
  }

  Future<void> initializePrefs() async {
    var prefsManager = PrefsManager();
    await prefsManager.initializePrefs();
  }

  Future<void> signIn() async {
    await FirebaseAuth.instance.signInAnonymously();
  }

  Stream<double> loadStaticResources() {
    var resourceManager = ResourceManager();
    return resourceManager.loadAllUiImages();
  }


  @override
  Stream<LoadingState> mapEventToState(LoadingEvent event) async* {

    if(event is StartLoading)
      {
        yield LoadingProgress('Initializing app');

        try{
          await initializeFirebaseApp();

          await Future.wait([
            initializePrefs(), signIn()
          ]);

          yield* loadStaticResources().map((progress) {

            if(progress != 1.0)
              {
                int progressPercent = (progress*100).round();
                return LoadingProgress('Loading resources: ${progressPercent}%', progress);
              }
            else
              {
                return LoadingComplete();
              }

          });

        }
        catch(e)
        {
          yield LoadingError(e.toString());
        }

      }
  }


}

