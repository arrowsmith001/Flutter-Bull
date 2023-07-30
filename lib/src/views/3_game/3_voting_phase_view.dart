import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VotingPhaseView extends ConsumerStatefulWidget {
  const VotingPhaseView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WritingPhaseViewState();
}

class _WritingPhaseViewState extends ConsumerState<VotingPhaseView> {

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}