import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'police_app.db');
    return await openDatabase(
      path,
      version: 2,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT UNIQUE,
            last_name TEXT,
            registration_number TEXT,
            photo_path TEXT,
            password TEXT,
            role TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE incidents (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            description TEXT,
            date TEXT,
            photo_path TEXT,
            audio_path TEXT,
            user_id INTEGER,
            FOREIGN KEY (user_id) REFERENCES users (id)
          )
        ''');
      },
    );
  }

  Future<int> insert(String table, Map<String, dynamic> data) async {
    try {
      final db = await database;
      return await db.insert(table, data);
    } catch (e) {
      throw Exception('No se pudieron insertar datos: $e');
    }
  }

  Future<List<Map<String, dynamic>>> query(String table,
      {String? where, List<dynamic>? whereArgs}) async {
    try {
      final db = await database;
      return await db.query(table, where: where, whereArgs: whereArgs);
    } catch (e) {
      throw Exception('No se pudieron consultar los datos: $e');
    }
  }

  Future<int> update(String table, Map<String, dynamic> data, String where,
      List<dynamic> whereArgs) async {
    try {
      final db = await database;
      return await db.update(table, data, where: where, whereArgs: whereArgs);
    } catch (e) {
      throw Exception('No se pudieron actualizar los datos:$e');
    }
  }

  Future<int> delete(
      String table, String? where, List<dynamic>? whereArgs) async {
    try {
      final db = await database;
      return await db.delete(table, where: where, whereArgs: whereArgs);
    } catch (e) {
      throw Exception('No se pudieron eliminar los datos: $e');
    }
  }

  // Función para obtener todos los datos de una tabla específica
  Future<List<Map<String, dynamic>>> getAllDataFromTable(
      String tableName) async {
    final db = await database;
    return await db.query(tableName);
  }
}
