**User workout tracking application**
Overview:

**Hive Setup:** Initialize Hive, register the required adapters, and store the workout data. 
Data Models: Define the models for WorkoutSet and Workout and generate Hive adapters. 
UI Components: Create the workout screen where users can log their exercises, weights, and repetitions. 
Data Persistence: Store the workout data in Hive when the user saves a workout.

****Two Hive models:**
**
WorkoutSet: This represents a single set of exercises. 
Workout: This represents a complete workout, which contains multiple WorkoutSets.

**Steps to Create the Screen:**

Define Models: To represent each workout and set. 
Build UI: To show a list of sets with form fields (exercise, weight, and repetitions). 
Handle Logic: To add or remove sets and save the workout details.
**
**Key Features in the Code:****
WorkoutSet Model: Represents each set with an exercise, weight, and repetitions.
WorkoutScreen: Users can log their workouts with exercises, weights, and reps and save them to Hive. 
WorkoutHistoryScreen: Displays all saved workouts, retrieved from Hive. 
WorkoutSetCard: A card widget for each set, allowing the user to select an exercise and input the weight and repetitions. 
Hive: Hive is used for local, offline data storage for fast, reliable access to saved workouts.

**Widget testing**Test Setup: Mocking Hive for Testing
I used hive_test to simulate the Hive database during testing.
By calling setUpTestHive() and tearDownTestHive(), I initialize and clean up the mocked Hive environment for each test case.

I have written tests to verify the functionality of the WorkoutScreen, including adding/removing sets, saving a workout, and navigating to another screen.
