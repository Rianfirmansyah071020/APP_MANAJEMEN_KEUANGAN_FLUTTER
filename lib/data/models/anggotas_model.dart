class AnggotasModel {
  final int? id;
  final String nama_anggota;
  AnggotasModel({this.id, required this.nama_anggota});

  Map<String, dynamic> toMap() {
    return {'id': id, 'nama_anggota': nama_anggota};
  }

  factory AnggotasModel.fromMap(Map<String, dynamic> map) {
    return AnggotasModel(id: map['id'], nama_anggota: map['nama_anggota']);
  }
}
