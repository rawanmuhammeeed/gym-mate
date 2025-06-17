import 'package:flutter/material.dart';
import 'package:gym_mate/backfly.dart';
import 'package:gym_mate/barbellbench.dart';
import 'package:gym_mate/barbellinclinebenchpress.dart';
import 'package:gym_mate/cablelateral.dart';
import 'package:gym_mate/cableropetricep.dart';
import 'package:gym_mate/dipscreen.dart';
import 'package:gym_mate/dumbbellfront.dart';
import 'package:gym_mate/dumbellskul.dart';
import 'package:gym_mate/fly.dart';
import 'package:gym_mate/pushup.dart';
import 'package:gym_mate/raise.dart';

class Intermediatescreen extends StatelessWidget {
  final List<Map<String, dynamic>> workouts = [
    {
      "title": "Workout 1",
      "muscleGroups": "Chest, Triceps, Shoulders",
      "exercises": [
        {"name": "Barbell Bench Press", "sets": 3, "reps": 4, "weight": 110},
        {"name": "Close-Grip Bench Press", "sets": 3, "reps": 10, "weight": 65},
        {
          "name": "Dumbbell Rear Delt Raise",
          "sets": 3,
          "reps": 8,
          "weight": 17.5
        },
        {"name": "Dumbbell Back Fly", "sets": 3, "reps": 10, "weight": 10},
        {"name": "Dumbbell Fly", "sets": 2, "reps": 10, "weight": 25},
        {"name": "Dip", "sets": 4, "reps": 6, "weight": 0},
      ],
    },
    {
      "title": "Workout 2",
      "muscleGroups": "Chest, Triceps, Shoulders",
      "exercises": [
        {
          "name": "Barbell Incline Bench Press",
          "sets": 3,
          "reps": 6,
          "weight": 90
        },
        {
          "name": "Cable Rope Tricep Extension",
          "sets": 3,
          "reps": 10,
          "weight": 35
        },
        {"name": "Cable Lateral Raise", "sets": 3, "reps": 8, "weight": 12.5},
        {"name": "Dumbbell Front Raise", "sets": 3, "reps": 10, "weight": 15},
        {"name": "Push Up", "sets": 3, "reps": 8, "weight": 0},
        {"name": "Dumbbell Skullcrusher", "sets": 2, "reps": 10, "weight": 15},
      ],
    },
  ];

  Intermediatescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Best Intermediate Workouts'),
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
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    workout["title"],
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
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
                          "Barbell Bench Press",
                          "Cable Rope Tricep Extension",
                          "Dumbbell Skullcrusher",
                          "Dip",
                          "Dumbbell Rear Delt Raise",
                          "Dumbbell Back Fly",
                          "Dumbbell Fly",
                          "Close-Grip Bench Press",
                          "Barbell Incline Bench Press",
                          "Cable Rope Tricep Extension",
                          "Cable Lateral Raise",
                          "Push Up",
                          "Dumbbell Skullcrusher",
                          "Dumbbell Front Raise",
                        ].contains(exercise["name"]);

                        return ListTile(
                          title: Text(
                            exercise["name"],
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                          subtitle: Text(
                            "Sets: ${exercise['sets']} | Reps: ${exercise['reps']} | Weight: ${exercise['weight']} lbs",
                            style: const TextStyle(
                                fontSize: 16, color: Colors.grey),
                          ),
                          trailing: hasScreen
                              ? const Icon(Icons.arrow_forward_ios,
                                  color: Colors.red)
                              : null,
                          onTap: hasScreen
                              ? () {
                                  if (exercise["name"] ==
                                      "Barbell Bench Press") {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Barbellbench()),
                                    );
                                  } else if (exercise["name"] ==
                                      "Close-Grip Bench Press") {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Barbellbench()),
                                    );
                                  } else if (exercise["name"] ==
                                      "Dumbbell Rear Delt Raise") {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Raise()),
                                    );
                                  } else if (exercise["name"] ==
                                      "Dumbbell Back Fly") {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Backfly()),
                                    );
                                  } else if (exercise["name"] ==
                                      "Dumbbell Fly") {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Fly()),
                                    );
                                  } else if (exercise["name"] == "Dip") {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Dipscreen()),
                                    );
                                  } else if (exercise["name"] ==
                                      "Barbell Incline Bench Press") {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Barbellinclinebenchpress()),
                                    );
                                  } else if (exercise["name"] ==
                                      "Cable Rope Tricep Extension") {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Cableropetricep()),
                                    );
                                  } else if (exercise["name"] ==
                                      "Cable Lateral Raise") {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Cablelateral()),
                                    );
                                  } else if (exercise["name"] == "Push Up") {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Pushup()),
                                    );
                                  } else if (exercise["name"] ==
                                      "Dumbbell Skullcrusher") {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Dumbellskul()),
                                    );
                                  } else if (exercise["name"] ==
                                      "Dumbbell Front Raise") {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Dumbbellfront()),
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
