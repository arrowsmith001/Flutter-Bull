import 'dart:async';
import 'dart:typed_data';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'extensions.dart';
import 'dart:ui' as ui;
import 'package:image/image.dart';

import 'gen/assets.gen.dart';

class ResourceManager{

  static final ResourceManager _instance = ResourceManager._internal();
  factory ResourceManager() => _instance;
  ResourceManager._internal();

  Stream<double> loadAllResources() async*{

    List<AssetGenImage> desiredUiImages = [];
    desiredUiImages.add(Assets.images.transparentBubble);
    desiredUiImages.add(Assets.images.transparentBullImg);
    desiredUiImages.add(Assets.images.transparentUtter);
    desiredUiImages.add(Assets.images.transparentBull);
    desiredUiImages.add(Assets.images.spiny1);
    desiredUiImages.add(Assets.images.spiny2);
    desiredUiImages.add(Assets.images.bubbleBg);

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

Future<UiImageData> loadUiImage(String assetPath) async {
  final data = await rootBundle.load(assetPath);
  final list = Uint8List.view(data.buffer);
  final completer = Completer<ui.Image>();
  ui.decodeImageFromList(list, completer.complete);
  return new UiImageData(await completer.future, assetPath);
}