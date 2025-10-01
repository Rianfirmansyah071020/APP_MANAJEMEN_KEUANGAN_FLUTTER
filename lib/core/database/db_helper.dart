import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';

class DbHelper {
  static Database? _db;

  // Getter database
  static Future<Database> get database async {
    _db ??= await initDB();
    return _db!;
  }

  // Inisialisasi DB
  static Future<Database> initDB() async {
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      // Desktop pakai ffi
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'app.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
      onUpgrade: _upgradeDB,
    );
  }

  // Buat tabel pertama kali
  static Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL,
        password TEXT NOT NULL,
        email TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE kategori (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nama TEXT NOT NULL
      )
    ''');
  }

  // Upgrade schema kalau ada perubahan versi
  static Future<void> _upgradeDB(
    Database db,
    int oldVersion,
    int newVersion,
  ) async {
    if (oldVersion < newVersion) {
      await db.execute('ALTER TABLE kategori ADD COLUMN deskripsi TEXT');
    }
  }
}
