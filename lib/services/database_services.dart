import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseProvider {
  static Future<Database> initDatabase() async {
    // Get database's path
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, 'expense.db');

    // Open the database
    Database database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
            'CREATE TABLE expenses (id INTEGER PRIMARY KEY, cod TEXT, description TEXT, value REAL, created_at DATE)');
      },
    );

    return database;
  }

  static Future<List<Map>> getRecords() async {
    // Get database's instance
    Database db = await initDatabase();

    // List records on database
    List<Map> records = await db.rawQuery('SELECT * FROM expenses');

    // Close database's instance
    await db.close();

    return records;
  }

  static Future<int> insert({
    @required String cod,
    @required String description,
    @required double value,
    @required DateTime createdAt,
  }) async {
    // Get database's instance
    Database db = await initDatabase();

    // Insert data on db
    int insertedId = await db.rawInsert(
      'INSERT INTO expenses (cod, description, value, created_at) VALUES (?, ?, ?, ?)',
      [cod, description, value, createdAt],
    );

    // Close database's instance
    await db.close();

    return insertedId;
  }

  static Future<int> delete({@required String cod}) async {
    // Get database's instance
    Database db = await initDatabase();

    // Delete a record
    int deletedCount =
        await db.rawDelete('DELETE FROM expenses WHERE cod = ?', [cod]);

    // Close database's instance
    await db.close();

    return deletedCount;
  }
}
