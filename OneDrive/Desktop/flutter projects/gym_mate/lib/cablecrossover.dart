import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Cablecrossover extends StatefulWidget {
  const Cablecrossover({super.key});

  @override
  _CableCrossoverFlyScreenState createState() => _CableCrossoverFlyScreenState();
}

class _CableCrossoverFlyScreenState extends State<Cablecrossover> {
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset("assets/videos/cable_crossover_fly.mp4")
      ..initialize().then((_) {
        if (mounted) setState(() {});
      }).catchError((error) {
        print("error $error");
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
        title: const Text("Cable Crossover Fly"),
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
              "Sets: 3 | Reps: 10 | Weight: 20 lbs",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 15),
            const Text(
              "The Cable Crossover Fly is a great isolation movement for the chest, especially the inner pecs.",
              style: TextStyle(color: Colors.white70, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
