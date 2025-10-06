import 'package:manajemen_keuangan/data/dao/kategoris_dao.dart';
import 'package:manajemen_keuangan/data/models/kategoris_model.dart';

class KategorisRepository {
  Future<int> insertKategori(KategorisModel kategoris) =>
      KategorisDao.insertKategoris(kategoris);

  Future<int> updateKategori(KategorisModel kategoris) =>
      KategorisDao.updateKategoris(kategoris);

  Future<int> deleteKategori(int id) => KategorisDao.deleteKategoris(id);

  Future<List<KategorisModel>> getKategoris({
    String? search,
    int? limit,
    int? offset,
  }) => KategorisDao.getKategoris(search: search, limit: limit, offset: offset);

  Future<KategorisModel?> getKategoriById(int id) =>
      KategorisDao.getKategoriById(id);
}
