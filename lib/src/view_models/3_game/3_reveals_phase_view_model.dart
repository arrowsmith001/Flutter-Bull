

import 'package:freezed_annotation/freezed_annotation.dart';

part '3_reveals_phase_view_model.freezed.dart';

@freezed

class RevealsPhaseViewModel with _$RevealsPhaseViewModel {

    factory RevealsPhaseViewModel(
      {required String path, 
      required int progress}
      ) = _RevealsPhaseViewModel;
}