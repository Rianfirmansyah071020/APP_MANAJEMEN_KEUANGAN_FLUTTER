import 'dart:io';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  static Database? _db;

  /// Getter database (lazy initialization)
  static Future<Database> get database async {
    _db ??= await initDB();
    return _db!;
  }

  /// Inisialisasi DB
  static Future<Database> initDB() async {
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }

    final dbPath = await getDatabasesPath();
    await Directory(dbPath).create(recursive: true);

    final path = join(dbPath, 'app.db');

    return await openDatabase(
      path,
      version: 11,
      onCreate: _createDB,
      onUpgrade: _upgradeDB,
    );
  }

  /// Buat tabel saat install pertama kali
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
    CREATE TABLE kategoris (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nama_kategori TEXT NOT NULL,
      deskripsi_kategori TEXT NOT NULL,
      value_kategori TEXT NOT NULL
    )
  ''');

    await db.execute('''
    CREATE TABLE anggotas (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nama_anggota TEXT NOT NULL
    )
  ''');
  }

  /// Upgrade schema kalau ada perubahan versi
  // static Future<void> _upgradeDB(
  //   Database db,
  //   int oldVersion,
  //   int newVersion,
  // ) async {
  //   if (oldVersion < 8) {
  //     // Rename tabel lama
  //     await db.execute('ALTER TABLE kategoris RENAME TO kategori_old');

  //     // Buat tabel baru dengan kolom tambahan
  //     await db.execute('''
  //     CREATE TABLE kategoris (
  //       id INTEGER PRIMARY KEY AUTOINCREMENT,
  //       nama_kategori TEXT NOT NULL,
  //       deskripsi_kategori TEXT NOT NULL,
  //       value_kategori TEXT NOT NULL
  //     )
  //   ''');

  //     // Copy data lama, kolom baru isi default ''
  //     await db.execute('''
  //     INSERT INTO kategoris (id, nama_kategori, deskripsi_kategori, value_kategori)
  //     SELECT id, nama_kategori, deskripsi_kategori, '' FROM kategori_old
  //   ''');

  //     await db.execute('DROP TABLE kategori_old');
  //   }
  // }

  static Future<void> _upgradeDB(
    Database db,
    int oldVersion,
    int newVersion,
  ) async {
    if (oldVersion < 11) {
      // Rename tabel lama
      await db.execute('''
    CREATE TABLE anggotas (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nama_anggota TEXT NOT NULL
    )
  ''');
    }
  }
}
