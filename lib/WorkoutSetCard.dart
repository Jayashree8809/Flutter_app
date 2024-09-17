import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'models/demo.dart';

class WorkoutSetCard extends StatelessWidget {
  final WorkoutSet workoutSet;
  final List<String> exercises;
  final VoidCallback onRemove;
  final ValueChanged<WorkoutSet> onUpdate;

  WorkoutSetCard({
    required this.workoutSet,
    required this.exercises,
    required this.onRemove,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 16.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dropdown to select the exercise
            DropdownButton<String>(
              value: workoutSet.exercise,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  onUpdate(WorkoutSet(exercise: newValue, weight: workoutSet.weight, repetitions: workoutSet.repetitions));
                }
              },
              items: exercises.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 8.0),

            // TextField for weight input
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Weight (kg)'),
              onChanged: (value) {
                onUpdate(WorkoutSet(exercise: workoutSet.exercise, weight: double.tryParse(value) ?? 0, repetitions: workoutSet.repetitions));
              },
            ),
            SizedBox(height: 8.0),

            // TextField for repetitions input
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Repetitions'),
              onChanged: (value) {
                onUpdate(WorkoutSet(exercise: workoutSet.exercise, weight: workoutSet.weight, repetitions: int.tryParse(value) ?? 0));
              },
            ),
            SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }
}
