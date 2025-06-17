import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Crunches extends StatefulWidget {
  const Crunches({super.key});

  @override
  _CrunchesScreenState createState() => _CrunchesScreenState();
}

class _CrunchesScreenState extends State<Crunches> {
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset("assets/videos/crunches.mp4")
      ..initialize().then((_) {
        if (mounted) setState(() {});
      }).catchError((error) {
        print("error:$error");
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
        title: const Text("Crunches"),
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
              "Sets: 4 | Reps: 8 | Weight: Bodyweight",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 15),
            const Text(
              "Crunches are a fundamental abdominal exercise that helps strengthen the core muscles and improve posture.",
              style: TextStyle(color: Colors.white70, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
