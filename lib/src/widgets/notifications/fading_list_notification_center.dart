import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bull/src/custom/extensions/riverpod_extensions.dart';
import 'package:flutter_bull/src/new/notifiers/misc/notification_notifier.dart';
import 'package:flutter_bull/src/new/notifiers/states/notification.dart' as notifs;
import 'package:flutter_bull/src/widgets/notifications/notification_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:transparent_pointer/transparent_pointer.dart';

import 'self_removing_widget.dart';

class FadingListNotificationCenter extends ConsumerStatefulWidget {
  const FadingListNotificationCenter({super.key, this.blockIf});

  final bool Function()? blockIf;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FadingListNotificationCenterState();
}

class _FadingListNotificationCenterState
    extends ConsumerState<FadingListNotificationCenter> {

  static const lifetime = Duration(seconds: 8);

  final _listKey = GlobalKey<AnimatedListState>();
  final _listController = ScrollController();

  List<notifs.Notification> list = [];

  @override
  void initState() {
    super.initState();

    // Timer.periodic(Duration(milliseconds: 2500), (t) {
    //   ref.read(notificationNotifierProvider.notifier).pushNotif(
    //       notifs.Notification(
    //           message: 'message ' + DateTime.now().second.toString(),
    //           type: notifs.NotificationType.error));
    // });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
        notificationNotifierProvider.select(
            (value) => value.valueOrNull?.notifs.lastOrNull), (prev, next) {
      if (widget.blockIf != null && widget.blockIf!.call()) return;

      if (prev?.time == next?.time) return;

      Logger().d('fadinglist: prev $prev next $next');

      if (next != null && !next.isRead) {
        ref.read(notificationNotifierProvider.notifier).setRead(next);

        list = [next, ...list];
        _listKey.currentState
            ?.insertItem(0, duration: Duration(milliseconds: 200));

        SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
          _listController.animateTo(_listController.position.maxScrollExtent,
              duration: Duration(milliseconds: 200), curve: Curves.easeOut);
        });
      }
    });

    return TransparentPointer(
      child: ref.watch(notificationNotifierProvider).whenDefault((data) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: AnimatedList(
                  controller: _listController,
                  reverse: false,
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  initialItemCount: 0,
                  key: _listKey,
                  itemBuilder: (context, index, animation) {
                    return SlideTransition(
                        position: animation.drive(
                            Tween(begin: Offset(1, 0), end: Offset.zero)),
                        child: _buildListItem(index));
                  }),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildListItem(int index) {
    final notif = list[index];
    return SelfRemovingWidget(
        lifetime: lifetime,
        remove: () {
          remove(notif);
        },
        data: notif,
        child: _buildNotifView(notif));
  }

  Widget _buildNotifView(notifs.Notification notif) {
    return AspectRatio(
        aspectRatio: 3,
        child: NotificationView(notif, dismiss: (n) {
          remove(n);
        }, opacity: 0.7));
  }

  void remove(notifs.Notification notif) {
    final index = list.indexOf(notif);
    if (index < 0) return;

    final notifCopy = notifs.Notification(
        message: list[index].message,
        type: list[index].type,
        time: DateTime.now());

    _listKey.currentState?.removeItem(index, (context, animation) {
      return FadeTransition(
        opacity: animation,
        child: _buildNotifView(notifCopy),
      );
    });

    list.removeAt(index);
  }
}
