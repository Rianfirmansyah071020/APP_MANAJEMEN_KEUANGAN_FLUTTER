import 'package:manajemen_keuangan/core/database/db_helper.dart';
import 'package:manajemen_keuangan/data/models/users_model.dart';
import 'package:sqflite/sqflite.dart';

class UsersDao {
  static Future<int> insertUsers(UsersModel user) async {
    final db = await DbHelper.database;
    return await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }

  static Future<int> updateUsers(UsersModel user) async {
    final db = await DbHelper.database;
    return await db.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  static Future<int> deleteUsers(int id) async {
    final db = await DbHelper.database;
    return await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }

  static Future<List<UsersModel>> getUsers({
    String? search,
    int? limit,
    int? offset,
  }) async {
    final db = await DbHelper.database;

    List<Map<String, dynamic>> result;

    if (search == null || search.isEmpty) {
      result = await db.query(
        'users',
        orderBy: 'id DESC',
        limit: limit,
        offset: offset,
      );
    } else {
      result = await db.query(
        'users',
        where: 'username LIKE ? OR email LIKE ?',
        whereArgs: ['%$search%', '%$search%'],
        orderBy: 'id DESC',
        limit: limit,
        offset: offset,
      );
    }

    return result.map((e) => UsersModel.fromMap(e)).toList();
  }

  static Future<UsersModel?> getUserByEmail(String email) async {
    final db = await DbHelper.database;
    final result = await db.query(
      "users",
      where: "email = ?",
      whereArgs: [email],
    );
    return result.isNotEmpty ? UsersModel.fromMap(result.first) : null;
  }

  static Future<UsersModel?> getUserById(int id) async {
    final db = await DbHelper.database;
    final result = await db.query("users", where: "id = ?", whereArgs: [id]);
    return result.isNotEmpty ? UsersModel.fromMap(result.first) : null;
  }
}
