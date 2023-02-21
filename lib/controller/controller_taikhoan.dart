import 'dart:convert';

import 'package:get/get.dart';
import 'package:quan_ly_goi_mon/models/class_default/default.dart';
import 'package:quan_ly_goi_mon/models/tai_khoan.dart';
import 'package:quan_ly_goi_mon/models/services/remove_service.dart';
import 'package:quan_ly_goi_mon/spref.dart';

import '../key_spref.dart';

class ControllerTaiKhoan extends GetxController {
  String ipServer = "";
  TaiKhoan thongTinTaiKhoan = TaiKhoan(
      id: "",
      taiKhoan: "",
      matKhau: "",
      theLoaiTaiKhoan: TheLoaiTaiKhoan(id: "", tenTheLoai: ""));
  String thongBao = "";
  var danhSachTaiKhoan = <TaiKhoan>[].obs;
  late TaiKhoan tempTaiKhoan = defaultTaiKhoan();
  void rsThongTinTaiKhoan() {
    thongTinTaiKhoan = TaiKhoan(
        id: "",
        taiKhoan: "",
        matKhau: "",
        theLoaiTaiKhoan: TheLoaiTaiKhoan(id: "", tenTheLoai: ""));
  }

  void setIpServer(String ip) {
    ipServer = ip;
    var data = SPref.instance;
    RemoteServies.ipServer = ip;
    data.setString(ipKey, 'ipServer');
    RemoteServies.setUrlAPI();
  }

  TaiKhoan defaultTaiKhoan() {
    return TaiKhoan(
        id: "",
        taiKhoan: "",
        matKhau: "",
        theLoaiTaiKhoan: TheLoaiTaiKhoan(id: "", tenTheLoai: ""));
  }

  Future<String> xoaTaiKhoan() async {
    String reponse = "";
    reponse = await RemoteServies.deleteTaiKhoan(taiKhoan: tempTaiKhoan);
    if (reponse.compareTo("1") == 0) {
      return thongBaoServer['1'] ?? '';
    }
    if (reponse.compareTo("0") == 0) {
      return thongBaoServer['0'] ?? '';
    }

    if (reponse.compareTo("404") == 0) {
      return thongBaoServer['404'] ?? '';
    }
    return 'Lỗi rồi';
  }

  Future<String> suaTaiKhoan() async {
    String reponse = "";
    reponse = await RemoteServies.updateTaiKhoan(taiKhoan: tempTaiKhoan);
    if (reponse.compareTo("1") == 0) {
      return thongBaoServer['1'] ?? '';
    }
    if (reponse.compareTo("0") == 0) {
      return thongBaoServer['0'] ?? '';
    }

    if (reponse.compareTo("404") == 0) {
      return thongBaoServer['404'] ?? '';
    }
    return 'Lỗi rồi';
  }

  Future<String> themTaiKhoan() async {
    String reponse = "";
    reponse = await RemoteServies.insertTaiKhoan(taiKhoan: tempTaiKhoan);
    if (reponse.compareTo("1") == 0) {
      return thongBaoServer['1'] ?? '';
    }
    if (reponse.compareTo("0") == 0) {
      return thongBaoServer['0'] ?? '';
    }

    if (reponse.compareTo("404") == 0) {
      return thongBaoServer['404'] ?? '';
    }
    return 'Lỗi rồi';
  }

  void getDSTaiKhoan() async {
    var login = await RemoteServies.getDSTaiKhoan();

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
