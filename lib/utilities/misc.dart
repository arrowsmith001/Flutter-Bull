
import 'package:flutter/material.dart';

class Utils {

  static int msNow = DateTime.now().millisecondsSinceEpoch;

  static void printError(Object thisClass, String methodName, e) {
    print('Error: ' + thisClass.runtimeType.toString() + '.${methodName}: ' + e.toString());
  }

  static double howLongIsThisName(String name){
    int n = name.length;
    const int lowerBound = 3;
    const int upperBound = 8;
    if(n <= lowerBound) return 0.0;
    if(n > upperBound) return 1.0;
    return (n - lowerBound).toDouble() / (upperBound - lowerBound);
  }

  static void printInitializationError(Object e, String thisPageName) {
    print('Error initializing ${thisPageName}: ' + e.toString());
  }

}
