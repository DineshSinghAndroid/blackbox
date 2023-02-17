import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const dbName = "myDatabase.db";
  static const dbVersion = 1;
  static const dbTable = "myTable";
  static const ids = "id";
  static const deviceName = "name";
  // static const deviceQrCode = "QrCode";

//constructor
  static final DatabaseHelper instance = DatabaseHelper();

//database initialise
  static Database? _database;

  Future<Database?> get database async {
    _database ??= await initDB();
    return _database;

  }

  initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, dbName);
    return await openDatabase(path, version: dbVersion, onCreate: onCreate);
  }

  Future onCreate(Database db, int version) async {
    db.execute(
        '''
       CREATE TABLE $dbTable (
       $ids INTEGER PRIMARY KEY,
       $deviceName TEXT NOT NULL
        )
       '''
    );
  }

//insert method
  insertRecord(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.insert(dbTable, row);
  }

//read // query method
  Future<List<Map<String, dynamic>>?> queryDatabase() async {
    Database? db = await instance.database;
    return await db?.query(dbTable);
  }

//update method
  Future<int?> updateRecord(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    int id = row[ids];
    return await db?.update(dbTable, row, where: '$ids = ?', whereArgs: [id]);
  }

  //delete method
  Future<int?> deleteRecord(int id) async {
    Database? db = await instance.database;
    return await db?.delete(dbTable, where: '$ids = ?', whereArgs: [id]);
  }
}
