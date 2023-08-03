import 'package:json_annotation/json_annotation.dart';


@JsonEnum()
enum GamePhase {
  @JsonValue(0)
  lobby,
  @JsonValue(1)
  writing,
  @JsonValue(2)
  round,
  @JsonValue(3)
  reveals,
  @JsonValue(4)
  results
}

@JsonEnum()
enum RoundPhase {
  @JsonValue(0)
  selecting,
  @JsonValue(1)
  voting
}
