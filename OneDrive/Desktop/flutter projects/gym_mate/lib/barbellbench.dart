import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Barbellbench extends StatefulWidget {
  const Barbellbench({super.key});

  @override
  _BarbellBenchPressScreenState createState() => _BarbellBenchPressScreenState();
}

class _BarbellBenchPressScreenState extends State<Barbellbench> {
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset("assets/videos/barbellbenchpress.mp4")
      ..initialize().then((_) {
        setState(() {}); 
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
        title: const Text("Barbell Bench Press"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: _videoController.value.isInitialized
                  ? VideoPlayer(_videoController)
                  : const Center(child: CircularProgressIndicator()), 
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _videoController.value.isPlaying
                      ? _videoController.pause()
                      : _videoController.play();
                });
              },
              child: Text(_videoController.value.isPlaying ? "Pause" : "Play"),
            ),
            const SizedBox(height: 15),
            const Text(
              "Sets: 3 | Reps: 9 | Weight: 110 lbs",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 15),
            const Text(
              "The Barbell Bench Press is one of the best exercises for chest and upper body strength.",
              style: TextStyle(color: Colors.white70, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
