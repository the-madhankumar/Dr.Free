import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class Reels extends StatefulWidget {
  @override
  _ReelsState createState() => _ReelsState();
}

class _ReelsState extends State<Reels> {
  final List<String> videoPaths = [
    // Add the paths of your locally stored videos here
    'assets/videos/final_project_R.mp4', // Update the path according to your project structure
    // Add more video paths as needed
  ];

  List<ChewieController> _chewieControllers = [];

  @override
  void initState() {
    super.initState();
    // Initialize controllers for each video
    _chewieControllers = videoPaths.map((path) {
      final VideoPlayerController videoPlayerController =
          VideoPlayerController.asset(path);
      final ChewieController chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        autoPlay: false, // Set autoPlay to false if you want to start paused
        looping: false,
      );
      // Initialize video controller and play the video
      videoPlayerController.initialize().then((_) {
        chewieController.play();
        setState(() {}); // Update the UI to reflect the video state
      });
      return chewieController;
    }).toList();
  }

  @override
  void dispose() {
    // Dispose of controllers to avoid memory leaks
    _chewieControllers.forEach((controller) {
      controller.videoPlayerController.dispose();
      controller.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reels"),
      ),
      body: ListView.builder(
        itemCount: videoPaths.length,
        itemBuilder: (context, index) {
          return _buildVideoPlayer(
              videoPaths[index], _chewieControllers[index]);
        },
      ),
    );
  }

  Widget _buildVideoPlayer(
      String videoPath, ChewieController chewieController) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 300, // Set your desired height
        child: Chewie(
          controller: chewieController,
        ),
      ),
    );
  }
}
