import 'package:flutter/material.dart';

class MobileAppLayoutContainer extends StatelessWidget {
  const MobileAppLayoutContainer({
    super.key,
    required this.child,
  });
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 75, 75, 75),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
              child: AspectRatio(
            aspectRatio: 9 / 20,
            child: LayoutBuilder(builder: (context, constraints) {
              return MediaQuery(
                data: MediaQueryData(size: constraints.biggest),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(4,4,4,24),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: child,
                  ),
                ),
              );
            }),
          )),
        ],
      ),
    );
  }
}
