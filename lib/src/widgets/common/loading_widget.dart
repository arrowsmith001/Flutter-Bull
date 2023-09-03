import 'package:flutter/material.dart';

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({this.message, super.key});

  final String? message;

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      Spacer(),

      Flexible(child: 
      Center(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: Container(
            color: Colors.white.withOpacity(0.5),
            
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                widget.message == null ? const SizedBox.shrink() : Text(widget.message!),
                const SizedBox(
                  width: 150,
                  height: 150,
                  child: CircularProgressIndicator()),
              ],),
            )),),
      )),

      Spacer()
    ],);
  }
}
