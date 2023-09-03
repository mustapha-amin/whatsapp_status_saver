import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:whatsapp_status_saver/utils/constants.dart';
import 'package:whatsapp_status_saver/views/screens/images_screen.dart';
import 'package:whatsapp_status_saver/views/screens/videos_screen.dart';

import '../widgets/drawer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  List<FileSystemEntity> contents = [];
  Directory? directory;

  Future<void> listDircontents() async {
    directory = Directory(AppConstants.WHATSAPP_PATH);
    if (directory!.existsSync()) {
      setState(() {
        contents = directory!.listSync();
      });
      log(directory!.listSync().toString());
    }
  }

  fetchContents() async {}

  @override
  void initState() {
    super.initState();
    listDircontents();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Whatsapp status saver"),
          bottom: TabBar(
            dividerColor: Colors.grey[600],
            indicatorColor: AppConstants.appColor,
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: Colors.amber[900],
            tabs: const [
              Tab(
                icon: Icon(Icons.image, color: Colors.black),
                text: "Images",
              ),
              Tab(
                icon: Icon(Icons.video_collection_rounded, color: Colors.black),
                text: "Videos",
              ),
            ],
          ),
        ),
        drawer: const AppDrawer(),
        body: TabBarView(
          children: [
            ImageScreen(
              contents: contents
                  .where((content) => content.path.endsWith('.jpg'))
                  .toList(growable: false),
            ),
            VideoScreen(
              contents: contents
                  .where((content) => content.path.endsWith('.mp4'))
                  .toList(growable: false),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: listDircontents,
        ),
      ),
    );
  }
}
