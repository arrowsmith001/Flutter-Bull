import 'dart:typed_data';
import 'dart:ui';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
//import 'package:path_provider/path_provider.dart';

abstract class ImageStorageService {
  Future<void> uploadImage(Uint8List image, String path);

  Future<Uint8List> downloadImage(String path);
}

class FirebaseImageStorageService implements ImageStorageService {
  FirebaseStorage get storage => FirebaseStorage.instance;

  @override
  Future<Uint8List> downloadImage(String path) async {
    final ref = storage.ref(path);
    final data = await ref.getData();
    return data!;

    //frameBuilder:(context, child, frame, wasSynchronouslyLoaded) => CircularProgressIndicator(),
  }

  @override
  Future<void> uploadImage(Uint8List data, String path) async {
    await storage.ref(path).putData(data);
  }
}
