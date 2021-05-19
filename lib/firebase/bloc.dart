import 'package:bloc/bloc.dart';

import 'events.dart';
import 'states.dart';

class FirebaseBloc extends Bloc<FirebaseEvent, FirebaseState>{

  FirebaseBloc(FirebaseState initialState) : super(initialState);


  @override
  Stream<FirebaseState> mapEventToState(FirebaseEvent event) async* {

    if(event is FirebaseEvent)
      {
        yield FirebaseState();
      }

  }

}