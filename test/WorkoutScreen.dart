import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_test/hive_test.dart'; // For mock Hive
import 'package:flutterapp1/WorkoutScreen.dart'; // Adjust the import path
import 'package:flutterapp1/models/demo.dart'; // Your model (WorkoutSet, Workout)
import 'package:hive/hive.dart';
import 'package:flutterapp1/WorkouthistoryScreen.dart';
import 'dart:html' as html;

void main() {
  setUp(() async {
    // Initialize Hive for testing
    await setUpTestHive();
    Hive.registerAdapter(WorkoutAdapter()); // Register the adapters for the models
    Hive.registerAdapter(WorkoutSetAdapter());
  });

  tearDown(() async {
    await tearDownTestHive(); // Clean up the Hive environment
  });

  testWidgets('Should add a new workout set when "Add Set" button is pressed', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: WorkoutScreen()));

    // Initially, no WorkoutSetCard should be present
    expect(find.byType(WorkoutSetCard), findsNothing);

    // Press the "Add Set" button
    await tester.tap(find.text('Add Set'));
    await tester.pump(); // Rebuild after state change

    // Verify that one WorkoutSetCard is added
    expect(find.byType(WorkoutSetCard), findsOneWidget);
  });

  testWidgets('Should remove a workout set when "Delete set" button is pressed', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: WorkoutScreen()));

    // Press the "Add Set" button to add a workout set
    await tester.tap(find.text('Add Set'));
    await tester.pump(); // Rebuild

    // Now verify that a WorkoutSetCard is present
    expect(find.byType(WorkoutSetCard), findsOneWidget);

    // Press the "Delete set" button
    await tester.tap(find.text('Delete set'));
    await tester.pump(); // Rebuild after removal

    // Verify that no WorkoutSetCard is present
    expect(find.byType(WorkoutSetCard), findsNothing);
  });

  testWidgets('Should display a Snackbar when the workout is saved', (WidgetTester tester) async {
    // Open the WorkoutScreen
    await tester.pumpWidget(MaterialApp(home: WorkoutScreen()));

    // Press the "Add Set" button to add a workout set
    await tester.tap(find.text('Add Set'));
    await tester.pump(); // Rebuild

    // Enter some values for weight and repetitions
    await tester.enterText(find.byType(TextField).at(0), '50'); // Enter weight
    await tester.enterText(find.byType(TextField).at(1), '10'); // Enter repetitions

    // Press the "Save Workout" button
    await tester.tap(find.text('Save Workout'));
    await tester.pump(); // Wait for the save action

    // Verify that the SnackBar shows the message 'Workout Saved!'
    expect(find.text('Workout Saved!'), findsOneWidget);
  });

  testWidgets('Should navigate to WorkouthistoryScreen when "Updated Workout" button is pressed', (WidgetTester tester) async {
    // Pump the WorkoutScreen
    await tester.pumpWidget(MaterialApp(home: WorkoutScreen()));

    // Tap the "Updated Workout" button
    await tester.tap(find.text('Updated Workout'));
    await tester.pumpAndSettle(); // Wait for the navigation to complete

    // Verify that WorkouthistoryScreen is displayed
    expect(find.byType(WorkouthistoryScreen), findsOneWidget);
  });
}
