import 'package:fit/pages/exercice.dart';
import 'package:fit/services/db_dervice.dart';
import 'package:flutter/material.dart';

class WorkoutScreen extends StatelessWidget {
  final int programId;
  const WorkoutScreen({Key? key, required this.programId }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<int> workoutList = [1, 2, 3]; // Replace with your actual workout list or data
    print('Program ID in WorkoutScreen: $programId');

    return Scaffold(
      appBar: AppBar(
        title: Text('Workouts'),
      ),
      body: ListView.builder(
        itemCount: workoutList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () async {
              int workoutSelected = workoutList[index];
              DatabaseService db = DatabaseService();
              await db.fetchDataAndSetProvider(context, programId , workoutSelected);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExerciceScreen(programId: programId, workoutId : workoutSelected),
                ),
              );
            },
            child: Card(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Workout ${workoutList[index]}',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Icon(Icons.arrow_forward),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
