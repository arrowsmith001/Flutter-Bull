import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bull/src/custom/extensions/riverpod_extensions.dart';
import 'package:flutter_bull/src/views/new/notifiers/notification_notifier.dart';
import 'package:flutter_bull/src/views/new/notifiers/states/notification.dart'
    as notifs;
import 'package:flutter_bull/src/widgets/common/utter_bull_text_box.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transparent_pointer/transparent_pointer.dart';
import 'package:logger/logger.dart';

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
  late final Animation<double> anim =
      CurvedAnimation(parent: _animController, curve: Curves.easeInOut, reverseCurve: Curves.linear);

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
      if (prev?.time == next?.time) return;

      Logger().d('static: prev $prev next $next');

      if (next != null &&
          !next.isRead &&
          (widget.typeFilter == null || widget.typeFilter!(next))) {
        ref.read(notificationNotifierProvider.notifier).setRead(next);

        if (mounted) {
          setState(() {
            this.notif = next;
            isShowing = true;
            _animController.forward();
          });
        }
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
}

class FadingListNotificationCenter extends ConsumerStatefulWidget {
  const FadingListNotificationCenter({super.key, this.blockIf});

  final bool Function()? blockIf;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FadingListNotificationCenterState();
}

class _FadingListNotificationCenterState
    extends ConsumerState<FadingListNotificationCenter> {
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
        lifetime: Duration(seconds: 20),
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

class ScrollableListNotificationCenter extends ConsumerStatefulWidget {
  const ScrollableListNotificationCenter({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ScrollableListNotificationCenterState();
}

class _ScrollableListNotificationCenterState
    extends ConsumerState<ScrollableListNotificationCenter> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class SelfRemovingWidget<T> extends StatefulWidget {
  SelfRemovingWidget(
      {super.key,
      required this.child,
      required this.lifetime,
      required this.remove,
      required this.data});

  final Widget child;
  final Duration lifetime;
  final VoidCallback remove;
  final T data;

  @override
  State<SelfRemovingWidget> createState() => _SelfRemovingWidgetState();
}

class _SelfRemovingWidgetState<T> extends State<SelfRemovingWidget<T>> {
  late Timer t;

  @override
  void initState() {
    super.initState();
    t = Timer(widget.lifetime, () {
      widget.remove.call();
      t.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
