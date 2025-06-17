import 'package:flutter/material.dart';
import 'package:gym_mate/videoplayerscreen.dart';


class Backscreen extends StatelessWidget {
  Backscreen({super.key});

  // lists of videos 
  final List<Map<String, String>> videos = [
    {
      'title': 'back workout 1',
      'videoPath': 'assets/videos/back.mov',  //path bta3 el video
    },
    {
      'title': 'back workout 2',
      'videoPath': 'assets/videos/back_workout_2.mp4',  
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تمارين الظهر'),
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
        itemCount: videos.length,
        itemBuilder: (context, index) {
          final video = videos[index];
          return ListTile(
            title: Text(video['title']!),
            onTap: () {
          
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Videoplayerscreen(videoPath: video['videoPath']!),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
