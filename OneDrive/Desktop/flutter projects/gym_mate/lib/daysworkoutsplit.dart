import 'package:flutter/material.dart';
import 'package:gym_mate/absscreen.dart';
import 'package:gym_mate/backscreen.dart';
import 'package:gym_mate/bicepsscreen.dart';
import 'package:gym_mate/calvesscreen.dart';
import 'package:gym_mate/chestscreen.dart';
import 'package:gym_mate/hamstringsscreen.dart';
import 'package:gym_mate/quadsscreen.dart';
import 'package:gym_mate/shouldersscreen.dart';
import 'package:gym_mate/tricepsscreen.dart';


void main() {
  runApp(MaterialApp(
    home: DaysWorkoutSplit(),
    debugShowCheckedModeBanner: false,
  ));
}

class DaysWorkoutSplit extends StatelessWidget {
  const DaysWorkoutSplit({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Workout Plan',
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Day 1
            Text(
              'Day 1 - Back, Biceps, Forearms, Traps and Abs',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                       Backscreen()
                  ),
                );
              },
              child: Text('Back'),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                       Bicepsscreen(),
                  ),
                );
              },
              child: Text('Biceps'),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        Absscreen(),
                  ),
                );
              },
              child: Text('Abs'),
            ),
            SizedBox(height: 20),

            // Day 2
            Text(
              'Day 2 - OFF',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                // Rest Day
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.grey,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: Text('Rest Day - Day 2'),
            ),
            SizedBox(height: 20),

            // Day 3
            Text(
              'Day 3 - Chest, Shoulders and Triceps',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        Chestscreen(),
                  ),
                );
              },
              child: Text('Chest'),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        Shouldersscreen(),
                  ),
                );
              },
              child: Text('Shoulders'),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        Tricepsscreen(),
                  ),
                );
              },
              child: Text('Triceps'),
            ),
            SizedBox(height: 20),

            // Day 4 (Rest)
            Text(
              'Day 4 - OFF',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                // Rest Day
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.grey,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: Text('Rest Day - Day 4'),
            ),
            SizedBox(height: 20),

            // Day 5
            Text(
              'Day 5 - Quads, Hamstrings, Calves and Abs',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        Quadsscreen(),
                  ),
                );
              },
              child: Text('Quads'),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        Hamstringsscreen(),
                  ),
                );
              },
              child: Text('Hamstrings'),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        Calvesscreen(),
                  ),
                );
              },
              child: Text('Calves'),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        Absscreen(),
                  ),
                );
              },
              child: Text('Abs'),
            ),
            SizedBox(height: 20),

            // Day 6 (Rest)
            Text(
              'Day 6 - OFF',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                // Rest Day
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.grey,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: Text('Rest Day - Day 6'),
            ),
            SizedBox(height: 20),

            // Day 7 (Rest)
            Text(
              'Day 7 - OFF',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                // Rest Day
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.grey,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: Text('Rest Day - Day 7'),
            ),
          ],
        ),
      ),
    );
  }
}
