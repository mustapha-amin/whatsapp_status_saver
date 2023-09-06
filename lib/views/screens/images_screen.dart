import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_status_saver/utils/extensions.dart';

import '../../providers/whatsapp_status_provider.dart';

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
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              filterQuality: FilterQuality.high,
              fit: BoxFit.cover,
              image: FileImage(
                File(imagePaths[index]),
              ),
            ),
          ),
          margin: const EdgeInsets.all(4),
          width: context.screenWidth * .5,
          height: context.screenHeight * .2,
        );
      },
    );
  }
}
