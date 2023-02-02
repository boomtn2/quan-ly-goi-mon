// To parse this JSON data, do
//
//     final hoaDon = hoaDonFromJson(jsonString);

import 'dart:convert';

import 'package:quan_ly_goi_mon/models/class_default/format_money.dart';
import 'package:quan_ly_goi_mon/models/do.dart';

HoaDon hoaDonFromJson(String str) => HoaDon.fromJson(json.decode(str));

String hoaDonToJson(HoaDon data) => json.encode(data.toJson());

class HoaDon {
  HoaDon({
    required this.hoaDonDo,
    required this.tongTien,
  });

  List<CTHD> hoaDonDo;
  TongTien tongTien;

  factory HoaDon.fromJson(Map<String, dynamic> json) => HoaDon(
        hoaDonDo: List<CTHD>.from(json["cthd"].map((x) => CTHD.fromJson(x))),
        tongTien: TongTien.fromJson(json["tongTien"]),
      );

  Map<String, dynamic> toJson() => {
        "do": List<dynamic>.from(hoaDonDo.map((x) => x.toJson())),
        "tongTien": tongTien.toJson(),
      };
}

class CTHD {
  CTHD({
    required this.doo,
    required this.soLuong,
    required this.soLuongPV,
    required this.thanhTien,
  });
  Do doo;
  String soLuong;
  String soLuongPV;
  String thanhTien;

  factory CTHD.fromJson(Map<String, dynamic> json) => CTHD(
        doo: Do.fromJsonCTGD(json),
        soLuong: json["soLuong"],
        soLuongPV: json["soLuongPV"] ?? "",
        thanhTien: json["thanhTien"],
      );

  Map<String, dynamic> toJson() => {
        "ten": doo.ten,
        "gia": doo.gia,
        "soLuong": soLuong,
        "soLuongPV": soLuongPV,
        "thanhTien": thanhTien,
      };

  String getThanhTien() {
    String giaFM = thanhTien;
    try {
      double dbGia = double.parse(thanhTien);
      giaFM = FormatMoney.formatMoney(dbGia);
    } catch (e) {
      print("loi pare double: HoaDon Class CTHD");
    }
    return giaFM;
  }

  String getGia() {
    String giaFM = doo.gia;
    try {
      double dbGia = double.parse(doo.gia);
      giaFM = FormatMoney.formatMoney(dbGia);
    } catch (e) {
      print("loi pare double: HoaDon Class CTHD ${doo.gia}");
    }
    return giaFM;
  }
}

class TongTien {
  TongTien({
    required this.gia,
  });

  String gia;

  factory TongTien.fromJson(Map<String, dynamic> json) => TongTien(
        gia: json["gia"],
      );

  Map<String, dynamic> toJson() => {
        "gia": gia,
      };

  String getGia() {
    String giaFM = gia;
    try {
      double dbGia = double.parse(gia);
      giaFM = FormatMoney.formatMoney(dbGia);
    } catch (e) {
      print("loi pare double: HoaDon Class TongTien");
    }
    return giaFM;
  }
}
