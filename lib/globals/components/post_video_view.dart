import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

// ignore: must_be_immutable
class VideoPostComponent extends StatefulWidget {
  final String url;
  const VideoPostComponent({Key? key, required this.url}) : super(key: key);

  @override
  State<VideoPostComponent> createState() => _VideoPostComponentState();
}

class _VideoPostComponentState extends State<VideoPostComponent> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        setState(() {});
      })
      ..setLooping(true);
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: ObjectKey(_controller),
      onVisibilityChanged: (visibility) {
        if (visibility.visibleFraction < 0.5 && mounted) {
          _controller.pause();
        } else if (visibility.visibleFraction > 0.9 && mounted) {
          _controller.play();
          setState(() {});
        }
      },
      child: GestureDetector(
        onTap: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Container(
          color: Colors.white,
          height: double.infinity,
          width: double.infinity,
          child: Center(
            child: _controller.value.isInitialized
                ? Stack(
                    alignment: Alignment.center,
                    children: [
                      AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller)),
                      if (!_controller.value.isPlaying)
                        SizedBox(
                          height: double.infinity,
                          width: double.infinity,
                          child: Center(
                            child: Image.asset(
                              'assets/images/ic_play.png',
                              color: Colors.black87,
                              height: 60,
                            ),
                          ),
                        )
                    ],
                  )
                : Container(),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
