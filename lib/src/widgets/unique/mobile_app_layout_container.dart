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
      color: Color.fromARGB(255, 117, 117, 117),
      child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
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
            ),
          ],
        ),
      ),
    );
  }
}
