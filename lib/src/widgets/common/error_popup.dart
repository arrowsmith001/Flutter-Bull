import 'package:flutter/material.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_button.dart';

class ErrorPopup extends StatefulWidget {
  const ErrorPopup(this.message, {super.key, this.escape});

  final String message;
  final VoidCallback? escape;

  @override
  State<ErrorPopup> createState() => _ErrorPopupState();
}

class _ErrorPopupState extends State<ErrorPopup> {

  static const double outerPaddingValue = 16.0;
  static const double innerPaddingValue = 16.0;

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        const Spacer(),

        Flexible(
          flex: 2,
          child: _buildMainBody(outerPaddingValue, context)),
        
        const Spacer(),
      ],
    );
  }

  Padding _buildMainBody(double outerPaddingValue, BuildContext context) {

    return Padding(
        padding: EdgeInsets.all(outerPaddingValue),
        child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColorLight, width: 2.5),
        color: Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(16.0)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: innerPaddingValue, vertical: innerPaddingValue * 2),
            child: Center(
              child: 
            Column(
              mainAxisSize: MainAxisSize.max,
              
              children: 
            [
          
              Text("An error occured", style: Theme.of(context).textTheme.headlineMedium),
          
              Flexible(child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(child: 
                  SingleChildScrollView(
                    child: Text(widget.message, textAlign:TextAlign.center,))),
              )),
          
              SizedBox(
                height: 75,
                child: UtterBullButton(onPressed: widget.escape == null ? null : () => widget.escape!(), title: "OK")),
              
            ],)),
          )),
      );
  }
}
