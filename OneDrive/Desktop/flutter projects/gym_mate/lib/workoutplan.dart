import 'package:flutter/material.dart';
import 'package:gym_mate/beginnerscreen.dart';
import 'package:gym_mate/dayfullbodyworkout.dart';
import 'package:gym_mate/intermediatescreen.dart';
import 'package:gym_mate/advancedscreen.dart';
import 'package:gym_mate/daysworkoutsplit.dart';


class Workoutplan extends StatelessWidget {
  const Workoutplan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Workout Plan',
            style: TextStyle(color: Colors.white, fontSize: 25)),
        backgroundColor: Colors.black,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Gym Mate"),
              accountEmail: Text("workout@gym.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.orange,
                child: Icon(Icons.fitness_center, color: Colors.white),
              ),
            ),
            ListTile(
              leading: Icon(Icons.fitness_center),
              title: Text('3 Days Workout Split'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DaysWorkoutSplit(),
                  ),
                );
              },
            ),
            
            ListTile(
              leading: Icon(Icons.fitness_center),
              title: Text('3-Day Full Body Workout'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Dayfullbodyworkout(), 
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           
            Text(
              'Select Workout Level',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Beginnerscreen(),
                  ),
                );
              },
              child: Text('Beginner'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Intermediatescreen(),
                  ),
                );
              },
              child: Text('Intermediate'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Advancedscreen(),
                  ),
                );
              },
              child: Text('Advanced'),
            ),
          ],
        ),
      ),
    );
  }
}
