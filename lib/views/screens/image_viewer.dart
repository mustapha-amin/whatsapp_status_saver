import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_status_saver/providers/whatsapp_status_provider.dart';
import 'package:whatsapp_status_saver/utils/spacings.dart';
import 'package:whatsapp_status_saver/utils/textstyle.dart';

class ImageViewer extends StatefulWidget {
  int index;
  ImageViewer({required this.index, super.key});

  @override
  State<ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  late PageController controller;

  @override
  void initState() {
    controller = PageController(
      initialPage: widget.index,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var whatsappStatusProvider =
        Provider.of<WhatsappStatusProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          PageView(
            controller: controller,
            children: [
              ...whatsappStatusProvider.whatsappStatusesPaths
                  .where((content) => content.endsWith('.jpg'))
                  .map(
                    (e) => Container(
                      color: Colors.black,
                      child: Hero(
                        tag: e,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: Image.file(File(e)),
                        ),
                      ),
                    ),
                  )
            ],
          ),
          Positioned(
            bottom: 5,
            child: Row(
              children: [
                Column(
                  children: [
                    IconButton(
                      iconSize: 30,
                      color: Colors.white,
                      onPressed: () {},
                      icon: Icon(Icons.share_outlined),
                    ),
                    Text(
                      "Share",
                      style: kTextStyle(15, color: Colors.white),
                    ),
                  ],
                ),
                addSpacing(70, isVertical: false),
                Column(
                  children: [
                    IconButton(
                      iconSize: 30,
                      color: Colors.white,
                      onPressed: () {},
                      icon: Icon(Icons.download_outlined),
                    ),
                    Text(
                      "Download",
                      style: kTextStyle(14, color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
