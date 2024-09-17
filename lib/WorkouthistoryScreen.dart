import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:flutterapp1/WorkoutScreen.dart';
import 'models/demo.dart';  // Import the workout model

class WorkouthistoryScreen extends StatefulWidget {
  const WorkouthistoryScreen({super.key});

  @override
  _WorkouthistoryScreenState createState() => _WorkouthistoryScreenState();
}

class _WorkouthistoryScreenState extends State<WorkouthistoryScreen> {
 late final Box<Workout> workoutBox;

  @override
  void initState() {
    super.initState();
    openBox();
  }

  Future<void> openBox() async {
    workoutBox = await Hive.openBox<Workout>('workouts');
    setState(() {});  // Rebuild the widget tree once the box is open
  }

  // Function to delete a workout from the Hive box
  Future<void> deleteWorkout(int index) async {
    await workoutBox.deleteAt(index);  // Deletes workout by its index
    setState(() {});  // Refresh the UI after deletion
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workout Details'),
      ),
      body: workoutBox == null
          ? const Center(child: CircularProgressIndicator())
          : workoutBox.isEmpty
          ? Center(child: Text('No workouts found.'))
          : ListView.builder(
        itemCount: workoutBox.length,
        itemBuilder: (context, index) {
          final workout = workoutBox.getAt(index) as Workout;

          return Card(
            child: Padding(
              padding: EdgeInsets.all(16.0),  // Add padding for better spacing
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,  // Align content to the left
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Workout on ${workout.date.toLocal()}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.blue),  // Delete icon
                        onPressed: () async {
                          // Show a confirmation dialog before deleting the workout
                          final confirm = await showDialog<bool>(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Delete Workout'),
                                content: Text('Are you sure you want to delete this workout?'),
                                actions: [
                                  TextButton(
                                    child: Text('Cancel'),
                                    onPressed: () => Navigator.of(context).pop(false),
                                  ),
                                  TextButton(
                                    child: Text('Delete'),
                                    onPressed: () => Navigator.of(context).pop(true),
                                  ),
                                ],
                              );
                            },
                          );

                          if (confirm == true) {
                            await deleteWorkout(index);  // Call delete function
                          }
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0),  // Add space between title and workout sets
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: workout.sets.map((set) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),  // Add spacing between sets
                        child: Text(
                          '${set.exercise}: ${set.weight}kg, ${set.repetitions} reps',
                          style: const TextStyle(fontSize: 12),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the Add Workout screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WorkoutScreen()),
          );
        },
        child: Text('Add workout'),  // Add icon for the button
        tooltip: 'Add New Workout',
      ),
    );
  }
}
