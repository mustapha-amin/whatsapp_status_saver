import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_status_saver/utils/extensions.dart';
import 'package:whatsapp_status_saver/utils/navigation.dart';
import 'package:whatsapp_status_saver/views/screens/image_viewer.dart';

import '../../providers/whatsapp_status_provider.dart';
import '../widgets/status_image.dart';

class ImageScreen extends StatelessWidget {
  const ImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var whatsappStatusProvider = Provider.of<WhatsappStatusProvider>(context);
    List<String> imagePaths = whatsappStatusProvider.whatsappStatusesPaths
        .where((element) => element.endsWith('.jpg'))
        .toList();
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: imagePaths.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            navigateTo(context, ImageViewer(index: index));
          },
          child: StatusImage(imagePath: imagePaths[index]),
        );
      },
    );
  }
}