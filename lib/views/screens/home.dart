import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watcher/watcher.dart';
import 'package:whatsapp_status_saver/providers/whatsapp_status_provider.dart';
import 'package:whatsapp_status_saver/utils/constants.dart';
import 'package:whatsapp_status_saver/views/screens/images_screen.dart';
import 'package:whatsapp_status_saver/views/screens/videos_screen.dart';
import '../../utils/textstyle.dart';
import '../widgets/drawer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final directoryWatcher = DirectoryWatcher(AppConstants.WHATSAPP_PATH);
  final directory = Directory(AppConstants.WHATSAPP_PATH);

  void loadDirContents() {
    if (directory.existsSync()) {
      final directoryContentsPaths =
          directory.listSync().map((e) => e.path).toList();
      context
          .read<WhatsappStatusProvider>()
          .updateStatusesList(directoryContentsPaths);
      context.read<WhatsappStatusProvider>().loadThumbnails();
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadDirContents();
      directoryWatcher.events.listen((event) {
        if (event.type == ChangeType.ADD || event.type == ChangeType.REMOVE) {
          loadDirContents();
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //var prov = Provider.of<WhatsappStatusProvider>(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey[400],
        appBar: AppBar(
          title: Text(
            "Whatsapp status saver",
            style: kTextStyle(20),
          ),
          bottom: TabBar(
            dividerColor: Colors.grey[600],
            indicatorColor: AppConstants.appColor,
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: AppConstants.appColor,
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
        body: const TabBarView(
          children: [
            ImageScreen(),
            VideoScreen(),
          ],
        ),
      ),
    );
  }
}
