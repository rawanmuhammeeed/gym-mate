import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Accountscreen extends StatefulWidget {
  const Accountscreen({super.key});

  @override
  _AccountscreenState createState() => _AccountscreenState();
}

class _AccountscreenState extends State<Accountscreen> {
  String? name;
  String? email;
  String? phone;
  String? gender;
  String? age;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name') ?? 'No Name';
      email = prefs.getString('email') ?? 'No Email';
      phone = prefs.getString('phone') ?? 'No Phone';
      gender = prefs.getString('gender') ?? 'No Gender';
      age = prefs.getString('age') ?? 'No Age';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, 
      appBar: AppBar(
        title: const Text('Account Info'),
        backgroundColor: Colors.red.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: (name == null)
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                children: [
                  _buildInfoCard('Name', name!, Icons.person),
                  _buildInfoCard('Email', email!, Icons.email),
                  _buildInfoCard('Phone', phone!, Icons.phone),
                  _buildInfoCard('Gender', gender!, Icons.person_outline),
                  _buildInfoCard('Age', age!, Icons.cake),
                ],
              ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String value, IconData icon) {
    return Card(
      color: Colors.grey.shade900,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon, color: Colors.redAccent, size: 30),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
