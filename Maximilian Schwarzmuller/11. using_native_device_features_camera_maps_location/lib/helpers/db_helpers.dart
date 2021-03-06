import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  // database handler/creator
  static Future<sql.Database> database() async {
    // getting the database path
    // basically a folder
    final dbPath = await sql.getDatabasesPath();

    // let join with folder and db name
    return await sql.openDatabase(path.join(dbPath, 'places.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT, locationLatitude REAL, locationLongitude REAL, address TEXT)');
    }, version: 1);
  }

  // it is a static methid without need not be intantiate
  static Future<void> insert(String table, Map<String, Object> data) async {
    // conflictAlgorithm means if we trying to insert data for an id which already is in the database table. then we'll override the existing entry. Basically it does not happen.
    // as a static method we have to directly called
    final db = await DBHelper.database();
    db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }
}
