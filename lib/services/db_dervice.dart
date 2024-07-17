// ignore_for_file: avoid_print

import 'package:fit/provider/exercise_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;

  DatabaseService._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = join(await getDatabasesPath(), 'fitness_app.db');
    print('Database path: $dbPath');

    
    return openDatabase(
      dbPath,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE program (
            id INTEGER PRIMARY KEY,
            program_id INTEGER, 
            workout_id INTEGER,
            exercise_oldId INTEGER,
            exercise_newId INTEGER
            
          )
        ''');
        
      },
      version: 2,
    );
  }

  Future<void> insertData(int programId, int workoutId, int oldId, int newId , BuildContext context) async {
    final db = await database;

    await db.insert(
      'program',
      {
        'program_id': programId,
        'workout_id': workoutId,
        'exercise_oldId': oldId,
        'exercise_newId': newId,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    fetchDataAndSetProvider( context , programId , workoutId);
  }

  Future<void> fetchDataAndSetProvider(BuildContext context, int programId, int workoutId) async {
  final db = await database;
  List<Map<String, dynamic>> data = await db.query(
    'program',
    where: 'program_id = ? AND workout_id = ?',
    whereArgs: [programId, workoutId],
  );

  if (data.isNotEmpty) {
    Provider.of<DatabaseProvider>(context, listen: false).processDataFromDatabase(data);
  }
}
}
