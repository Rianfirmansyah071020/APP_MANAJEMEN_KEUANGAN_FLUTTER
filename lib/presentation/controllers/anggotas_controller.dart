import 'dart:convert';

import 'package:bcrypt/bcrypt.dart';

import 'package:flutter/cupertino.dart';
import 'package:manajemen_keuangan/data/models/anggotas_model.dart';
import 'package:manajemen_keuangan/data/models/anggotas_model.dart';
import 'package:manajemen_keuangan/data/repositories/anggotas_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AnggotasController extends ChangeNotifier {
  final repository = AnggotasRepository();

  final formKey = GlobalKey<FormState>();
  final namaAnggotaController = TextEditingController();

  final searchController = TextEditingController();

  bool isEditing = false;
  int? editingAnggotaId;

  // ✅ Tambahkan untuk pagination
  int rowsPerPage = 5;
  int currentPage = 0;

  Future<bool> insertAnggota() async {
    // cek dulu apakah email sudah ada

    await repository.insertAnggota(
      AnggotasModel(nama_anggota: namaAnggotaController.text),
    );

    notifyListeners();
    resetForm();
    return true;
  }

  Future<bool> updateAnggota() async {
    if (editingAnggotaId == null) return false;

    await repository.updateAnggota(
      AnggotasModel(
        id: editingAnggotaId,
        nama_anggota: namaAnggotaController.text,
      ),
    );

    isEditing = false;
    editingAnggotaId = null;
    notifyListeners();

    return true; // sukses update
  }

  Future<bool> deleteAnggota(int id) async {
    final anggota = await repository.getAnggotaById(id);

    // kalau data tidak ada, hentikan
    if (anggota == null) return false;

    await repository.deleteAnggota(id);
    notifyListeners();

    return true;
  }

  Future<List<AnggotasModel>> getAnggotas() async {
    final search = searchController.text.trim();
    final offset = currentPage * rowsPerPage;

    return await repository.getAnggotas(
      search: search.isNotEmpty ? search : null,
      limit: rowsPerPage,
      offset: offset,
    );
  }

  void setEditMode(AnggotasModel anggota) {
    isEditing = true;
    editingAnggotaId = anggota.id;
    namaAnggotaController.text = anggota.nama_anggota;
    notifyListeners();
  }

  void resetForm() {
    formKey.currentState?.reset();
    namaAnggotaController.clear();
    notifyListeners();
  }

  void cancelEdit() {
    isEditing = false;
    editingAnggotaId = null;
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
    namaAnggotaController.dispose();
    searchController.dispose();
    super.dispose();
  }
}
