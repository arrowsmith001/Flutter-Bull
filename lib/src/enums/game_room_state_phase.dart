

import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum GameRoomStatePhase 
{ 
  @JsonValue(0)
  lobby, 
  @JsonValue(1)
  writing, 
  @JsonValue(2)
  selecting,
  @JsonValue(3)
   reading, 
  @JsonValue(4)
   reveals, 
  @JsonValue(5)
   results 
}
