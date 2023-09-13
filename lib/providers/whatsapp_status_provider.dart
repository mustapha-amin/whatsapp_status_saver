import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class WhatsappStatusProvider extends ChangeNotifier {
  List<String> whatsappStatusesPaths = [];
  List<String> videoThumbnails = [];

  Future<void> _generateThumbnails(List<String> videoPaths) async {
    final directory =
        await getTemporaryDirectory(); // You can change this to your desired directory.

    videoThumbnails.addAll(await Future.wait(videoPaths.map((videoPath) async {
      final thumbnailPath = '${directory.path}/${videoPath.hashCode}.jpg';

      if (!await File(thumbnailPath).exists()) {
        await VideoThumbnail.thumbnailFile(
          thumbnailPath: thumbnailPath,
          video: videoPath,
          imageFormat: ImageFormat.JPEG,
          quality: 25,
        );
      }

      return thumbnailPath;
    })));

    notifyListeners();
  }

  void loadThumbnails() {
    _generateThumbnails(whatsappStatusesPaths
        .where((content) => content.endsWith('.mp4'))
        .toList());
  }

  Future<bool> thumbnailExists(int hashcode) async {
    final directory = await getExternalStorageDirectory();
    return File('${directory!.path}/thumbnails/$hashcode.jpg').exists();
  }

  void updateStatusesList(List<String> paths) {
    whatsappStatusesPaths = paths;
    notifyListeners();
  }
}
