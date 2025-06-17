import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:gym_mate/camerascreen.dart';

class Dumbbellbicep extends StatefulWidget {
  const Dumbbellbicep({super.key});

  @override
  State<Dumbbellbicep> createState() => _DumbbellBicepCurlScreenState();
}

class _DumbbellBicepCurlScreenState extends State<Dumbbellbicep> {
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset("assets/videos/dumbbell_bicep_curl.mp4")
      ..initialize().then((_) {
        if (mounted) setState(() {});
      }).catchError((error) {
        print("Error loading video: $error");
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
        title: const Text("Dumbbell Bicep Curl"),
      ),
      body: SingleChildScrollView(
        child: Padding(
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

              // Play / Pause Button
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

              // ✅ Camera Button after play button
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Camerascreen()),
                  );
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.camera_alt),
                    SizedBox(width: 8),
                    Text("Start Camera"),
                  ],
                ),
              ),
              const SizedBox(height: 15),

              const Text(
                "Sets: 3 | Reps: 8 | Weight: 30 lbs",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              const SizedBox(height: 15),
              const Text(
                "The Dumbbell Bicep Curl is a classic arm exercise that strengthens the biceps and improves upper arm definition.",
                style: TextStyle(color: Colors.white70, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
