

import 'package:flutter/material.dart';

class CardWindow extends StatelessWidget {
  const CardWindow({
    super.key, required this.child
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      clipBehavior: Clip.hardEdge,
                      
                      child: Padding(
                        padding: const EdgeInsets.all(28.0),
                        child: child,
                      ),
                    ),
          ),
        ),
      ],
    );
  }
}