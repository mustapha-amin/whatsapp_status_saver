import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:whatsapp_status_saver/utils/extensions.dart';

class VideoPlayerWidget extends StatefulWidget {
  String? path;
  VideoPlayerWidget({this.path, super.key});

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController videoPlayerController;
  bool _opaque = true;

  @override
  void initState() {
    super.initState();
    log(widget.path!);
    videoPlayerController = VideoPlayerController.file(File(widget.path!))
      ..initialize().then(
        (_) => setState(() {}),
      );
  }

  void toggleOpacity() async {
    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      _opaque = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: videoPlayerController.value.isInitialized
            ? GestureDetector(
                onTap: () {
                  setState(() {});
                  videoPlayerController.value.isPlaying
                      ? {
                          videoPlayerController.pause(),
                          setState(() => _opaque = true)
                        }
                      : {
                          videoPlayerController.play(),
                          toggleOpacity(),
                        };
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    AspectRatio(
                      aspectRatio: videoPlayerController.value.aspectRatio,
                      child: VideoPlayer(videoPlayerController),
                    ),
                    Opacity(
                      opacity: _opaque ? 1 : 0,
                      child: Icon(
                        videoPlayerController.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                        color: Colors.grey.withOpacity(0.8),
                        size: context.screenWidth * .3,
                      ),
                    ),
                  ],
                ),
              )
            : const CircularProgressIndicator(),
      ),
    );
  }
}
