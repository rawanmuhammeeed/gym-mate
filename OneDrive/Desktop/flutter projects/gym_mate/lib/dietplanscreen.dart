import 'dart:convert';
import 'package:flutter/material.dart';

class DietPlanScreen extends StatelessWidget {
  final Map<String, dynamic> dietPlan;

  const DietPlanScreen({super.key, required this.dietPlan});

  @override
  Widget build(BuildContext context) {
    // ✅ التعامل مع البيانات حسب شكلها الحقيقي
    final dynamic weeklyRaw = dietPlan['weekly_plan'];
    final dynamic dailyRaw = dietPlan['daily_totals'];

    Map<String, dynamic> safeParse(dynamic rawData) {
      if (rawData == null) return {};
      try {
        if (rawData is String) {
          final decoded = jsonDecode(rawData);
          if (decoded is Map<String, dynamic>) {
            return decoded;
          }
        } else if (rawData is Map) {
          return Map<String, dynamic>.from(rawData);
        }
      } catch (e) {
        print("❌ Parsing Error: $e");
      }
      return {};
    }

    final weeklyPlan = safeParse(weeklyRaw);
    final dailyTotals = safeParse(dailyRaw);

    // ✅ لو مفيش بيانات حقيقية
    if (weeklyPlan.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text("Diet Plan")),
        body: const Center(
          child: Text(
            "⚠️ No diet plan found.\nPlease make sure your API returns 'weekly_plan' and 'daily_totals'.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.red),
          ),
        ),
      );
    }

    final days = weeklyPlan.keys.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Diet Plan'),
        backgroundColor: Colors.red,
      ),
      body: Container(
        color: Colors.black,
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: days.length,
          itemBuilder: (context, index) {
            final day = days[index];
            final meals = Map<String, dynamic>.from(weeklyPlan[day] ?? {});
            final totals = dailyTotals[day] != null
                ? Map<String, dynamic>.from(dailyTotals[day])
                : null;
            return _buildDayCard(day, meals, totals);
          },
        ),
      ),
    );
  }

  Widget _buildDayCard(String day, Map<String, dynamic> meals, Map<String, dynamic>? totals) {
    return Card(
      color: Colors.white.withOpacity(0.9),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(day, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            if (totals != null) _buildDailyTotals(totals),
            const SizedBox(height: 10),
            ...meals.entries.map((mealEntry) {
              final mealType = mealEntry.key;
              final mealList = List<Map<String, dynamic>>.from(
                (mealEntry.value ?? []).map((e) => Map<String, dynamic>.from(e)),
              );
              return _buildMealDetail(mealType, mealList);
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildMealDetail(String mealType, List<Map<String, dynamic>> mealList) {
    if (mealList.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Text(
          "$mealType: No data",
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            mealType,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueAccent),
          ),
          ...mealList.map((item) {
            return Padding(
              padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${item["food"]} - Portion: ${item["portion"]}g", style: const TextStyle(fontSize: 16)),
                  Text(
                    "Calories: ${item["calories"]} | Protein: ${item["protein"]} | Carbs: ${item["carbs"]} | Fats: ${item["fats"]}",
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildDailyTotals(Map<String, dynamic> totals) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Daily Totals:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Text(
          "Calories: ${totals["calories"]} | Protein: ${totals["protein"]} | Carbs: ${totals["carbs"]} | Fats: ${totals["fats"]}",
          style: const TextStyle(fontSize: 14, color: Colors.black87),
        ),
      ],
    );
  }
}
