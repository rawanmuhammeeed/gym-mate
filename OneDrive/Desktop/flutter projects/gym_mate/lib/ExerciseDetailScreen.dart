import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class ExerciseDetailScreen extends StatefulWidget {
  final String name;
  final int sets;
  final int reps;
  final int weight;
  final String videoPath;
  final String description;

  const ExerciseDetailScreen({
    super.key,
    required this.name,
    required this.sets,
    required this.reps,
    required this.weight,
    required this.videoPath,
    required this.description,
  });

  @override
  _ExerciseDetailScreenState createState() => _ExerciseDetailScreenState();
}

class _ExerciseDetailScreenState extends State<ExerciseDetailScreen> {
  late VideoPlayerController _videoController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset(widget.videoPath);
    _chewieController = ChewieController(
      videoPlayerController: _videoController,
      aspectRatio: 16 / 9,
      autoPlay: false,
      looping: false,
    );
  }

  @override
  void dispose() {
    _videoController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(widget.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Chewie(controller: _chewieController),
            ),
            const SizedBox(height: 15),
            Text(
              "Sets: ${widget.sets} | Reps: ${widget.reps} | Weight: ${widget.weight} lbs",
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 15),
            Text(
              widget.description,
              style: const TextStyle(color: Colors.white70, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
