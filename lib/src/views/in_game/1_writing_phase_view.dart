import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WritingPhaseView extends ConsumerStatefulWidget {
  const WritingPhaseView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WritingPhaseViewState();
}

class _WritingPhaseViewState extends ConsumerState<WritingPhaseView> {

  @override
  Widget build(BuildContext context) {
    return Text('Writing');
  }
}