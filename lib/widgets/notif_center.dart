import 'dart:async';

import 'package:arrowsmith/arrowsmith.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../pages/2x1Lobby/_page.dart';

enum LobbyNotifType {
  PlayerAdded, PlayerRemoved, SettingsChanged, MessageOnly
}

class Notif {
  Notif([this.message = 'This is a notification']);
  final String? message;
}

// TODO Improve whole notif system
class NotifCenter<T extends Notif> extends StatefulWidget {
  NotifCenter(
      {required this.notifStream, required this.notifWidgetBuilder,
        this.notifLifespan = const Duration(seconds: 3),
        this.animatedEntryBuilder,this.animatedEntryDuration = const Duration(seconds: 1),
        this.animatedExitBuilder, this.animatedExitDuration = const Duration(seconds: 1)});

  final Stream<T> notifStream;
  final Widget Function(T) notifWidgetBuilder;
  final Duration notifLifespan;
  final Widget Function(Widget, Animation<double>)? animatedEntryBuilder;
  final Duration animatedEntryDuration;
  final Widget Function(Widget, Animation<double>)? animatedExitBuilder;
  final Duration animatedExitDuration;

  @override
  _NotifCenterState<T> createState() => _NotifCenterState<T>();
}

class _NotifCenterState<T extends Notif> extends State<NotifCenter<T>> with TickerProviderStateMixin {

  var _key = new GlobalKey<_NotifCenterState<T>>();

  List<T> notifs = [];

  late StreamSubscription<T> sub;

  @override
  initState(){
    super.initState();
    sub = widget.notifStream.listen((notif) {
    _onNewNotif(notif);
    });
  }

  void removeNotif(final T notif){
    print('Removed notif: ' + (notif as LobbyNotif).userId!);
    notifs.remove(notif);
  }

  @override
  void dispose() {
    sub.cancel();
    super.dispose();
  }

  Widget _defaultEntranceAnimation(Widget widget, Animation<double> animation){
    return Transform.scale(child: widget, scale: animation.value);
  }

  Widget _defaultExitAnimation(Widget widget, Animation<double> animation){
    return Opacity(child: widget, opacity: 1 - animation.value);
  }

  void _onNewNotif(final T notif) async {
    print('notif toString:' + notif.toString());
    notifs.add(notif);
  }

  Widget _buildNotif(final T notif) => Provider<_NotifCenterState>(
    create: (context) => this,
    child: new NotifWidget(
      notif,
      notifWidgetBuilder: widget.notifWidgetBuilder,
      notifLifespan: widget.notifLifespan,
      animatedEntryBuilder: widget.animatedEntryBuilder ?? _defaultEntranceAnimation,
      animatedExitBuilder: widget.animatedExitBuilder ?? _defaultExitAnimation,
      animatedEntryDuration: widget.animatedEntryDuration,
      animatedExitDuration: widget.animatedExitDuration),
  );

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
        stream: widget.notifStream,
        builder: (context, snap)
        {
          if(!snap.hasData || snap.data == null) return EmptyWidget();
          return Container(
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: notifs.length,
                itemBuilder: (context, i) {
                  try{
                    return _buildNotif(notifs[i]);
                  }catch(e){
                    return EmptyWidget();
                  }
                  }
                ),
          );
        });
  }
}

class NotifWidget<T extends Notif> extends StatefulWidget {

  NotifWidget(this.notif,
      //,this.removeNotifCallback,
      {
    required this.notifWidgetBuilder,required this.notifLifespan,
    required this.animatedEntryBuilder,required this.animatedEntryDuration,
    required this.animatedExitBuilder, required this.animatedExitDuration
  });

  final T notif;
  //final void Function(T) removeNotifCallback;
  //final GlobalKey<_NotifCenterState<T>> notifCenterStateKey;
  final Widget Function(T) notifWidgetBuilder;
  final Duration notifLifespan;
  final Widget Function(Widget, Animation<double>) animatedEntryBuilder;
  final Duration animatedEntryDuration;
  final Widget Function(Widget, Animation<double>) animatedExitBuilder;
  final Duration animatedExitDuration;

  @override
  _NotifWidgetState<T> createState() => _NotifWidgetState<T>();
}

class _NotifWidgetState<T extends Notif> extends State<NotifWidget<T>> with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
    _animController = new AnimationController(vsync: this, duration: _totalNotifLifespan);
    _animController.addListener(() {setState(() {
      //print((widget.notif as LobbyNotif).userId! + ' ' + _animController.value.toString());
    });});
    _animController.addStatusListener((status) {
      print((widget.notif as LobbyNotif).userId! + ' finished animating');
      if(status == AnimationStatus.completed){
        _onAnimationCompleted();
      }
    });
    _animController.forward(from: 0);
  }

  double _proportionOfLifespan(Duration duration) => duration.inMicroseconds / _totalNotifLifespan.inMicroseconds;
  Duration get _totalNotifLifespan => widget.animatedEntryDuration + widget.notifLifespan + widget.animatedExitDuration;

  late AnimationController _animController;
  late Animation<double> entryAnimation = new CurvedAnimation(parent: _animController,
      curve: Interval(0.0, _proportionOfLifespan(widget.animatedEntryDuration)));
  late Animation<double> exitAnimation = new CurvedAnimation(parent: _animController,
      curve: Interval(_proportionOfLifespan(widget.animatedEntryDuration + widget.notifLifespan), 1.0));

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _removeMe(){
    Provider.of<_NotifCenterState>(context, listen: false).removeNotif(widget.notif);
  }

  void _onAnimationCompleted(){
    _removeMe();
  }

  // TODO: Fix dismissible bug
  Widget _buildNotifWidget() => Dismissible(
      key: UniqueKey(),
      onDismissed: (direction){
        _removeMe();
      },
      child: widget.notifWidgetBuilder(widget.notif));

  @override
  Widget build(BuildContext context) {

    // There's a really weird effect where, if multiple notifications are added, only every other one disappears.
    // i.e. If 5 are added in succession, the 1st 3rd and 5th will disappear, the 2nd and 4th will stay
    // The animation controller of the even-numbered ones somehow get interrupted and reset
    // The following line simply ensures the notification is invisible.
    // The widget still gets built, the notif item is still in the NotifCenter list, and the widget's AnimationController is not yet disposed.
    // This is not ideal, as it is unnecessary overhead.
    // TODO: Fix this so that the following line isn't necessary
    if(exitAnimation.isCompleted) {
      return EmptyWidget();
      // _removeMe();
      // return _buildNotifWidget();
    }

    Widget notifWidget = _buildNotifWidget();

    if(entryAnimation.status == AnimationStatus.forward) notifWidget = widget.animatedEntryBuilder(notifWidget, entryAnimation);
    if(exitAnimation.status == AnimationStatus.forward) notifWidget = widget.animatedExitBuilder(notifWidget, exitAnimation);

    return notifWidget;
  }
}