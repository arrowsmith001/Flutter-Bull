import 'package:flutter_bull/utilities/firebase.dart';
import 'package:flutter_bull/utilities/prefs.dart';
import 'package:flutter_bull/utilities/profile.dart';
import 'package:flutter_bull/utilities/res.dart';

// Assumes that FirebaseApp has been initialized
class ManagerCenter {

  static final ManagerCenter _instance = ManagerCenter._internal();
  factory ManagerCenter() => _instance;
  ManagerCenter._internal() {}

  ResourceManager resources = new ResourceManager();
  ImageManager profile = new ImageManager();
  PrefsManager prefs = new PrefsManager();
  DatabaseOps db = new FirebaseOps();

}