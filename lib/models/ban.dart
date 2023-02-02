import 'package:quan_ly_goi_mon/models/goi_do.dart';
import 'package:quan_ly_goi_mon/models/the_loai_ban.dart';

class Ban {
  Ban({
    required this.id,
    required this.soThuTu,
    required this.idTheLoai,
    required this.goido,
    required this.trangThai,
  });

  String id;
  String soThuTu;
  TheLoaiBan idTheLoai;
  String trangThai;
  Goido? goido;

  factory Ban.fromJson(Map<String, dynamic> json) => Ban(
        id: json["id"],
        soThuTu: json["soTT"],
        trangThai: json["trangThai"],
        idTheLoai: TheLoaiBan.fromJson(json["idTheLoai"]),
        goido: json["goido"] == null ? null : Goido.fromJson(json["goido"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "soThuTu": soThuTu,
        "trangThai": trangThai,
        "idTheLoai": idTheLoai.toJson(),
      };

  int getTrangThai() {
    int codeTrangThai = 0;
    try {
      codeTrangThai = int.parse(trangThai);
    } catch (e) {}
    return codeTrangThai;
  }
}
