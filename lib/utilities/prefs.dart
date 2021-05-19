import 'package:prefs/prefs.dart';

class PrefsManager {

  static final PrefsManager _instance = PrefsManager._internal();
  factory PrefsManager() => _instance;
  PrefsManager._internal() {}

  Future<void> initializePrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  late SharedPreferences _prefs;

  bool isInitialized() => this._prefs != null;

  bool? getBool(String key){
    if(!isInitialized()) throw new Exception('Initialize prefs instance first.');
    return _prefs.getBool(key);
  }

  String? getString(String key){
    if(!isInitialized()) throw new Exception('Initialize prefs instance first.');
    return _prefs.getString(key);
  }

  Future<bool> setBool(String key, bool value) async{
    if(!isInitialized()) throw new Exception('Initialize prefs instance first.');
    return await _prefs.setBool(key, value);
  }

  Future<bool> setString(String key, String value) async{
    if(!isInitialized()) throw new Exception('Initialize prefs instance first.');
    return await _prefs.setString(key, value);
  }

  Future<bool> clear() async {
    return await _prefs.clear();
  }

}