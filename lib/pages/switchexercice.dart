import 'package:fit/services/db_dervice.dart';
import 'package:flutter/material.dart';



class SwitchExo extends StatelessWidget {
  const SwitchExo({super.key, required this.oldExercice, required this.programId, required this.workoutId});
  final int oldExercice;
  final int programId;
  final int workoutId;
   @override
  Widget build(BuildContext context) {
    List<int> exerciceList = [1222, 23443, 3, 66, 5455 ];
    return Scaffold(
      body: ListView.builder(
          itemCount: exerciceList.length,
          itemBuilder: (context, index) {
            return
            
             Row(
               children: [
                 Text('${exerciceList[index]}'),
                 const Spacer(),
                 IconButton(onPressed: () async{
                  DatabaseService db  = DatabaseService();
                 await db.insertData(programId,workoutId,oldExercice, exerciceList[index], context);
                  Navigator.pop(context);
                 }, icon: const Icon(Icons.check))
               ],
             );
          }),
    );
  }
}