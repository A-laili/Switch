import 'package:flutter/material.dart';
import 'package:fit/pages/workout.dart';

class MyHome extends StatelessWidget {
  const MyHome({Key? key});

  @override
  Widget build(BuildContext context) {
    List<int> programList = [1, 2, 3]; // Replace with your actual program list or data

    return Scaffold(
      appBar: AppBar(
        title: Text('Programs'),
      ),
      body: ListView.builder(
        itemCount: programList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              int programSelected = programList[index];
              print('Program selected in the home page: $programSelected');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WorkoutScreen(programId: programSelected),
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
                      'Program ${programList[index]}',
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
