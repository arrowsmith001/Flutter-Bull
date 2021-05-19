import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bull/classes/firebase.dart';
import 'package:flutter_bull/utilities/firebase.dart';
import 'package:flutter_bull/utilities/prefs.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:prefs/prefs.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class ImageManager {

  static final ImageManager _instance = ImageManager._internal();

  factory ImageManager() => _instance;
  ImageManager._internal();

  Profile profile = Profile();

  cacheImageFile(File file) async {
  }

  // getProfileImage() => profile.image;
  // getProfileName() => profile.name;
  // getImagePath() => profile.imagePath;


  Future<Image?> pickImage(BuildContext context, ImagePicker picker, ImageSource source) async {

    // Pick files
    final pickedFile = await picker.getImage(source: source);
    if(pickedFile == null) return null;

    // Get application directory
    // Directory tempDir = await getApplicationDocumentsDirectory();
    // String tempPath = tempDir.path;

    // Get picked file
    File file = new File(pickedFile.path);
    if(!await file.exists())
      {
        print('File ' + pickedFile.path + ' does not appear to exist');
        return null;
      }

    // Cache the file
    // Uuid uuid = Uuid();
    // String fileExt = uuid.v4() + '.' + file.path.split('.').last;
    // String newPath = tempPath + '/profile/' + fileExt;
    // File cachedFile = File(newPath);
    // await cachedFile.create(recursive: true);
    // cachedFile = await file.copy(newPath);

    try{
      //await Provider.of<DatabaseOps>(context, listen: false).uploadProfileImage(file);
    }
    catch(e){print(e.toString());}

    // Return image
    // profile.image = Image.file(cachedFile);
    // profile.imagePath = newPath;
    // return profile.image;
  }


}
