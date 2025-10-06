class KategorisModel {
  final int? id;
  final String nama_kategori;
  final String deskripsi_kategori;
  final String value_kategori;
  KategorisModel({
    this.id,
    required this.nama_kategori,
    required this.deskripsi_kategori,
    required this.value_kategori,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama_kategori': nama_kategori,
      'deskripsi_kategori': deskripsi_kategori,
      'value_kategori': value_kategori,
    };
  }

  factory KategorisModel.fromMap(Map<String, dynamic> map) {
    return KategorisModel(
      id: map['id'],
      nama_kategori: map['nama_kategori'],
      deskripsi_kategori: map['deskripsi_kategori'],
      value_kategori: map['value_kategori'],
    );
  }
}
