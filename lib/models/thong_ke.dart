// To parse this JSON data, do
//
//     final thongKe = thongKeFromJson(jsonString);

import 'dart:convert';

import 'package:quan_ly_goi_mon/models/class_default/date_time_get.dart';
import 'package:quan_ly_goi_mon/models/class_default/format_money.dart';

ThongKe thongKeFromJson(String str) => ThongKe.fromJson(json.decode(str));

class ThongKe {
  ThongKe({
    required this.doanhThu,
    required this.doanhThuTuan,
    required this.doanhThuDo,
  });

  DoanhThu doanhThu;
  List<DoanhThuTuan> doanhThuTuan;
  List<DoanhThuDo> doanhThuDo;

  factory ThongKe.fromJson(Map<String, dynamic> json) => ThongKe(
        doanhThu: DoanhThu.fromJson(json["doanh_thu"]),
        doanhThuTuan: List<DoanhThuTuan>.from(
            json["doanh_thu_tuan"].map((x) => DoanhThuTuan.fromJson(x))),
        doanhThuDo: List<DoanhThuDo>.from(
            json["doanh_thu_do"].map((x) => DoanhThuDo.fromJson(x))),
      );

  List<double> getDataWeek() {
    List<double> dataWeek = [0, 0, 0, 0, 0, 0, 0];
    double sDoanhThu = 0;
    doanhThuTuan.forEach((element) {
      sDoanhThu += element.getDoanhThuDB();
    });

    doanhThuTuan.forEach((element) {
      int index = GetDateTime.getIndexWeek(DateTime.parse(element.ngay));
      dataWeek[index] = (element.getDoanhThuDB() / sDoanhThu) * 100;
    });

    return dataWeek;
  }

  List<double> getDataMonth() {
    List<double> dataFlowMonth = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
    double sDoanhThu = 0;
    doanhThuTuan.forEach((element) {
      sDoanhThu += element.getDoanhThuDB();
    });
    doanhThuTuan.forEach((element) {
      int index = 0;
      try {
        index = int.parse(element.ngay) - 1;
      } catch (e) {
        print(e);
      }

      dataFlowMonth[index] = (element.getDoanhThuDB() / sDoanhThu) * 100;
    });
    return dataFlowMonth;
  }
}

class DoanhThu {
  DoanhThu({
    required this.doanhThu,
  });

  String doanhThu;

  factory DoanhThu.fromJson(Map<String, dynamic> json) => DoanhThu(
        doanhThu: json["doanhThu"] ?? '0',
      );

  Map<String, dynamic> toJson() => {
        "doanhThu": doanhThu,
      };

  String getDoanhThu() {
    double money = 0;
    try {
      money = double.parse(doanhThu);
    } catch (e) {
      money = 0;
    }

    return FormatMoney.formatM(money);
  }

  double getDoanhThuDB() {
    double money = 0;
    try {
      money = double.parse(doanhThu);
    } catch (e) {
      money = 0;
    }
    return money;
  }
}

class DoanhThuDo {
  DoanhThuDo({
    required this.ten,
    required this.soLuong,
    required this.doanhThu,
  });

  String ten;
  String soLuong;
  String doanhThu;

  factory DoanhThuDo.fromJson(Map<String, dynamic> json) => DoanhThuDo(
        ten: json["ten"],
        soLuong: json["soLuong"],
        doanhThu: json["doanhThu"],
      );

  Map<String, dynamic> toJson() => {
        "ten": ten,
        "soLuong": soLuong,
        "doanhThu": doanhThu,
      };

  String getDoanhThu() {
    double money = 0;
    try {
      money = double.parse(doanhThu);
    } catch (e) {
      money = 0;
    }

    return FormatMoney.formatM(money);
  }

  double getDoanhThuDB() {
    double money = 0;
    try {
      money = double.parse(doanhThu);
    } catch (e) {
      money = 0;
    }
    return money;
  }
}

class DoanhThuTuan {
  DoanhThuTuan({
    required this.ngay,
    required this.doanhThu,
  });

  String ngay;
  String doanhThu;

  factory DoanhThuTuan.fromJson(Map<String, dynamic> json) => DoanhThuTuan(
        ngay: json["ngay"],
        doanhThu: json["doanhThu"],
      );

  String getDoanhThu() {
    double money = 0;
    try {
      money = double.parse(doanhThu);
    } catch (e) {
      money = 0;
    }

    return FormatMoney.formatM(money);
  }

  double getDoanhThuDB() {
    double money = 0;
    try {
      money = double.parse(doanhThu);
    } catch (e) {
      money = 0;
    }
    return money;
  }
}
