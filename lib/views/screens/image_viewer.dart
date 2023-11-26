import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_status_saver/providers/whatsapp_status_provider.dart';
import 'package:whatsapp_status_saver/utils/spacings.dart';
import 'package:whatsapp_status_saver/utils/textstyle.dart';
import '/utils/extensions.dart';

class ImageViewer extends StatefulWidget {
  int index;
  List<String> paths;
  ImageViewer({required this.index, required this.paths, super.key});

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
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          SizedBox(
            height: context.screenHeight * 0.75,
            child: PageView(
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
                            child: Image.file(
                              File(e),
                              width: context.screenWidth,
                            ),
                          ),
                        ),
                      ),
                    )
              ],
            ),
          ),
          addSpacing(70, isVertical: false),
          IconButton(
            iconSize: 30,
            color: Colors.white,
            onPressed: () {
              whatsappStatusProvider.saveStatus(
                context,
                widget.paths[widget.index],
                true,
              );
            },
            icon: Column(
              children: [
                const Icon(
                  Icons.download_outlined,
                ),
                Text(
                  "Download",
                  style: kTextStyle(14, color: Colors.white),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
