import 'dart:convert';

import 'package:bcrypt/bcrypt.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:manajemen_keuangan/data/models/users_model.dart';
import 'package:manajemen_keuangan/data/repositories/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  final repository = UsersRepository();
  bool verifyPassword(String plainPassword, String storedHash) {
    // kalau hash format bcrypt ($2a$, $2b$, $2y$)
    if (storedHash.startsWith(r"$2a$") ||
        storedHash.startsWith(r"$2b$") ||
        storedHash.startsWith(r"$2y$")) {
      return BCrypt.checkpw(plainPassword, storedHash);
    }

    // default: anggap SHA-256 (hex string)
    final bytes = utf8.encode(plainPassword);
    final digest = sha256.convert(bytes).toString();
    return digest == storedHash;
  }

  Future<UsersModel?> login(String email, String password) async {
    final user = await repository.getUserByEmail(email);

    if (user == null) {
      return null; // user tidak ditemukan
    }

    final isPasswordValid = verifyPassword(password, user.password);

    if (!isPasswordValid) {
      return null; // password salah
    }

    // ✅ Simpan user ke SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('userId', user.id!);
    await prefs.setString('username', user.username);
    await prefs.setString('email', user.email);

    return user; // sukses login
  }

  Future<UsersModel?> getLoggedInUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId');
    final email = prefs.getString('email');
    final username = prefs.getString('username');

    if (userId != null && email != null && username != null) {
      return UsersModel(
        id: userId,
        email: email,
        username: username,
        password: "", // password tidak perlu disimpan
      );
    }
    return null; // belum login
  }

  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }
}
