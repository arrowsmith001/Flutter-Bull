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
      color: Color.fromARGB(255, 94, 94, 94),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
              child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: AspectRatio(
                          aspectRatio: 9 / 20,
                          child: LayoutBuilder(builder: (context, constraints) {
                return MediaQuery(
                  data: MediaQueryData(size: constraints.biggest),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: child,
                  ),
                );
                          }),
                        ),
              )),
        ],
      ),
    );
  }
}
