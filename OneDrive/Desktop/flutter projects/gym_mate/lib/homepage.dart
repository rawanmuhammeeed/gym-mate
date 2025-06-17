import 'package:flutter/material.dart';
import 'package:gym_mate/accountscreen.dart';
import 'package:gym_mate/advancedscreen.dart';
import 'package:gym_mate/beginnerscreen.dart';
import 'package:gym_mate/dayfullbodyworkout.dart';
import 'package:gym_mate/daysworkoutsplit.dart';
import 'package:gym_mate/intermediatescreen.dart';
import 'package:gym_mate/inbodyscreen.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      drawer: _buildDrawer(context),
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.8),
        elevation: 0,
        title: const Text(
          "Gym Mate",
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
      ),
      body: Container(  color: Colors.black,

       // decoration: const BoxDecoration(
        //  image: DecorationImage(
          //  image: AssetImage("assets/images/loo.jpg"),
          //  fit: BoxFit.cover,
          //),
       // ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "WORK Out",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Hey,\nChoose Your Work Out Level.",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 30),
              _buildWorkoutButton(
                context,
                title: "BEGINNERS",
                destination: Beginnerscreen(),
              ),
              const SizedBox(height: 15),
              _buildWorkoutButton(
                context,
                title: "INTERMEDIATE",
                destination: Intermediatescreen(),
              ),
              const SizedBox(height: 15),
              _buildWorkoutButton(
                context,
                title: "ADVANCED",
                destination: Advancedscreen(),
              ),
              const SizedBox(height: 30),
              const Text(
                "Popular Training 🔥",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 180,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DaysWorkoutSplit()),
                        );
                      },
                      child: _buildPopularCard(
                        imagePath: 'assets/images/qwqw.jpg',
                        title: 'Push Pull Leg',
                        
                      ),
                    ),
                    const SizedBox(width: 15),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Dayfullbodyworkout()),
                        );
                      },
                      child: _buildPopularCard(
                        imagePath: 'assets/images/okok.jpg',
                        title: 'FullBody',
                        
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

 
  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black87,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.9),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.fitness_center, color: Colors.white, size: 50),
                SizedBox(height: 10),
                Text(
                  "Welcome to Gym Mate!",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person, color: Colors.white),
            title: const Text("My Account", style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Accountscreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.monitor_weight, color: Colors.white),
            title: const Text("InBody", style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const InBodyScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.redAccent),
            title: const Text("Logout", style: TextStyle(color: Colors.redAccent)),
            onTap: () {
              Navigator.pop(context); 
            },
          ),
        ],
      ),
    );
  }

  
  Widget _buildPopularCard({
    required String imagePath,
    required String title,
    
  }) {
    return Container(
      width: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.black.withOpacity(0.3),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 4),
            Text(
             title,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  
  Widget _buildWorkoutButton(BuildContext context,
      {required String title, required Widget destination}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        );
      },
      child: Container(
        height: 65,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [Colors.black87, Colors.grey.shade800],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(3, 3),
            ),
          ],
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.1,
            ),
          ),
        ),
      ),
    );
  }
}
