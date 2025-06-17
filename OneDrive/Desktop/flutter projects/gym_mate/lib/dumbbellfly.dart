import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Dumbbellfly extends StatefulWidget {
  const Dumbbellfly({super.key});

  @override
  _DumbbellFlyScreenState createState() => _DumbbellFlyScreenState();
}

class _DumbbellFlyScreenState extends State<Dumbbellfly> {
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset("assets/videos/dumbbellfly.mp4")
      ..initialize().then((_) {
        if (mounted) setState(() {});
      }).catchError((error) {
        print("error: $error");
      });
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text("Dumbbell Fly"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _videoController.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _videoController.value.aspectRatio,
                    child: VideoPlayer(_videoController),
                  )
                : const Center(child: CircularProgressIndicator()),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _videoController.value.isPlaying
                      ? _videoController.pause()
                      : _videoController.play();
                });
              },
              child: Icon(
                _videoController.value.isPlaying ? Icons.pause : Icons.play_arrow,
                size: 30,
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              "Sets: 3 | Reps: 8 | Weight: 17.5 lbs",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 15),
            const Text(
              "The Dumbbell Fly is an effective chest exercise that targets the pectoral muscles and helps improve upper body strength and muscle definition.",
              style: TextStyle(color: Colors.white70, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
