import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gym_mate/inbodyApi.dart';
import 'package:gym_mate/dietplanscreen.dart';

class InBodyScreen extends StatefulWidget {
  const InBodyScreen({super.key});

  @override
  _InBodyScreenState createState() => _InBodyScreenState();
}

class _InBodyScreenState extends State<InBodyScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _lengthController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  String _selectedGender = 'Male';
  String _selectedWorkoutDays = '3 Days';
  String _selectedGoal = 'Muscle Gain';

  final InBodyApi _inBodyApi = InBodyApi();
  bool _isLoading = true;
  bool _hasData = false;
  bool _isEditing = false;
  Map<String, dynamic>? _inBodyData;
  Map<String, dynamic>? _dietPlan;

  @override
  void initState() {
    super.initState();
    _loadInBodyData();
  }

  Future<void> _loadInBodyData() async {
    setState(() => _isLoading = true);

    var data = await _inBodyApi.getInBodyData(forceRefresh: true);
    print("📥 Data from API: $data");

    if (data != null && data.isNotEmpty) {
      setState(() {
        _inBodyData = data;
        _weightController.text = data["weight"].toString();
        _lengthController.text = data["length"].toString();
        _ageController.text = data["age"].toString();
        _selectedGender = data["gender"];
        _selectedWorkoutDays = data["workoutdays"];
        _selectedGoal = data["goal"];
        _hasData = true;
        _isEditing = false;

        if (data["dietPlan"] != null) {
          try {
            if (data["dietPlan"] is String) {
              final decoded = jsonDecode(data["dietPlan"]);
              _dietPlan = Map<String, dynamic>.from(decoded);
            } else if (data["dietPlan"] is Map) {
              _dietPlan = Map<String, dynamic>.from(data["dietPlan"]);
            } else {
              _dietPlan = {};
            }
          } catch (e) {
            print("❌ Error decoding dietPlan: $e");
            _dietPlan = {};
          }
        } else {
          _dietPlan = {};
        }

        print("📌 Diet Plan Loaded: $_dietPlan");
      });
    } else {
      setState(() {
        _hasData = false;
        _inBodyData = null;
        _dietPlan = {"meals": []};
        _isEditing = true;
      });
    }

    setState(() => _isLoading = false);
  }

  Future<void> _waitForDietPlan() async {
    int tries = 0;
    while (tries < 5) {
      await Future.delayed(Duration(seconds: 2));
      var latestData = await _inBodyApi.getInBodyData(forceRefresh: true);

      if (latestData != null && latestData["dietPlan"] != null) {
        try {
          final plan = latestData["dietPlan"];
          Map<String, dynamic> parsedPlan;

          if (plan is String) {
            parsedPlan = Map<String, dynamic>.from(jsonDecode(plan));
          } else if (plan is Map) {
            parsedPlan = Map<String, dynamic>.from(plan);
          } else {
            parsedPlan = {};
          }

          setState(() {
            _dietPlan = parsedPlan;
            _hasData = true; // ✅ ضروري عشان الزر يظهر بعد استلام الخطة
          });

          print("✅ Diet plan loaded after waiting and setState done.");
          break;
        } catch (e) {
          print("❌ Failed to parse plan inside try block: $e");
        }
      }

      tries++;
    }
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    String? errorMessage;
    if (_hasData) {
      errorMessage = await _inBodyApi.updateInBodyData(
        weight: _weightController.text,
        length: _lengthController.text,
        age: _ageController.text,
        gender: _selectedGender,
        workoutdays: _selectedWorkoutDays,
        goal: _selectedGoal,
      );
    } else {
      errorMessage = await _inBodyApi.saveInBodyData(
        weight: _weightController.text,
        length: _lengthController.text,
        age: _ageController.text,
        gender: _selectedGender,
        workoutdays: _selectedWorkoutDays,
        goal: _selectedGoal,
      );
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(errorMessage!)),
    );

    await _waitForDietPlan();
    await _loadInBodyData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/inbody.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            AppBar(
              title: const Text('InBody Analysis',
                  style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.black.withOpacity(0.8),
              actions: [
                if (_hasData)
                  IconButton(
                    icon: Icon(_isEditing ? Icons.save : Icons.edit,
                        color: Colors.white),
                    onPressed: () {
                      if (_isEditing) {
                        _submitForm();
                      } else {
                        setState(() => _isEditing = true);
                      }
                    },
                  ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _buildTextField(_weightController, 'Weight (kg)',
                          Icons.fitness_center),
                      const SizedBox(height: 20),
                      _buildTextField(
                          _lengthController, 'Height (cm)', Icons.height),
                      const SizedBox(height: 20),
                      _buildTextField(_ageController, 'Age', Icons.cake),
                      const SizedBox(height: 20),
                      _buildGenderDropdown(),
                      const SizedBox(height: 20),
                      _buildWorkoutDaysDropdown(),
                      const SizedBox(height: 20),
                      _buildGoalDropdown(),
                      const SizedBox(height: 30),
                      if (!_hasData)
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: _submitForm,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              'Save',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ),
                      const SizedBox(height: 20),
                      if (_hasData ||
                          (_dietPlan != null && _dietPlan!.isNotEmpty))
                        _buildDietPlanButton(), // ✅ تم تعديله
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String label, IconData icon) {
    return TextFormField(
      controller: controller,
      readOnly: !_isEditing,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.blue),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
    );
  }

  Widget _buildGenderDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedGender,
      decoration: InputDecoration(
        labelText: 'Gender',
        prefixIcon: Icon(Icons.person, color: Colors.blue),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
      items: ['Male', 'Female'].map((gender) {
        return DropdownMenuItem(
          value: gender,
          child: Text(gender),
        );
      }).toList(),
      onChanged: _isEditing
          ? (newValue) {
              setState(() {
                _selectedGender = newValue!;
              });
            }
          : null,
    );
  }

  Widget _buildWorkoutDaysDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedWorkoutDays,
      decoration: InputDecoration(
        labelText: 'Workout Days',
        prefixIcon: Icon(Icons.calendar_today, color: Colors.blue),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
      items: ['3 Days', '4 Days', '5 Days', 'very_active'].map((days) {
        return DropdownMenuItem(
          value: days,
          child: Text(days),
        );
      }).toList(),
      onChanged: _isEditing
          ? (newValue) {
              setState(() {
                _selectedWorkoutDays = newValue!;
              });
            }
          : null,
    );
  }

  Widget _buildGoalDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedGoal,
      decoration: InputDecoration(
        labelText: 'Goal',
        prefixIcon: Icon(Icons.flag, color: Colors.blue),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
      items: ['Muscle Gain', 'lose weight'].map((goal) {
        return DropdownMenuItem(
          value: goal,
          child: Text(goal),
        );
      }).toList(),
      onChanged: _isEditing
          ? (newValue) {
              setState(() {
                _selectedGoal = newValue!;
              });
            }
          : null,
    );
  }

  Widget _buildDietPlanButton() {
    bool hasMeals = _dietPlan != null &&
        _dietPlan!.containsKey('weekly_plan') &&
        (_dietPlan!['weekly_plan'] as Map).isNotEmpty;

    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: hasMeals
            ? () {
                print("✅ Sending diet plan to screen: $_dietPlan");

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DietPlanScreen(dietPlan: _dietPlan!),
                  ),
                );
              }
            : () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('No Diet Plan Available')),
                );
              },
        style: ElevatedButton.styleFrom(
          backgroundColor: hasMeals ? Colors.blueAccent : Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          hasMeals ? 'View Diet Plan' : 'No Diet Plan Available',
          style: const TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}
