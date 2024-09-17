import 'package:hive/hive.dart';

part 'demo.g.dart';// Generated file for Hive adapters

@HiveType(typeId: 0)
class WorkoutSet {
  @HiveField(0)
  String exercise;

  @HiveField(1)
  double weight;

  @HiveField(2)
  int repetitions;

  WorkoutSet({required this.exercise, required this.weight, required this.repetitions});
}

@HiveType(typeId: 1)
class Workout {
  @HiveField(0)
  DateTime date;

  @HiveField(1)
  List<WorkoutSet> sets;

  Workout({required this.date, required this.sets});
}