import 'package:flutter/material.dart';
import 'package:flutter_bull/src/new/notifiers/misc/notification_notifier.dart';
import 'package:flutter_bull/src/new/notifiers/states/notification.dart'
    as notifs;
import 'package:flutter_bull/src/widgets/notifications/notification_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transparent_pointer/transparent_pointer.dart';

class StaticRecentNotificationCenter extends ConsumerStatefulWidget {
  StaticRecentNotificationCenter(
      {super.key, this.padding = const EdgeInsets.all(8.0), this.typeFilter});

  final EdgeInsets padding;
  final DateTime timeOpened = DateTime.now();
  final bool Function(notifs.Notification)? typeFilter;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      StaticRecentNotificationCenterState();
}

class StaticRecentNotificationCenterState
    extends ConsumerState<StaticRecentNotificationCenter>
    with SingleTickerProviderStateMixin {
  notifs.Notification? notif;

  @override
  void initState() {
    super.initState();

    // // Initializes notif anim
    // final bool notifExists = ref
    //         .read(notificationNotifierProvider)
    //         .valueOrNull
    //         ?.notifs
    //         .where((element) => element.type == widget.typeFilter)
    //         .isNotEmpty ??
    //     false;

    // _animController.value = notifExists ? 1.0 : 0.0;
  }

  late final AnimationController _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      reverseDuration: Duration(milliseconds: 150));
  late final Animation<double> anim = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeInOut,
      reverseCurve: Curves.linear);

  void dismiss() {
    if (mounted) {
      setState(() {
        isShowing = false;
        _animController.reverse();
      });
    }
  }

  bool isShowing = false;

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
        notificationNotifierProvider.select(
            (value) => value.valueOrNull?.notifs.lastOrNull), (prev, next) {

      if(next != null) setNotif(next);
      return;
      
      if (prev?.time == next?.time) return;

      if (next != null &&
          !next.isRead &&
          (widget.typeFilter == null || widget.typeFilter!(next))) {
        ref.read(notificationNotifierProvider.notifier).setRead(next);

        setNotif(next);
      }
    });

    return TransparentPointer(
      child: AnimatedBuilder(
        animation: anim,
        builder: (context, child) {
          return FadeTransition(
            opacity: anim,
            child: Align(
              alignment: Alignment.bottomCenter,
              heightFactor: anim.value,
              child: child,
            ),
          );
        },
        child: notif == null
            ? SizedBox.shrink()
            : NotificationView(notif!,
                dismiss: (_) => dismiss(),
                key: ValueKey(notif!.time.millisecondsSinceEpoch)),
      ),
    );
  }

  void setNotif(notifs.Notification notification) {
    if (mounted) {
      setState(() {
        this.notif = notification;
        isShowing = true;
        _animController.forward();
      });
    }
  }
}
