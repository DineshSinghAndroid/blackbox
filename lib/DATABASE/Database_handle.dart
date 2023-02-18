// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
//
// class DatabaseHandler{
//
//
//   //from this database can be open from anywhere in the program
//   static Database? _database;
//   static final DatabaseHandler _databaseHandler = DatabaseHandler._internal();
//
//   factory DatabaseHandler(){
//     return _databaseHandler;
//   }
//
//   DatabaseHandler._internal();
//
//   Future<Database?> openDB () async {
//     _database = await openDatabase(
//       join(await getDatabasesPath() , 'Data.db0')
//     );
//     return _database;
//   }
//
// }