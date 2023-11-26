
import 'package:flutter/material.dart';
import 'package:flutter_bull/src/new/notifiers/states/notification.dart'
    as notifs;
import 'package:flutter_bull/src/widgets/common/utter_bull_text_box.dart';

class NotificationView extends StatelessWidget {
  const NotificationView(this.notification,
      {super.key,
      this.padding = const EdgeInsets.all(4.0),
      required this.dismiss,
      this.opacity = 1.0});

  final notifs.Notification notification;
  final EdgeInsets padding;
  final void Function(notifs.Notification notif) dismiss;
  final double opacity;
  final d = 25.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Padding(
            padding: padding,
            child: UtterBullTextBox(
              notification.message,
              opacity: opacity,
              textSize: 18,
            ),
          ),
        ),
        Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: d,
              height: d,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Colors.grey.shade300),
              child: IconButton(
                  padding: EdgeInsets.zero,
                  alignment: Alignment.center,
                  iconSize: d,
                  onPressed: () => dismiss(notification),
                  icon: Icon(
                    Icons.close,
                    size: d,
                  )),
            ))
      ],
    );
  }
}
