import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_status_saver/providers/whatsapp_status_provider.dart';

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
      body: PageView(
        controller: controller,
        children: [
          ...whatsappStatusProvider.whatsappStatusesPaths
              .where((content) => content.endsWith('.jpg'))
              .map(
                (e) => Container(
                  color: Colors.black,
                  child: Image.file(File(e)),
                ),
              )
        ],
      ),
    );
  }
}
