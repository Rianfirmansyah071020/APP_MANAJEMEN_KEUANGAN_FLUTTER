import 'package:manajemen_keuangan/data/dao/anggotas_dao.dart';
import 'package:manajemen_keuangan/data/models/anggotas_model.dart';

class AnggotasRepository {
  Future<int> insertAnggota(AnggotasModel anggotas) =>
      AnggotasDao.insertAnggotas(anggotas);

  Future<int> updateAnggota(AnggotasModel anggotas) =>
      AnggotasDao.updateAnggotas(anggotas);

  Future<int> deleteAnggota(int id) => AnggotasDao.deleteAnggotas(id);

  Future<List<AnggotasModel>> getAnggotas({
    String? search,
    int? limit,
    int? offset,
  }) => AnggotasDao.getAnggotas(search: search, limit: limit, offset: offset);

  Future<AnggotasModel?> getAnggotaById(int id) =>
      AnggotasDao.getAnggotaById(id);
}
