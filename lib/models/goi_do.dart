import 'chi_tiet_goi_do.dart';

class Goido {
    Goido({
       required this.id,
      required  this.ngay,
       required this.trangThai,
      required  this.chitietgoido,
    });

    String id;
    DateTime ngay;
    String trangThai;
    List<ChiTietGoiDo> chitietgoido;

    factory Goido.fromJson(Map<String, dynamic> json) => Goido(
        id: json["id"],
        ngay: DateTime.parse(json["ngay"]),
        trangThai: json["trangThai"],
        chitietgoido: List<ChiTietGoiDo>.from(json["chitietgoido"].map((x) => ChiTietGoiDo.fromJson(x))),
    );

    Map<String, dynamic> toJson({required String idBan}) => {
        "id": id,
        "ngay": "${ngay.year.toString().padLeft(4, '0')}-${ngay.month.toString().padLeft(2, '0')}-${ngay.day.toString().padLeft(2, '0')}",
        "trangThai": trangThai,
        "idBan": idBan
    };
}