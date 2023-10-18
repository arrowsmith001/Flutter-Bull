
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PhotoPromptView extends ConsumerStatefulWidget {
  const PhotoPromptView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PhotoPromptViewState();
}

class _PhotoPromptViewState extends ConsumerState<PhotoPromptView> with MediaDimensions {


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AutoSizeText(
          'It\' more fun with a photo!',
          maxLines: 1,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineMedium,
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AspectRatio(aspectRatio: 1, child: ElevatedButton(onPressed: () {  },
              child:  Icon(Icons.image)),),
            )),
            Flexible(child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AspectRatio(aspectRatio: 1, child: ElevatedButton(onPressed: () {  },
              child:  Icon(Icons.upload)),),
            )),
            Flexible(child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AspectRatio(aspectRatio: 1, child: ElevatedButton(onPressed: () {  },
              child:  Icon(Icons.photo_camera)),),
            )),
       
          ],
        )
        
      ],
    );
  }
}