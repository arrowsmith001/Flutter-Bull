
class FirebaseBlocException {
  FirebaseBlocException(this.message);
  final String message;
}

class JoinRoomException extends FirebaseBlocException {
  JoinRoomException(String message) : super(message);
}
class LeaveRoomException extends FirebaseBlocException {
  LeaveRoomException(String message) : super(message);
}
class CreateRoomException extends FirebaseBlocException {
  CreateRoomException(String message) : super(message);
}