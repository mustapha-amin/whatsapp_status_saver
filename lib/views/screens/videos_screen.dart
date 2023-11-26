import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_status_saver/utils/navigation.dart';
import 'package:whatsapp_status_saver/views/screens/video_player_screen.dart';
import 'package:whatsapp_status_saver/views/widgets/status_image.dart';

import '../../providers/whatsapp_status_provider.dart';
import '../../utils/constants.dart';

class VideoScreen extends StatelessWidget {
  const VideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var whatsappStatusProvider = Provider.of<WhatsappStatusProvider>(context);
    Set<String> videoThmbnails = whatsappStatusProvider.videoThumbnails;
    List<String> vidoePaths = whatsappStatusProvider.whatsappStatusesPaths
        .where((path) => path.endsWith('mp4'))
        .toList();
    return GridView.builder(
      padding: const EdgeInsets.only(left: 5),
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: videoThmbnails.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              StatusImage(
                  imagePath: videoThmbnails.elementAt(index).toString()),
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
              Positioned(
                bottom: 8,
                right: 10,
                child: InkWell(
                  onTap: () {
                    whatsappStatusProvider.saveStatus(
                      context,
                      vidoePaths[index],
                      false,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: AppConstants.appColor,
                        shape: BoxShape.circle,
                      ),
                      width: 35,
                      height: 35,
                      child: const Icon(
                        Icons.download,
                        size: 23,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
