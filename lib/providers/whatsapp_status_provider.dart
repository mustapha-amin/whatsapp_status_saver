// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:whatsapp_status_saver/utils/snackbar.dart';

class WhatsappStatusProvider extends ChangeNotifier {
  List<String> whatsappStatusesPaths = [];
  Set<String> videoThumbnails = {};

  Future<void> _generateThumbnails(List<String> videoPaths) async {
    final directory = await getTemporaryDirectory();

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
        .where((content) => content.endsWith('mp4'))
        .toList());
  }

  void updateStatusesList(List<String> paths) {
    whatsappStatusesPaths = paths;
    notifyListeners();
  }

  void saveStatus(BuildContext context, String path, [bool? isImage]) async {
    isImage ??= false;
    try {
      isImage
          ? await GallerySaver.saveImage(path, albumName: "Whatsapp statuses")
          : await GallerySaver.saveVideo(
              path,
              albumName: "Whatsapp statuses",
            );
      displaySnackBar(context, "Downloaded");
    } catch (e) {
      displaySnackBar(context, "An error occured");
    }
  }
}
