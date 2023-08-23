import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:video_player/video_player.dart';

import '../../Constants/all_urls.dart';
import '../../Constants/sizes.dart';
import '../../Constants/theme_data.dart';
import '../../Controllers/global_controllers.dart';



class VideoApp extends StatefulWidget {
  const VideoApp({super.key, required this.video});

  final String video;

  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  late VideoPlayerController _controller;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network('$videoUrl${widget.video}')
      ..initialize().then((_) {
        setState(() {});
      });

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {});
    });
  }

  String formatDuration(Duration duration) {
    final remainingDuration =
        _controller.value.duration - _controller.value.position;
    final minutes =
    remainingDuration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds =
    remainingDuration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  double calculateSliderValue() {
    if (_controller.value.duration.inMilliseconds > 0) {
      return _controller.value.position.inMilliseconds.toDouble() /
          _controller.value.duration.inMilliseconds.toDouble();
    }
    return 0.0;
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent,),
      extendBodyBehindAppBar: true,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            children: [
              _controller.value.isInitialized
                  ? SizedBox(
                height: screenHeight(context) / 1.2,
                width: screenWidth(context),
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
              )
                  : Container(
                height: screenHeight(context) / 1.2,
                width: screenWidth(context),
                color: themeController.currentTheme.value.cardColor,
                child: Center(
                  child: LoadingAnimationWidget.threeArchedCircle(
                    color: primaryColor,
                    size: 50,
                  ),
                ),
              ),
              _controller.value.isBuffering
                  ? const SizedBox()
                  : _controller.value.isPlaying
                  ? Container(
                height: screenHeight(context) / 1.2,
                width: screenWidth(context),
                color: Colors.transparent,
                child: Center(
                  child: InkWell(
                    onTap: () {
                      _controller.pause();
                    },
                    child: const SizedBox(
                      height: 120,
                      width: 120,
                    ),
                  ),
                ),
              )
                  : Container(
                height: screenHeight(context) / 1.2,
                width: screenWidth(context),
                color: Colors.black38,
                child: Center(
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        if (_controller.value.isPlaying) {
                          _controller.pause();
                        } else {
                          _controller.play();
                        }
                      });
                    },
                    icon: Icon(
                      Icons.play_circle,
                      color: themeController
                          .currentTheme.value.cardColor,
                      size: 54,
                    ),
                  ),
                ),
              ),
              _controller.value.isBuffering
                  ? Container(
                height: screenHeight(context) / 1.2,
                width: screenWidth(context),
                color: Colors.transparent,
                child: Center(
                  child: LoadingAnimationWidget.threeArchedCircle(
                    color: primaryColor,
                    size: 50,
                  ),
                ),
              )
                  : const SizedBox(),
            ],
          ),
          const SizedBox(height: 16.0),
          Slider(
            value: calculateSliderValue(),
            activeColor: primaryColor,
            inactiveColor: themeController.currentTheme.value.cardColor,
            onChanged: (newValue) {
              final newDuration = Duration(
                milliseconds:
                (newValue * _controller.value.duration.inMilliseconds)
                    .round(),
              );
              _controller.seekTo(newDuration);
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  formatDuration(_controller.value.duration),
                  style: themeController.currentTheme.value.textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}