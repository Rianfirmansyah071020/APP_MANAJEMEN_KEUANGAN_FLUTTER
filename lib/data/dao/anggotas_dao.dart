import 'package:manajemen_keuangan/core/database/db_helper.dart';
import 'package:manajemen_keuangan/data/models/anggotas_model.dart';
// import 'package:manajemen_keuangan/data/models/anggotas_model.dart';
import 'package:sqflite/sqflite.dart';

class AnggotasDao {
  static Future<int> insertAnggotas(AnggotasModel anggota) async {
    final db = await DbHelper.database;
    return await db.insert(
      'anggotas',
      anggota.toMap(),
      conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }

  static Future<int> updateAnggotas(AnggotasModel anggota) async {
    final db = await DbHelper.database;
    return await db.update(
      'anggotas',
      anggota.toMap(),
      where: 'id = ?',
      whereArgs: [anggota.id],
    );
  }

  static Future<int> deleteAnggotas(int id) async {
    final db = await DbHelper.database;
    return await db.delete('anggotas', where: 'id = ?', whereArgs: [id]);
  }

  static Future<List<AnggotasModel>> getAnggotas({
    String? search,
    int? limit,
    int? offset,
  }) async {
    final db = await DbHelper.database;

    List<Map<String, dynamic>> result;

    if (search == null || search.isEmpty) {
      result = await db.query(
        'anggotas',
        orderBy: 'id DESC',
        limit: limit,
        offset: offset,
      );
    } else {
      result = await db.query(
        'anggotas',
        where: 'nama_anggota LIKE ?',
        whereArgs: ['%$search%'],
        orderBy: 'id DESC',
        limit: limit,
        offset: offset,
      );
    }

    return result.map((e) => AnggotasModel.fromMap(e)).toList();
  }

  static Future<AnggotasModel?> getAnggotaById(int id) async {
    final db = await DbHelper.database;
    final result = await db.query("anggotas", where: "id = ?", whereArgs: [id]);
    return result.isNotEmpty ? AnggotasModel.fromMap(result.first) : null;
  }
}
