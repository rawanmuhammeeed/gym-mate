import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Dumbellskul extends StatefulWidget {
  const Dumbellskul({super.key});

  @override
  _DumbbellSkullcrusherScreenState createState() => _DumbbellSkullcrusherScreenState();
}

class _DumbbellSkullcrusherScreenState extends State<Dumbellskul> {
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset("assets/videos/dumbbellskullcrusher.mp4")
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
        title: const Text("Dumbbell Skullcrusher"),
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
              "Sets: 3 | Reps: 10 | Weight: 17.5 lbs",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 15),
            const Text(
              "The Dumbbell Skullcrusher is a focused triceps exercise that helps build strength and definition in the back of your arms.",
              style: TextStyle(color: Colors.white70, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
