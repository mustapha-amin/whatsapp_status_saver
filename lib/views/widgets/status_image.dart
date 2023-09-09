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
        Positioned(
          bottom: 3,
          right: 3,
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Row(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: AppConstants.appColor,
                    shape: BoxShape.circle,
                  ),
                  width: 30,
                  height: 30,
                  child: const Icon(
                    Icons.share,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
                addSpacing(5, isVertical: false),
                Container(
                  decoration: const BoxDecoration(
                    color: AppConstants.appColor,
                    shape: BoxShape.circle,
                  ),
                  width: 30,
                  height: 30,
                  child: const Icon(
                    Icons.download,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
