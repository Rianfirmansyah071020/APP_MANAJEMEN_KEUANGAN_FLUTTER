import 'package:manajemen_keuangan/core/database/db_helper.dart';
import 'package:manajemen_keuangan/data/models/kategoris_model.dart';
import 'package:sqflite/sqflite.dart';

class KategorisDao {
  static Future<int> insertKategoris(KategorisModel kategori) async {
    final db = await DbHelper.database;
    return await db.insert(
      'kategoris',
      kategori.toMap(),
      conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }

  static Future<int> updateKategoris(KategorisModel kategori) async {
    final db = await DbHelper.database;
    return await db.update(
      'kategoris',
      kategori.toMap(),
      where: 'id = ?',
      whereArgs: [kategori.id],
    );
  }

  static Future<int> deleteKategoris(int id) async {
    final db = await DbHelper.database;
    return await db.delete('kategoris', where: 'id = ?', whereArgs: [id]);
  }

  static Future<List<KategorisModel>> getKategoris({
    String? search,
    int? limit,
    int? offset,
  }) async {
    final db = await DbHelper.database;

    List<Map<String, dynamic>> result;

    if (search == null || search.isEmpty) {
      result = await db.query(
        'kategoris',
        orderBy: 'id DESC',
        limit: limit,
        offset: offset,
      );
    } else {
      result = await db.query(
        'kategoris',
        where:
            'nama_kategori LIKE ? OR deskripsi_kategori LIKE ? OR value_kategori LIKE ?',
        whereArgs: ['%$search%', '%$search%', '%$search%'],
        orderBy: 'id DESC',
        limit: limit,
        offset: offset,
      );
    }

    return result.map((e) => KategorisModel.fromMap(e)).toList();
  }

  static Future<KategorisModel?> getKategoriById(int id) async {
    final db = await DbHelper.database;
    final result = await db.query(
      "kategoris",
      where: "id = ?",
      whereArgs: [id],
    );
    return result.isNotEmpty ? KategorisModel.fromMap(result.first) : null;
  }
}
