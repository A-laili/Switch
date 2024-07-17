import 'package:flutter/material.dart';
import 'package:fit/pages/switchexercice.dart';
import 'package:fit/provider/exercise_provider.dart';
import 'package:provider/provider.dart';

class ExerciceScreen extends StatelessWidget {
  final int programId;
  final int workoutId;
  const ExerciceScreen({Key? key, required this.programId , required this.workoutId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Program ID in ExerciceScreen: $programId');

    final provider = Provider.of<DatabaseProvider>(context);
    List<int> exerciceList = provider.programExercises[programId]?[workoutId] ?? [];
    print('ExerciceList for programId $programId: $exerciceList');

    return Scaffold(
      appBar: AppBar(
        title: Text('Exercises'),
      ),
      body: ListView.builder(
        itemCount: exerciceList.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text('Exercise ${exerciceList[index]}'),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SwitchExo(
                        oldExercice: exerciceList[index],
                        programId: programId,
                        workoutId: workoutId,
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
