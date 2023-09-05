import 'dart:io';

import 'package:flutter/material.dart';
import 'package:whatsapp_status_saver/utils/extensions.dart';

class ImageScreen extends StatelessWidget {
  List<FileSystemEntity>? contents;
  ImageScreen({super.key, this.contents});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: contents!.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              filterQuality: FilterQuality.high,
              fit: BoxFit.cover,
              image: FileImage(
                File(contents![index].path),
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
