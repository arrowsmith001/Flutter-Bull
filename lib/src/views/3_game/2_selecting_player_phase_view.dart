import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectingPlayerPhaseView extends ConsumerStatefulWidget {
  const SelectingPlayerPhaseView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WritingPhaseViewState();
}

class _WritingPhaseViewState extends ConsumerState<SelectingPlayerPhaseView> {

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}