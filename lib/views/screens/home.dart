import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watcher/watcher.dart';
import 'package:whatsapp_status_saver/providers/whatsapp_status_provider.dart';
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
  final directoryWatcher = DirectoryWatcher(AppConstants.WHATSAPP_PATH);

  void loadDirContents() {
    final directory = Directory(AppConstants.WHATSAPP_PATH);
    if (directory.existsSync()) {
      context.read<WhatsappStatusProvider>().whatsappStatusesPaths =
          directory.listSync().map((e) => e.path).toList();
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadDirContents();

      directoryWatcher.events.listen((event) {
        context.read<WhatsappStatusProvider>().updateStatuses(event.path);
        if (event.type == ChangeType.ADD) {
          context.read<WhatsappStatusProvider>().updateStatuses(event.path);
        } else if (event.type == ChangeType.REMOVE) {
          context
              .read<WhatsappStatusProvider>()
              .updateStatuses(event.path, isAddition: false);
        }
      });
    });
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
            ImageScreen(),
            VideoScreen(),
          ],
        ),
        // floatingActionButton: FloatingActionButton(onPressed: () {
        //   log(Provider.of<WhatsappStatusProvider>(context, listen: false)
        //       .whatsappStatusesPaths
        //       .toString());
        // }),
      ),
    );
  }
}
