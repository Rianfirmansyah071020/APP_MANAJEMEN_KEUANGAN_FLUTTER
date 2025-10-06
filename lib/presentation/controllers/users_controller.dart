import 'dart:convert';

import 'package:bcrypt/bcrypt.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:manajemen_keuangan/data/models/users_model.dart';
import 'package:manajemen_keuangan/data/repositories/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UsersController extends ChangeNotifier {
  final repository = UsersRepository();

  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final searchController = TextEditingController();

  bool isEditing = false;
  int? editingUserId;

  // ✅ Tambahkan untuk pagination
  int rowsPerPage = 5;
  int currentPage = 0;

  String hashPassword(String password) {
    // SHA256 hashing
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<bool> insertUser() async {
    // cek dulu apakah email sudah ada
    final existingUser = await repository.getUserByEmail(emailController.text);
    if (existingUser != null) {
      // email sudah dipakai → gagal insert
      return false;
    }

    await repository.insertUser(
      UsersModel(
        username: usernameController.text,
        password: hashPassword(passwordController.text),
        email: emailController.text,
      ),
    );

    notifyListeners();
    resetForm();
    return true;
  }

  Future<bool> updateUser() async {
    if (editingUserId == null) return false;

    if (emailController.text == "admin@gmail.com") {
      return false; // gagal update
    }

    await repository.updateUser(
      UsersModel(
        id: editingUserId,
        username: usernameController.text,
        password: hashPassword(passwordController.text),
        email: emailController.text,
      ),
    );

    isEditing = false;
    editingUserId = null;
    notifyListeners();

    return true; // sukses update
  }

  Future<bool> deleteUser(int id) async {
    final user = await repository.getUserById(id);

    // kalau data tidak ada, hentikan
    if (user == null) return false;

    // proteksi agar user admin tidak bisa dihapus
    if (user.email == 'admin@gmail.com') {
      return false;
    }

    await repository.deleteUser(id);
    notifyListeners();

    return true;
  }

  Future<List<UsersModel>> getUsers() async {
    final search = searchController.text.trim();
    final offset = currentPage * rowsPerPage;

    return await repository.getUsers(
      search: search.isNotEmpty ? search : null,
      limit: rowsPerPage,
      offset: offset,
    );
  }

  void setEditMode(UsersModel user) {
    isEditing = true;
    editingUserId = user.id;
    usernameController.text = user.username;
    emailController.text = user.email;
    passwordController.clear();
    notifyListeners();
  }

  void resetForm() {
    formKey.currentState?.reset();
    usernameController.clear();
    passwordController.clear();
    emailController.clear();
    notifyListeners();
  }

  void cancelEdit() {
    isEditing = false;
    editingUserId = null;
    resetForm();
    notifyListeners();
  }

  // ✅ Tambahkan setter untuk ganti halaman
  void setPage(int page) {
    currentPage = page;
    notifyListeners();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    emailController.dispose();
    searchController.dispose();
    super.dispose();
  }
}
