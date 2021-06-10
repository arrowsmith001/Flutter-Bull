import 'dart:async';
import 'dart:typed_data';
import 'dart:math' as math;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import '../extensions.dart';
import 'dart:ui' as ui;
import 'package:image/image.dart';

import '../gen/assets.gen.dart';

class ResourceManager{

  static final ResourceManager _instance = ResourceManager._internal();
  factory ResourceManager() => _instance;
  ResourceManager._internal();

  Stream<double> loadAllUiImages() async* {

    // IMAGES
    List<AssetGenImage> desiredUiImages = [];
    desiredUiImages.add(Assets.images.transparentBubble);
    desiredUiImages.add(Assets.images.transparentBullImg);
    desiredUiImages.add(Assets.images.transparentUtter);
    desiredUiImages.add(Assets.images.transparentBull);
    desiredUiImages.add(Assets.images.spiny1);
    desiredUiImages.add(Assets.images.spiny2);
    desiredUiImages.add(Assets.images.bubbleBg);
    desiredUiImages.add(Assets.images.clock);
    desiredUiImages.add(Assets.images.clockBg);
    desiredUiImages.add(Assets.images.angel);
    desiredUiImages.add(Assets.images.angels);
    desiredUiImages.add(Assets.images.iconTick);

    List<Future<UiImageData>> futures = [];
    for(AssetGenImage img in desiredUiImages){
      futures.add(loadUiImage(img.path));
    }

    int numberToProcess = futures.length;
    int numberProcessed = 0;

    for(Future future in futures){

      UiImageData uiImgData = await future;
      uiImageMap.addAll({uiImgData.path : uiImgData.image});

      numberProcessed++;
      yield numberProcessed.toDouble() / numberToProcess.toDouble();
    }

    yield 1.0;

  }

  var uiImageMap = new Map<String, ui.Image>();

  ui.Image getUiImage(var v){
    try{
      if(v is String) return uiImageMap[v]!;
      if(v is AssetGenImage) return uiImageMap[v.path]!;
      throw ArgumentError('Please supply an AssetGenImage or String to this method.');
    }catch(e){
      throw new Exception(e.toString() + "\nDid you forget to add the required resource to the resource manager?");
    }
  }

  int getResourceNumber() => uiImageMap.length;

}

class UiImageData{
  UiImageData(this.image, this.path);
  ui.Image image;
  String path;
}

class FirestoreData {
  //
  // void addField(String collectionName, String docName, String field, [dynamic value]){
  //   firestorePathToValues.addAll(
  //       {[collectionName, docName].join('/') : {}
  //   });
  // }
  //
  // dynamic getValue(String path, [String field = 'content']){
  //   if(!firestorePathToValues.containsKey(path)) throw new Exception('Firestore path not found. Did you import it in ResourceManager?');
  //   var value = firestorePathToValues[path]![field];
  //   if(value == null) throw new Exception('Firestore value not found. Did you import it in ResourceManager?');
  //   return value;
  // }
  //
  // Future<void> fetch() async{
  //   for(String path in firestorePathToValues.keys)
  //     {
  //       List<String> pathSplit = path.split('/');
  //       String collectionName = pathSplit[0];
  //       String docName = pathSplit[1];
  //
  //       var snap = await firestore.collection(collectionName).doc(docName).get();
  //       dynamic value = snap.data();
  //       firestorePathToValues[path] = value;
  //     }
  // }
  //
  // Map<String,Map<String,dynamic>> firestorePathToValues = {};
}

Future<UiImageData> loadUiImage(String assetPath) async {
  final data = await rootBundle.load(assetPath);
  final list = Uint8List.view(data.buffer);
  final completer = Completer<ui.Image>();
  ui.decodeImageFromList(list, completer.complete);
  return new UiImageData(await completer.future, assetPath);
}


class MyFunctions{
  static getRectFromUiImage(ui.Image image) => new Rect.fromLTRB(0,0,image.width.toDouble(),image.height.toDouble());
}