class Poli {
  String? id;
  String namaPoli;
  String deskripsiPoli;

  Poli({this.id, required this.namaPoli, required this.deskripsiPoli});

  factory Poli.fromJson(Map<String, dynamic> json) => Poli(
      id: json["id"],
      namaPoli: json["nama_poli"],
      deskripsiPoli: json["deskripsi_poli"]);

  Map<String, dynamic> toJson() => {"nama_poli": namaPoli, "deskripsi_poli": deskripsiPoli};
}
