// To parse this JSON data, do
//
//     final do = doFromJson(jsonString);

import 'dart:convert';

import 'combo.dart';

List<Do> doFromJson(String str) => List<Do>.from(json.decode(str).map((x) => Do.fromJson(x)));

String doToJson(List<Do> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Do {
    Do({
      required this.id,
       required this.ten,
      required  this.idTheLoai,
       required this.idDanhMuc,
      required  this.gia,
       required this.trangThai,
      required  this.combo,
    });

    String id;
    String ten;
    String idTheLoai;
    String idDanhMuc;
    String gia;
    String trangThai;
    List<Combo>? combo;

    factory Do.fromJson(Map<String, dynamic> json) => Do(
        id: json["id"],
        ten: json["ten"],
        idTheLoai: json["idTheLoai"],
        idDanhMuc: json["idDanhMuc"],
        gia: json["gia"],
        trangThai: json["trangThai"],
        combo: json["combo"] == null ? null : List<Combo>.from(json["combo"].map((x) => Combo.fromJson(x))),
    );

        factory Do.fromJsonCTGD(Map<String, dynamic> json) => Do(
        id: json["idDo"],
        ten: json["ten"],
        idTheLoai: "",
        idDanhMuc: "",
        gia: json["gia"],
        trangThai: "",
        combo: [],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "ten": ten,
        "idTheLoai": idTheLoai,
        "idDanhMuc": idDanhMuc,
        "gia": gia,
        "trangThai": trangThai,
    };
}


