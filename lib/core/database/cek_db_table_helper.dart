import 'package:manajemen_keuangan/core/database/db_helper.dart';

class CekDbTableHelper {
  /// Ambil daftar semua tabel yang ada di database
  static Future<List<String>> getTables() async {
    try {
      final db = await DbHelper.database;
      final result = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%';",
      );

      return result.map((row) => row['name'] as String).toList();
    } catch (e) {
      print("Error getTables: $e");
      return [];
    }
  }

  /// Ambil struktur kolom sebuah tabel
  static Future<List<Map<String, dynamic>>> getTableInfo(
    String tableName,
  ) async {
    try {
      final db = await DbHelper.database;
      return await db.rawQuery("PRAGMA table_info($tableName);");
    } catch (e) {
      print("Error getTableInfo($tableName): $e");
      return [];
    }
  }
}
