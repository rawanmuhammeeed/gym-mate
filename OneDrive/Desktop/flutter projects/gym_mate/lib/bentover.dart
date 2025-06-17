import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Bentover extends StatefulWidget {
  const Bentover({super.key});

  @override
  State<Bentover> createState() => _BentOverBarbellRowScreenState();
}

class _BentOverBarbellRowScreenState extends State<Bentover> {
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset("assets/videos/bent_over_barbell_row.mp4")
      ..initialize().then((_) {
        if (mounted) setState(() {});
      }).catchError((error) {
        print("خطأ في تحميل الفيديو: $error");
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
        title: const Text("Bent Over Barbell Row"),
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
              "Sets: 3 | Reps: 10 | Weight: 75 lbs",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 15),
            const Text(
              "The Bent Over Barbell Row is an effective compound movement for building strength and size in the back, especially the lats and rhomboids.",
              style: TextStyle(color: Colors.white70, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
