import 'dart:io';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseProvider {
  static const dbName = "todoDatabase.db";
  static const dbVersion = 1;
  static const dbTable = "to_do_List";

  static const columnId = "id";
  static const columnTask = "task";

  static final DatabaseProvider instance = DatabaseProvider();

  static Database? _database;

  Future<Database> get database async {
    return _database ??= await initDB();
  }

  Future initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, dbName);
    return await openDatabase(path, version: dbVersion, onCreate: onCreate);
  }

  onCreate(Database db, int version) {
    db.execute("""
        CREATE TABLE $dbTable(
          $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
          $columnTask TEXT NOT NULL
        )
    """);
  }

  Future insertTask(Map<String, dynamic> row) async {
    Database db = await instance.database;

    return db.insert(dbTable, row);
  }

  Future<List<Map<String, dynamic>>> queryTask() async {
    Database db = await instance.database;
    return await db.query(dbTable);
  }

  Future<int> updateTask(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    return db.update(dbTable, row, where: "$columnId = ?", whereArgs: [id]);
  }

  Future<int> deleteTask(int id) async {
    Database db = await instance.database;
    return db.delete(dbTable, where: "$columnId = ?", whereArgs: [id]);
  }
}
