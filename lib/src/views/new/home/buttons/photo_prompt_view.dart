import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/views/new/notifiers/camera_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class PhotoPromptView extends ConsumerStatefulWidget {
  const PhotoPromptView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PhotoPromptViewState();
}

class _PhotoPromptViewState extends ConsumerState<PhotoPromptView>
    with MediaDimensions {
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
        PhotoPromptButtons()
      ],
    );
  }
}

class PhotoPromptButtons extends ConsumerStatefulWidget {
  const PhotoPromptButtons(
      {super.key, this.onPressed, this.animateEntry = false});

  final VoidCallback? onPressed;
  final bool animateEntry;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PhotoPromptButtonsState();
}

class _PhotoPromptButtonsState extends ConsumerState<PhotoPromptButtons>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller =
      AnimationController(vsync: this, duration: Duration(milliseconds: 400));
  late final Animation<double> anim1 = CurvedAnimation(
          parent: controller, curve: Interval(0.0, 0.7, curve: curve))
      .drive(tween);
  late final Animation<double> anim2 = CurvedAnimation(
          parent: controller, curve: Interval(0.15, 0.85, curve: curve))
      .drive(tween);
  late final Animation<double> anim3 = CurvedAnimation(
          parent: controller, curve: Interval(0.3, 1.0, curve: curve))
      .drive(tween);

  Curve curve = Curves.elasticOut;
  Tween<double> tween = Tween(begin: 1.0, end: 0.0);
  @override
  void initState() {
    super.initState();
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _invokeOptionalCallback() {
    if (widget.onPressed != null) widget.onPressed!();
  }

  void onCameraPressed() async {
    _invokeOptionalCallback();
    await ref.read(cameraNotifierProvider.notifier).initialize();
  }

  void onUploadPressed() async {
    _invokeOptionalCallback();
    await ref.read(cameraNotifierProvider.notifier).pickImage();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final double width = constraints.biggest.width;
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
              child: AnimatedBuilder(
            animation: anim3,
            builder: (context, child) => Transform.translate(
                offset: Offset(anim3.value * width, 0), child: child),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: AspectRatio(
                aspectRatio: 1,
                child: ElevatedButton(
                    onPressed: null,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.image),
                        AutoSizeText(
                          'Gallery',
                          style: TextStyle(fontSize: 64),
                          maxLines: 1,
                        )
                      ],
                    )),
              ),
            ),
          )),
          Flexible(
              child: AnimatedBuilder(
            animation: anim2,
            builder: (context, child) => Transform.translate(
                offset: Offset(anim2.value * (width * 0.66), 0), child: child),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AspectRatio(
                aspectRatio: 1,
                child: ElevatedButton(
                    onPressed: () => onUploadPressed(),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.upload),
                        AutoSizeText(
                          'Files',
                          style: TextStyle(fontSize: 64),
                          maxLines: 1,
                        )
                      ],
                    )),
              ),
            ),
          )),
          Flexible(
              child: AnimatedBuilder(
            animation: anim1,
            builder: (context, child) => Transform.translate(
                offset: Offset(anim1.value * (width * 0.33), 0), child: child),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AspectRatio(
                aspectRatio: 1,
                child: ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.orange)),
                    onPressed: () => onCameraPressed(),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.photo_camera),
                        AutoSizeText(
                          'Camera',
                          style: TextStyle(fontSize: 64),
                          maxLines: 1,
                        )
                      ],
                    )),
              ),
            ),
          )),
        ],
      );
    });
  }
}
