import 'dart:io';
import 'dart:ui' as ui;
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:extended_image/extended_image.dart';

class AvatarCropScreen extends StatefulWidget {
  final File imageFile;

  const AvatarCropScreen({
    super.key,
    required this.imageFile,
  });

  @override
  State<AvatarCropScreen> createState() => _AvatarCropScreenState();
}

class _AvatarCropScreenState extends State<AvatarCropScreen> {
  final GlobalKey<ExtendedImageEditorState> editorKey = GlobalKey();

  Future<void> _cropImage() async {
    final state = editorKey.currentState;
    if (state == null) return;

    final Rect? cropRect = state.getCropRect();
    if (cropRect == null) return;

    // ✅ non-nullable in your version
    final Uint8List imageData = state.rawImageData;

    final codec = await ui.instantiateImageCodec(imageData);
    final frame = await codec.getNextFrame();
    final ui.Image originalImage = frame.image;

    final int left = cropRect.left.round();
    final int top = cropRect.top.round();
    final int width = cropRect.width.round();
    final int height = cropRect.height.round();

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);

    canvas.drawImageRect(
      originalImage,
      Rect.fromLTWH(
        left.toDouble(),
        top.toDouble(),
        width.toDouble(),
        height.toDouble(),
      ),
      Rect.fromLTWH(
        0,
        0,
        width.toDouble(),
        height.toDouble(),
      ),
      Paint(),
    );

    final picture = recorder.endRecording();
    final img = await picture.toImage(width, height);
    final byteData = await img.toByteData(
      format: ui.ImageByteFormat.png,
    );

    if (byteData == null) return;

    final Uint8List pngBytes = byteData.buffer.asUint8List();

    final file = await File(
      '${widget.imageFile.path}_cropped.png',
    ).writeAsBytes(pngBytes);

    if (!mounted) return;

    Navigator.pop(context, file);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Edit Avatar"),
        actions: [
          TextButton(
            onPressed: _cropImage,
            child: const Text(
              "Done",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),

      body: Stack(
        children: [
          /// IMAGE EDITOR
          ExtendedImage.file(
            widget.imageFile,
            fit: BoxFit.contain,
            mode: ExtendedImageMode.editor,
            extendedImageEditorKey: editorKey,
            initEditorConfigHandler: (state) {
              return EditorConfig(
                maxScale: 5.0,
                cropAspectRatio: 1.0,
                cropRectPadding: const EdgeInsets.all(20),
                hitTestSize: 20.0,
              );
            },
          ),

          /// DARK OVERLAY
          Container(
            color: Colors.black.withValues(alpha: 0.4),
          ),

          /// CIRCLE GUIDE (AVATAR FRAME)
          Center(
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}