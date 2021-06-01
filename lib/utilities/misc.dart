

class Utils {

  static void printError(Object thisClass, String methodName, e) {
    print('Error: ' + thisClass.runtimeType.toString() + '.${methodName}: ' + e.toString());
  }

}