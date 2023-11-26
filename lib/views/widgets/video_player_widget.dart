import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:whatsapp_status_saver/providers/whatsapp_status_provider.dart';
import 'package:whatsapp_status_saver/utils/extensions.dart';
import 'package:whatsapp_status_saver/utils/textstyle.dart';
import 'package:provider/provider.dart';

class VideoPlayerWidget extends StatefulWidget {
  String? path;
  VideoPlayerWidget({this.path, super.key});

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController videoPlayerController;
  bool _opaque = false;
  double _sliderVal = 0;
  int _currentDuration = 0;
  int _totalDuration = 0;

  @override
  void initState() {
    super.initState();
    log(widget.path!);
    videoPlayerController = VideoPlayerController.file(File(widget.path!))
      ..initialize().then((_) => setState(() {}))
      ..addListener(() {
        setState(() {
          _currentDuration =
              videoPlayerController.value.position.inSeconds.toInt();
          _sliderVal = _currentDuration.toDouble();
          _totalDuration = videoPlayerController.value.duration.inSeconds;
        });
      })
      ..play();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: videoPlayerController.value.isInitialized
            ? GestureDetector(
                onTap: () {
                  videoPlayerController.value.isPlaying
                      ? {
                          setState(() {
                            _opaque = true;
                          }),
                          videoPlayerController.pause(),
                        }
                      : {
                          setState(() {
                            _opaque = false;
                          }),
                          videoPlayerController.play(),
                        };
                },
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    AspectRatio(
                      aspectRatio: videoPlayerController.value.aspectRatio,
                      child: VideoPlayer(videoPlayerController),
                    ),
                    AnimatedOpacity(
                      opacity: !videoPlayerController.value.isPlaying && _opaque
                          ? 1
                          : 0,
                      duration: const Duration(milliseconds: 500),
                      child: Icon(
                        videoPlayerController.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                        color: Colors.grey.withOpacity(0.8),
                        size: context.screenWidth * .3,
                      ),
                    ),
                    Positioned(
                      bottom: 50,
                      right: 5,
                      child: IconButton.filledTonal(
                        color: Colors.black,
                        onPressed: () {
                          context
                              .read<WhatsappStatusProvider>()
                              .saveStatus(context, widget.path!);
                        },
                        icon: const Icon(Icons.download_outlined),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  _currentDuration <= 9
                                      ? "0:0$_currentDuration"
                                      : "0:$_currentDuration",
                                  style: kTextStyle(
                                    15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: context.screenWidth * 0.8,
                                  child: SliderTheme(
                                    data: SliderTheme.of(context).copyWith(
                                      trackHeight: 4,
                                      thumbShape: const RoundSliderThumbShape(
                                        enabledThumbRadius: 6,
                                      ),
                                    ),
                                    child: Slider(
                                        inactiveColor: Colors.grey,
                                        activeColor: Colors.white,
                                        min: 0,
                                        max: videoPlayerController
                                            .value.duration.inSeconds
                                            .toDouble(),
                                        value: _sliderVal,
                                        onChanged: (newPosition) {
                                          setState(() async {
                                            videoPlayerController.seekTo(
                                              Duration(
                                                seconds: newPosition.toInt(),
                                              ),
                                            );
                                          });
                                        }),
                                  ),
                                ),
                                Text(
                                  _totalDuration <= 9
                                      ? "0:0$_totalDuration"
                                      : "0:$_totalDuration",
                                  style: kTextStyle(
                                    15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
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
