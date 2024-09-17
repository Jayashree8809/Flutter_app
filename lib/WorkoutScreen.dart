import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'models/demo.dart';// Import the workout model
import 'package:flutterapp1/WorkouthistoryScreen.dart';
class WorkoutScreen extends StatefulWidget {
  @override
  _WorkoutScreenState createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  final List<String> exercises = ['Barbell row', 'Bench press', 'Shoulder press', 'Deadlift', 'Squat'];
  List<WorkoutSet> workoutSets = [];

  // Add a set
  void addSet() {
    setState(() {
      workoutSets.add(WorkoutSet(exercise: exercises[0], weight: 0, repetitions: 0));
    });
  }

  // Remove a set
   removeSet(int index) {
    setState(() {
      workoutSets.removeAt(index);
    });
  }

  // Save workout to Hive
  Future<void> saveWorkout() async {
    final workoutBox = Hive.box<Workout>('workouts');
    Workout workout = Workout(date: DateTime.now(), sets: workoutSets);

    await workoutBox.add(workout);  // Save workout in Hive

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Workout Saved!')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workout Screen'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: workoutSets.length,
                itemBuilder: (context, index) {
                  return WorkoutSetCard(
                    workoutSet: workoutSets[index],
                    exercises: exercises,
                    onRemove: () => removeSet(index),
                    onUpdate: (updatedSet) {
                      setState(() {
                        workoutSets[index] = updatedSet;
                      });
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: addSet,
                  child: Text('Add Set'),
                ),
                SizedBox(
                    width: 16.0),
                ElevatedButton(
                  onPressed: workoutSets.isEmpty ? null : saveWorkout,
                  child: Text('Save Workout'),
                ),
              ],
            ),
            ElevatedButton(
              onPressed:(){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WorkouthistoryScreen()),  // Assuming you have an AddWorkoutScreen
                );
              },
              child: Text('Updated Workout'),
            ),
          ],

        ),
      ),
    );
  }
}

// A widget for displaying and updating each workout set
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

            // Remove set button
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: onRemove,
                child: Text('Delete set', style: TextStyle(color: Colors.blue)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

