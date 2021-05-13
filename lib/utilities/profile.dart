import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bull/utilities/prefs.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:prefs/prefs.dart';
import 'package:uuid/uuid.dart';

class ProfileManager{

  static final ProfileManager _instance = ProfileManager._internal();
  factory ProfileManager() => _instance;
  ProfileManager._internal();

  static const String PROFILE_IMAGE_PATH = 'profileImagePath';
  static const String PROFILE_NAME = 'profileName';

  Profile profile = Profile();

  cacheImageFile(File file) async {
  }

  getProfileImage() => profile.image;
  getProfileName() => profile.name;

  Future<bool> loadProfileFromPreferences() async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? imagePath = prefs.getString(PROFILE_IMAGE_PATH);
    String? name = prefs.getString(PROFILE_NAME);

    Image? image;
    if(imagePath != null)
      {
        File file = File(imagePath);
        if(await file.exists())
          {
            image = Image.file(file);
          }
      }

    profile.image = image;
    profile.name = name;

    return (profile.image != null && profile.name != null);
  }

  Future<Image?> pickImage(ImagePicker picker, ImageSource source) async {

    // Pick files
    final pickedFile = await picker.getImage(source: source);
    if(pickedFile == null) return null;

    // Get application directory
    Directory tempDir = await getApplicationDocumentsDirectory();
    String tempPath = tempDir.path;

    // Get picked file
    File file = new File(pickedFile.path);

    // Cache the file
    Uuid uuid = Uuid();
    String fileExt = uuid.v4() + '.' + file.path.split('.').last;
    String newPath = tempPath + '/profile/' + fileExt;
    File cachedFile = File(newPath);
    await cachedFile.create(recursive: true);
    cachedFile = await file.copy(newPath);

    // Save cached file path to preferences
    PrefsManager prefs = PrefsManager();
    await prefs.setString(PROFILE_IMAGE_PATH, newPath);

    // var storage = FirebaseStorage.instance;
    // var task = storage.ref("images/profile").child(fileExt).putFile(cachedFile);
    // TaskSnapshot snap = await task;

    // Return image
    profile.image = Image.file(cachedFile);
    return profile.image;
  }

  Future<String> setName(String text) async {
    PrefsManager prefs = new PrefsManager();

    await prefs.setString(PROFILE_NAME, text);
    this.profile.name = text;
    return text;
  }
}

class Profile{

  String? name;
  Image? image;

  Profile({this.name, this.image});



}