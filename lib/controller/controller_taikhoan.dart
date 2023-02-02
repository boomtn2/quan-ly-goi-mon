import 'dart:convert';

import 'package:get/get.dart';
import 'package:quan_ly_goi_mon/models/class_default/default.dart';
import 'package:quan_ly_goi_mon/models/tai_khoan.dart';
import 'package:quan_ly_goi_mon/models/services/remove_service.dart';

class ControllerTaiKhoan extends GetxController {
  TaiKhoan thongTinTaiKhoan = TaiKhoan(
      id: "",
      taiKhoan: "",
      matKhau: "",
      theLoaiTaiKhoan: TheLoaiTaiKhoan(id: "", tenTheLoai: ""));
  String thongBao = "";
  var danhSachTaiKhoan = <TaiKhoan>[].obs;

  void rsThongTinTaiKhoan() {
    thongTinTaiKhoan = TaiKhoan(
        id: "",
        taiKhoan: "",
        matKhau: "",
        theLoaiTaiKhoan: TheLoaiTaiKhoan(id: "", tenTheLoai: ""));
  }

  void getDSTaiKhoan() async {
    var login = await RemoteServies.getDSTaiKhoan();
    rsThongTinTaiKhoan();
    if (login.compareTo('404') != 0) {
      try {
        var objsJson = jsonDecode(login) as List;

        if (json != null) {
          danhSachTaiKhoan.value =
              objsJson.map((tagJson) => TaiKhoan.fromMap(tagJson)).toList();
          thongBao = thongBaoServer['1'] ?? '';
        } else {
          thongBao = thongBaoServer['0'] ?? '';
        }
      } catch (e) {
        thongBao = "Lỗi code :(";
      }
    }
    thongBao = thongBaoServer['404'] ?? '';
  }

  Future<bool> login(
      {required String taiKhoan, required String matKhau}) async {
    thongBao = "";
    var login = await RemoteServies.login(taiKhoan: taiKhoan, matKhau: matKhau);
    rsThongTinTaiKhoan();
    if (login.compareTo('404') != 0) {
      try {
        var json = jsonDecode(login)['login'];

        if (json != null) {
          thongTinTaiKhoan = TaiKhoan.fromMap(json);
          thongBao = thongBaoServer['1'] ?? '';
          return true;
        } else {
          thongBao = thongBaoServer['0'] ?? '';
        }
      } catch (e) {
        thongBao = "Lỗi code :(";
      }
    }
    thongBao = thongBaoServer['404'] ?? '';
    return false;
  }
}
