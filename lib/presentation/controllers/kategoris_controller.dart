import 'dart:convert';

import 'package:bcrypt/bcrypt.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:manajemen_keuangan/data/models/kategoris_model.dart';
import 'package:manajemen_keuangan/data/repositories/kategoris_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KategorisController extends ChangeNotifier {
  final repository = KategorisRepository();

  final formKey = GlobalKey<FormState>();
  final namaKategoriController = TextEditingController();
  final deskripsiKategoriController = TextEditingController();
  final valueKategoriController = TextEditingController();
  final searchController = TextEditingController();

  bool isEditing = false;
  int? editingKategoriId;

  // ✅ Tambahkan untuk pagination
  int rowsPerPage = 5;
  int currentPage = 0;

  Future<bool> insertKategori() async {
    // cek dulu apakah email sudah ada

    await repository.insertKategori(
      KategorisModel(
        nama_kategori: namaKategoriController.text,
        deskripsi_kategori: deskripsiKategoriController.text,
        value_kategori: valueKategoriController.text,
      ),
    );

    notifyListeners();
    resetForm();
    return true;
  }

  Future<bool> updateKategori() async {
    if (editingKategoriId == null) return false;

    await repository.updateKategori(
      KategorisModel(
        id: editingKategoriId,
        nama_kategori: namaKategoriController.text,
        deskripsi_kategori: deskripsiKategoriController.text,
        value_kategori: valueKategoriController.text,
      ),
    );

    isEditing = false;
    editingKategoriId = null;
    notifyListeners();

    return true; // sukses update
  }

  Future<bool> deleteKategori(int id) async {
    final kategori = await repository.getKategoriById(id);

    // kalau data tidak ada, hentikan
    if (kategori == null) return false;

    await repository.deleteKategori(id);
    notifyListeners();

    return true;
  }

  Future<List<KategorisModel>> getKategoris() async {
    final search = searchController.text.trim();
    final offset = currentPage * rowsPerPage;

    return await repository.getKategoris(
      search: search.isNotEmpty ? search : null,
      limit: rowsPerPage,
      offset: offset,
    );
  }

  void setEditMode(KategorisModel kategori) {
    isEditing = true;
    editingKategoriId = kategori.id;
    namaKategoriController.text = kategori.nama_kategori;
    deskripsiKategoriController.text = kategori.deskripsi_kategori;
    valueKategoriController.text = kategori.value_kategori;
    notifyListeners();
  }

  void resetForm() {
    formKey.currentState?.reset();
    namaKategoriController.clear();
    deskripsiKategoriController.clear();
    valueKategoriController.clear();
    notifyListeners();
  }

  void cancelEdit() {
    isEditing = false;
    editingKategoriId = null;
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
    namaKategoriController.dispose();
    deskripsiKategoriController.dispose();
    valueKategoriController.dispose();
    searchController.dispose();
    super.dispose();
  }
}
