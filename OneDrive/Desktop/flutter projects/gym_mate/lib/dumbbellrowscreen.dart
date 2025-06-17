import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class DumbbellRowScreen extends StatefulWidget {
  const DumbbellRowScreen({super.key});
 // هنا غيرت الاسم ليكون متطابقًا
  @override
  _DumbbellRowScreenState createState() => _DumbbellRowScreenState();
}

class _DumbbellRowScreenState extends State<DumbbellRowScreen> { 
  late VideoPlayerController _videoController;

  @override
  void initState() {
  super.initState();
  _videoController = VideoPlayerController.asset("assets/videos/dumbbellrow.mp4")
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
        title: const Text("Dumbbell Row"),
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
              "Sets: 3 | Reps: 5 | Weight: 25 lbs",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),

            const SizedBox(height: 15),

            const Text(
              "The Dumbbell Row targets your back muscles, improving strength and stability.",
              style: TextStyle(color: Colors.white70, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
