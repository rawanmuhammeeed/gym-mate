import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Fly extends StatefulWidget {
  const Fly({super.key});

  @override
  _FlyScreenState createState() => _FlyScreenState();
}

class _FlyScreenState extends State<Fly> {
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset("assets/videos/dumbbellfly.mp4")
      ..initialize().then((_) {
        if (mounted) {
          setState(() {}); 
        }
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
              "Sets: 2 | Reps: 10 | Weight: 25 lbs",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),

            const SizedBox(height: 15),

            const Text(
              "The Dumbbell Fly is a great chest isolation exercise that helps in muscle growth and increasing flexibility in the shoulder joint.",
              style: TextStyle(color: Colors.white70, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
