import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_status_saver/utils/extensions.dart';
import 'package:whatsapp_status_saver/utils/navigation.dart';
import 'package:whatsapp_status_saver/views/screens/video_player_screen.dart';
import 'package:whatsapp_status_saver/views/widgets/status_image.dart';

import '../../providers/whatsapp_status_provider.dart';

class VideoScreen extends StatelessWidget {
  const VideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var whatsappStatusProvider = Provider.of<WhatsappStatusProvider>(context);
    List<String> videoThmbnails = whatsappStatusProvider.videoThumbnails;
    List<String> vidoePaths = whatsappStatusProvider.whatsappStatusesPaths
        .where((path) => path.endsWith('.mp4'))
        .toList();
    return GridView.builder(
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: videoThmbnails.length,
      itemBuilder: (context, index) {
        return Stack(
          alignment: Alignment.center,
          children: [
            StatusImage(imagePath: videoThmbnails[index].toString()),
            IconButton(
              icon: const Icon(Icons.play_arrow),
              color: Colors.white.withOpacity(0.5),
              iconSize: 80,
              onPressed: () {
                navigateTo(
                  context,
                  VideoPlayerScreen(
                    paths: vidoePaths,
                    index: index,
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
