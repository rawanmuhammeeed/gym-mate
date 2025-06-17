import 'package:flutter/material.dart';
import 'package:gym_mate/ballcrunch.dart';
import 'package:gym_mate/barbellcurl.dart';
import 'package:gym_mate/benchpress.dart';
import 'package:gym_mate/cablecrossover.dart';
import 'package:gym_mate/cablerow.dart';
import 'package:gym_mate/crunches.dart';
import 'package:gym_mate/dumbbellfly.dart';
import 'package:gym_mate/dumbbellrowscreen.dart';
import 'package:gym_mate/dumbellskul.dart';
import 'package:gym_mate/hacksquat.dart';
import 'package:gym_mate/latpulldown.dart';
import 'package:gym_mate/legcurl.dart';
import 'package:gym_mate/legpress.dart';
import 'package:gym_mate/lungescreen.dart';
import 'package:gym_mate/hamstringscreen.dart';
import 'package:gym_mate/dipscreen.dart';
import 'package:gym_mate/bicyclescreen.dart';
import 'package:gym_mate/skullcrusher.dart';

class Beginnerscreen extends StatelessWidget {
  final List<Map<String, dynamic>> workouts = [
    {
      "title": "Workout 1",
      "muscleGroups": "Back, Chest, Quadriceps, Hamstrings, Triceps, Abs",
      "exercises": [
        {"name": "Dumbbell Row", "sets": 3, "reps": 5, "weight": 25},
        {"name": "Dumbbell Bench Press", "sets": 3, "reps": 10, "weight": 20},
        {"name": "Dumbbell Lunge", "sets": 3, "reps": 4, "weight": 20},
        {"name": "Lying Hamstrings Curl", "sets": 3, "reps": 10, "weight": 40},
        {"name": "Dip", "sets": 3, "reps": 6, "weight": 0},
        {"name": "Bicycle Crunch", "sets": 4, "reps": 8, "weight": 0},
      ],
    },
    {
      "title": "Workout 2",
      "muscleGroups": "Back, Quadriceps, Chest, Triceps, Hamstrings, Abs",
      "exercises": [
        {"name": "Lat Pulldown", "sets": 3, "reps": 4, "weight": 65},
        {"name": "Leg Press", "sets": 3, "reps": 8, "weight": 75},
        {"name": "Dumbbell Fly", "sets": 3, "reps": 8, "weight": 17.5},
        {"name": "Dumbbell Skullcrusher", "sets": 3, "reps": 10, "weight": 17.5},
        {"name": "Seated Leg Curl", "sets": 2, "reps": 10, "weight": 55},
        {"name": "Crunches", "sets": 4, "reps": 8, "weight": 0},
      ],
    },
     {
      "title": "Workout 3",
      "muscleGroups": "Biceps, Triceps, Back, Chest, Quadriceps, Abs",
      "exercises": [
        {"name": "Barbell Curl", "sets": 3, "reps": 5, "weight": 30},
        {"name": "Skullcrusher", "sets": 3, "reps": 10, "weight": 20},
        {"name": "Cable Row", "sets": 3, "reps": 8, "weight": 55},
        {"name": "Cable Crossover Fly", "sets": 3, "reps": 10, "weight": 20},
        {"name": "Hack Squat", "sets": 2, "reps": 11, "weight": 75},
        {"name": "Exercise Ball Crunch", "sets": 4, "reps": 8, "weight": 0},
      ],
    },
  ];

  Beginnerscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Best Beginner Workouts'),
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
                        return ListTile(
                          title: Text(
                            exercise["name"],
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
                          ),
                          subtitle: Text(
                            "Sets: ${exercise['sets']} | Reps: ${exercise['reps']} | Weight: ${exercise['weight']} lbs",
                            style: const TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                          onTap: () {
                            if (exercise["name"] == "Dumbbell Row") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => DumbbellRowScreen()),
                              );
                            } else if (exercise["name"] == "Dumbbell Bench Press") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Benchpress()),
                              );
                            } else if (exercise["name"] == "Dumbbell Lunge") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Lungescreen()),
                              );
                            } else if (exercise["name"] == "Lying Hamstrings Curl") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Hamstringscreen()),
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
                            } else if (exercise["name"] == "Lat Pulldown") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Latpulldown()),
                              );
                            }
                            else if (exercise["name"] == "Leg Press") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Legpress()),
                              );
                            }else if (exercise["name"] == "Dumbbell Fly") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Dumbbellfly()),
                              );
                            }else if (exercise["name"] == "Dumbbell Skullcrusher") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Dumbellskul()),
                              );
                            }else if (exercise["name"] == "Seated Leg Curl") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Legcurl()),
                              );
                            }else if (exercise["name"] == "Crunches") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Crunches()),
                              );
                            }else if (exercise["name"] == "Barbell Curl") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Barbellcurl()),
                              );
                            }else if (exercise["name"] == "Skullcrusher") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Skullcrusher()),
                              );
                            }else if (exercise["name"] == "Cable Row") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Cablerow()),
                              );
                            }else if (exercise["name"] == "Cable Crossover Fly") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Cablecrossover()),
                              );
                            }else if (exercise["name"] == "Hack Squat") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Hacksquat()),
                              );
                            }else if (exercise["name"] == "Exercise Ball Crunch") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Ballcrunch()),
                              );
                            }
                          },
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
