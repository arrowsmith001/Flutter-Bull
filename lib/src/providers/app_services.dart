import 'package:flutter_bull/src/custom/data/abstract/auth_service.dart';
import 'package:flutter_bull/src/services/data_stream_service.dart';
import 'package:flutter_bull/src/services/game_server.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';


part 'app_services.g.dart';

@Riverpod(keepAlive: true)
AuthService authService(Ref ref) => throw UnimplementedError();

@Riverpod(keepAlive: true)
DataStreamService dataStreamService(Ref ref) => throw UnimplementedError();

@Riverpod(keepAlive: true)
UtterBullServer utterBullServer(Ref ref) => throw UnimplementedError();
