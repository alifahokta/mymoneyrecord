class Keuangan {
  int? _id;
  String? _tanggal;
  String? _jumlah;
  String? _deskripsi;
  String? _tipe;

  int? get id => _id;

  String? get tanggal => this._tanggal;
  set tanggal(String? value) => this._tanggal = value;
  String? get jumlah => this._jumlah;
  set jumlah(String? value) => this._jumlah = value;
  String? get deskripsi => this._deskripsi;
  set deskripsi(String? value) => this._deskripsi = value;
  String? get tipe => this._tipe;
  set tipe(String? value) => this._tipe = value;
  Keuangan(this._tanggal, this._jumlah, this._deskripsi,this._tipe);

  Keuangan.fromMap(Map<String, dynamic> map) {
    _id = map['id'];
    _tanggal = map['tanggal'];
    _jumlah = map['jumlah'];
    _deskripsi = map['deskripsi'];
    _tipe = map['tipe'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = _id;
    map['tanggal'] = tanggal;
    map['jumlah'] = jumlah;
    map['deskripsi'] = deskripsi;
    map['tipe'] = tipe;
    return map;
  }
}
