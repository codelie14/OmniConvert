import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class HistoryService {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  static Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'conversion_history.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE history(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            fileName TEXT,
            sourceFormat TEXT,
            targetFormat TEXT,
            timestamp TEXT,
            status TEXT,
            filePath TEXT
          )
        ''');
      },
    );
  }

  static Future<void> addRecord(Map<String, dynamic> record) async {
    final db = await database;
    await db.insert('history', record, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getHistory() async {
    final db = await database;
    return await db.query('history', orderBy: 'timestamp DESC');
  }

  static Future<void> clearHistory() async {
    final db = await database;
    await db.delete('history');
  }
}
