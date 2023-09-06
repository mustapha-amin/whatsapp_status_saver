import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_status_saver/utils/extensions.dart';

import '../../providers/whatsapp_status_provider.dart';

class VideoScreen extends StatelessWidget {
 const VideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var whatsappStatusProvider = Provider.of<WhatsappStatusProvider>(context);
    List<String> imagePaths = whatsappStatusProvider.whatsappStatusesPaths
        .where((element) => element.endsWith('.mp4'))
        .toList();
    return GridView.builder(
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: imagePaths.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.amber,
          ),
          margin: const EdgeInsets.all(4),
          width: context.screenWidth * .5,
          height: context.screenHeight * .2,
        );
      },
    );
  }
}
