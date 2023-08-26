import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:logger/logger.dart';
//import 'package:path_provider/path_provider.dart';

abstract class ImageStorageService {
  Future<void> uploadImage(Uint8List image, String path);

  Future<Uint8List> downloadImage(String path);
}

class FirebaseImageStorageService implements ImageStorageService {
  FirebaseStorage get storage => FirebaseStorage.instance;

  // TODO: Make caching system more sophisticated
  Map<String, Uint8List> cachedImages = {};

  @override
  Future<Uint8List> downloadImage(String path) async {
    if (cachedImages.containsKey(path)) {
      return cachedImages[path]!;
    }

    Logger().d('attempting image download at $path at ${DateTime.now()}');
    final ref = storage.ref(path);
    final data = await ref.getData();

    Logger().d('downloaded image at $path at ${DateTime.now()}');

    cachedImages[path] = data!;
    return data;

    //frameBuilder:(context, child, frame, wasSynchronouslyLoaded) => CircularProgressIndicator(),
  }

  @override
  Future<void> uploadImage(Uint8List data, String path) async {
    final ref = storage.ref(path);
    await ref.putData(
        data,
        SettableMetadata(
            cacheControl: 'public, max-age=${60 * 60 * 1}, s-maxage=600'));
  }
}
