import 'dart:io';

import 'package:flutter/material.dart';
import 'package:whatsapp_status_saver/utils/extensions.dart';

class StatusImage extends StatelessWidget {
  const StatusImage({
    super.key,
    required this.imagePath,
  });

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          filterQuality: FilterQuality.high,
          fit: BoxFit.cover,
          image: FileImage(
            File(imagePath),
          ),
        ),
      ),
      margin: const EdgeInsets.all(4),
      width: context.screenWidth * .5,
      height: context.screenHeight * .2,
    );
  }
}
