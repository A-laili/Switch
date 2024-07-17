
import 'package:flutter/material.dart';

class DatabaseProvider with ChangeNotifier {
  Map<int, Map<int, List<int>>> programExercises = {
    1: {
      1: [1222, 233, 3],
      2: [444, 555, 666],
    },
    2:{
      1: [777, 888, 999],
    },
  };

  void getData(
    int exerciseOld, 
    int exerciseNew,
    int workoutId,
    int programId
  ) {
    replaceExercise(programId, workoutId, exerciseOld, exerciseNew);
    notifyListeners();
  }

  void replaceExercise(int programId, int workoutId, int exerciseOld, int exerciseNew) {
    if (programExercises.containsKey(programId) && programExercises[programId]!.containsKey(workoutId)) {
      int index = programExercises[programId]![workoutId]!.indexOf(exerciseOld);
      if (index != -1) {
        programExercises[programId]![workoutId]![index] = exerciseNew;
        notifyListeners();
      }
    }
  }
  void processDataFromDatabase(List<Map<String, dynamic>> programs) {
    for (var program in programs) {
      int programId = program['program_id'] ?? 0;
      int workoutId = program['workout_id'] ?? 0;
      int exerciseOld = program['exercise_oldId'] ?? 0;
      int exerciseNew = program['exercise_newId'] ?? 0;

      replaceExercise(programId, workoutId, exerciseOld, exerciseNew);
    }
  }
}
