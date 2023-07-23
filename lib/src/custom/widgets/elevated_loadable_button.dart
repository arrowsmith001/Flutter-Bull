import 'package:flutter/material.dart';

class ElevatedLoadableButton extends StatelessWidget {

  const ElevatedLoadableButton({super.key, this.isLoading = false, this.onPressed, this.label});
  final bool isLoading;
  final Function()? onPressed;
  final String? label;

  static const double circularProgressIndicatorSize = 20.0;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: isLoading ? null : onPressed, 
        child: Stack(
          alignment: Alignment.center,
          children: [
          Visibility(maintainState: true, maintainSize: true, maintainAnimation: true,
            visible: isLoading,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: circularProgressIndicatorSize, width: circularProgressIndicatorSize,
                child: CircularProgressIndicator(value: isLoading ? null : 0)),
            )),
          Visibility(maintainState: true, maintainSize: true, maintainAnimation: true,
            visible: !isLoading,
            child: Padding(padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 32.0), child: Text(label ?? ''))),
          
        ],));
  }
}