import 'dart:io';

import 'package:flutter/material.dart';
import 'package:whatsapp_status_saver/utils/constants.dart';
import 'package:whatsapp_status_saver/utils/extensions.dart';
import 'package:whatsapp_status_saver/utils/spacings.dart';

class StatusImage extends StatelessWidget {
  const StatusImage({
    super.key,
    required this.imagePath,
  });

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Hero(
          tag: imagePath,
          child: Container(
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
          ),
        ),
      ],
    );
  }
}
