import 'package:flutter/material.dart';
import 'package:gym_mate/backsquat.dart';
import 'package:gym_mate/ballhip.dart';
import 'package:gym_mate/barbellbench.dart';
import 'package:gym_mate/barbellcurl.dart';
import 'package:gym_mate/barbellinclinebenchpress.dart';
import 'package:gym_mate/bentover.dart';
import 'package:gym_mate/burpee.dart';
import 'package:gym_mate/cable.dart';
import 'package:gym_mate/crunches.dart';
import 'package:gym_mate/dipscreen.dart';
import 'package:gym_mate/bicyclescreen.dart';
import 'package:gym_mate/dumbbellbicep.dart';

class Advancedscreen extends StatelessWidget {
  final List<Map<String, dynamic>> workouts = [
    {
      "title": "Workout 1",
      "muscleGroups": "Quadriceps, Chest, Back, Biceps, Triceps, Abs",
      "exercises": [
        {"name": "Back Squat", "sets": 3, "reps": 4, "weight": 145},
        {"name": "Barbell Bench Press", "sets": 3, "reps": 9, "weight": 110},
        {"name": "Cable Row", "sets": 3, "reps": 9, "weight": 90},
        {"name": "Barbell Curl", "sets": 3, "reps": 10, "weight": 40},
        {"name": "Dip", "sets": 3, "reps": 10, "weight": 0},
        {"name": "Bicycle Crunch", "sets": 4, "reps": 12, "weight": 0},
      ],
    },
    {
      "title": "Workout 2",
      "muscleGroups": "Chest, Quadriceps, Biceps, Back, Glutes, Abs",
      "exercises": [
        {"name": "Barbell Incline Bench Press", "sets": 3, "reps": 6, "weight": 100},
        {"name": "Burpee", "sets": 3, "reps": 10, "weight": 0},
        {"name": "Dumbbell Bicep Curl", "sets": 3, "reps": 8, "weight": 30},
        {"name": "Bent Over Barbell Row", "sets": 3, "reps": 10, "weight": 75},
        {"name": "Stability Ball Hip Bridge", "sets": 3, "reps": 1, "weight": 0},
        {"name": "Crunches", "sets": 4, "reps": 12, "weight": 0},
      ],
    },
  ];

 Advancedscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Best Advanced Workouts'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.black, 
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: workouts.length,
        itemBuilder: (context, index) {
          final workout = workouts[index];
          return Card(
            color: Colors.grey[900], 
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    workout["title"],
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Muscle Groups: ${workout['muscleGroups']}",
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    children: List.generate(
                      workout["exercises"].length,
                      (i) {
                        final exercise = workout["exercises"][i];
                        bool hasScreen = [
                          "Back Squat",
                          "Barbell Bench Press",
                          "Cable Row",
                          "Barbell Curl",
                          "Dip",
                          "Bicycle Crunch",
                          "Barbell Incline Bench Press",
  "Burpee",
  "Dumbbell Bicep Curl",
  "Bent Over Barbell Row",
  "Stability Ball Hip Bridge",
  "Crunches",
                        ].contains(exercise["name"]);

                        return ListTile(
                          title: Text(
                            exercise["name"],
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
                          ),
                          subtitle: Text(
                            "Sets: ${exercise['sets']} | Reps: ${exercise['reps']} | Weight: ${exercise['weight']} lbs",
                            style: const TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                          trailing: hasScreen ? const Icon(Icons.arrow_forward_ios, color: Colors.red) : null,
                          onTap: hasScreen
                              ? () {
                                  if (exercise["name"] == "Back Squat") {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Backsquat()),
                                    );
                                  } else if (exercise["name"] == "Barbell Bench Press") {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Barbellbench()),
                                    );
                                  } else if (exercise["name"] == "Cable Row") {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Cable()),
                                    );
                                  } else if (exercise["name"] == "Barbell Curl") {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Barbellcurl()),
                                    );
                                  } else if (exercise["name"] == "Dip") {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Dipscreen()),
                                    );
                                  } else if (exercise["name"] == "Bicycle Crunch") {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Bicyclescreen()),
                                    );
                                  }else if (exercise["name"] == "Barbell Incline Bench Press") {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Barbellinclinebenchpress()),
                                    );
                                  }else if (exercise["name"] == "Burpee") {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Burpee()),
                                    );
                                  }else if (exercise["name"] == "Dumbbell Bicep Curl") {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Dumbbellbicep()),
                                    );
                                  }else if (exercise["name"] == "Bent Over Barbell Row") {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Bentover()),
                                    );
                                  }else if (exercise["name"] == "Stability Ball Hip Bridge") {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Ballhip()),
                                    );
                                  }else if (exercise["name"] == "Crunches") {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Crunches()),
                                    );
                                  }
                                }
                              : null,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
