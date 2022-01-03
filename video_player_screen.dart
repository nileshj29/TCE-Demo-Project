import 'package:flutter/material.dart';
import 'package:flutter_nj_app/module/sample_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_nj_app/screens/quiz_screen.dart';

// class VideoPlayerScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold();
//   }
// }

class VideoPlayerScreen extends StatefulWidget {
  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _videoPlayerController = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
      ..initialize().then((_) {
        setState(() {
          _videoPlayerController.value.isPlaying
              ? _videoPlayerController.pause()
              : _videoPlayerController.play();
          _videoPlayerController.addListener(checkVideo);
          // _videoPlayerController = VideoProgressIndicator(
          //     _videoPlayerController,
          //     allowScrubbing: true) as VideoPlayerController;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Demo',
      home: Scaffold(
        body: Center(
          child: _videoPlayerController.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _videoPlayerController.value.aspectRatio,
                  child: VideoPlayer(_videoPlayerController),
                )
              : Container(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _videoPlayerController.value.isPlaying
                  ? _videoPlayerController.pause()
                  : _videoPlayerController.play();
            });
          },
          child: Icon(
            _videoPlayerController.value.isPlaying
                ? Icons.pause
                : Icons.play_arrow,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
  }

  void checkVideo() {
    // if (_videoPlayerController.value.position ==
    //     Duration(seconds: 0, minutes: 0, hours: 0)) {
    // }

    if (_videoPlayerController.value.position ==
        _videoPlayerController.value.duration) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => QuizScreen()));
    }
  }
}
