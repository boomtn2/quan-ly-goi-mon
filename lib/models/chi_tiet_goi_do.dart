import 'package:quan_ly_goi_mon/models/do.dart';

class ChiTietGoiDo {
    ChiTietGoiDo({
      required this.id,
       required this.soLuong,
       required this.doo,
       required this.thoiGian,
       required this.idGoiDo,
       required this.trangThai,
       required this.soLuongPV,
    });

    String id;
    String soLuong;
    String thoiGian;
    String idGoiDo;
    String trangThai;
    Do doo;
    String soLuongPV;

    factory ChiTietGoiDo.fromJson(Map<String, dynamic> json) => ChiTietGoiDo(
        id: json["id"],
        soLuong: json["soLuong"],
        thoiGian: json["thoiGian"],
        idGoiDo: json["idGoiDo"],
        trangThai: json["trangThai"],
        doo: Do.fromJsonCTGD(json),
        soLuongPV: json["soLuongPV"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "soLuong": soLuong,
        "idDo": doo.id,
        "thoiGian": thoiGian,
        "idGoiDo": idGoiDo,
        "trangThai": trangThai,
        "soLuongPV": soLuongPV,
    };
}