import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'WorkoutScreen.dart';
import 'WorkouthistoryScreen.dart';
import 'models/demo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive and register adapters
  await Hive.initFlutter();
  Hive.registerAdapter(WorkoutSetAdapter());  // Register the WorkoutSet adapter
  Hive.registerAdapter(WorkoutAdapter());     // Register the Workout adapter

  await Hive.openBox<Workout>('workouts');  // Open Hive box for workouts

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Workout Logger',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WorkouthistoryScreen(),
    );
  }
}
