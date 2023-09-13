import 'package:flutter/material.dart';

import '../widgets/video_player_widget.dart';

class VideoPlayerScreen extends StatefulWidget {
  List<String>? paths;
  int? index;
  VideoPlayerScreen({this.paths, this.index, super.key});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late PageController pageController;
  int? currentIndex;

  @override
  void initState() {
    currentIndex = widget.index;
    pageController = PageController(initialPage: currentIndex!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        onPageChanged: (newIndex) {
          setState(() {
            currentIndex = newIndex;
          });
        },
        controller: pageController,
        children: [
          ...widget.paths!.map((url) => VideoPlayerWidget(path: url)),
        ],
      ),
    );
  }
}
