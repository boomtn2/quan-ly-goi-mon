import 'dart:async';
import 'dart:convert';
import 'package:awesome_select/awesome_select.dart';
import 'package:get/state_manager.dart';
import 'package:quan_ly_goi_mon/models/class_default/default.dart';
import 'package:quan_ly_goi_mon/models/ban.dart';
import 'package:quan_ly_goi_mon/models/hoa_don.dart';
import 'package:quan_ly_goi_mon/models/the_loai_ban.dart';
import 'package:quan_ly_goi_mon/models/services/remove_service.dart';

import '../models/class_default/result_sever.dart';

class ControllerBan extends GetxController {
  var dsBan = <Ban>[].obs;
  var TLB = <TheLoaiBan>[].obs;
  int selectTable = 0;
  var dsOder = HoaDon(hoaDonDo: [], tongTien: TongTien(gia: "0")).obs;
  var hoaDon = HoaDon(hoaDonDo: [], tongTien: TongTien(gia: "0")).obs;
  bool flagTB = false;
  String thongBao = "";

  Ban insBan = Ban(
      id: "",
      soThuTu: "",
      idTheLoai: TheLoaiBan(id: "", moTa: "", tenTheLoai: ""),
      goido: null,
      trangThai: "");

  Ban setDefautTable() {
    return Ban(
        id: "",
        soThuTu: "",
        idTheLoai: TheLoaiBan(id: "", moTa: "", tenTheLoai: ""),
        goido: null,
        trangThai: "");
  }

  void data() {
    resetFlag();
    fetchBan();
    if (flagTB == false) {
      fetchBanTLB();
    }
  }

  void resetFlag() {
    flagTB = false;
    thongBao = "";
  }

  void fetchBan() async {
    String st = await RemoteServies.getData();
    resetFlag();
    try {
      if (st.compareTo("404") != 0) {
        var banObjsJson = jsonDecode(st)['ban'] as List;
        dsBan.value =
            banObjsJson.map((tagJson) => Ban.fromJson(tagJson)).toList();
      } else {
        thongBao = thongBaoServer['404'] ?? '';
        flagTB = true;
      }
    } catch (e) {
      thongBao = "Lỗi do code";
      flagTB = true;
    }
  }

  void autoUpdate() {
    resetFlag();
    Timer.periodic(const Duration(seconds: 20), (timer) async {
      fetchBan();
      if (flagTB) {
        timer.cancel();
      }
    });
  }

  void fetchBanTLB() async {
    String st = await RemoteServies.getTheLoaiBan();

    if (st.compareTo("404") != 0) {
      var json = jsonDecode(await RemoteServies.getTheLoaiBan()) as List;
      try {
        TLB.value = json.map((e) => TheLoaiBan.fromJson(e)).toList();
      } catch (e) {
        thongBao = "Lỗi do code";
        flagTB = true;
      }
    } else {
      thongBao = thongBaoServer['404'] ?? '';
      flagTB = true;
    }
  }

  int getIndex() => dsBan.length;

  Ban getBan() {
    return dsBan[selectTable];
  }

  String getIdGoiMon() {
    var goiMon = getBan().goido;
    if (goiMon != null) {
      return goiMon.id;
    }

    return "ERROR";
  }

  void getOder() async {
    resetFlag();
    String idGoiMon = getIdGoiMon();
    if (idGoiMon.compareTo("ERROR") != 0) {
      String st = await RemoteServies.getOder(idGoiMon: idGoiMon);
      if (st.compareTo("404") != 0) {
        try {
          var banObjsJson = jsonDecode(st);
          dsOder.value = HoaDon.fromJson(banObjsJson);
        } catch (e) {
          flagTB = true;
          thongBao = e.toString();
        }
      } else {
        flagTB = true;
        thongBao = thongBaoServer['404'] ?? 'Lỗi kết nối';
      }
    } else {
      flagTB = true;
      thongBao = "Lỗi do code GetIDGOIMON $idGoiMon";
    }
  }

  void taoCTHD() async {
    resetFlag();
    String idGoiMon = getIdGoiMon();
    if (idGoiMon.compareTo("ERROR") != 0) {
      String st = "";
      try {
        dsOder.value.hoaDonDo.forEach((element) async {
          st = await RemoteServies.insertCTHD(
              idGoiMon: idGoiMon,
              idDo: element.doo.id,
              soLuong: element.soLuong);
          if (st.compareTo("404") == 0) {
            flagTB = true;
            thongBao = thongBaoServer['404'] ?? '';
          }

          if (st.compareTo("0") == 0) {
            flagTB = true;
            thongBao = thongBaoServer['0'] ?? '';
          }
        });

        getCTHD(idGoiMon);
      } catch (e) {
        flagTB = true;
        thongBao = "Lỗi code tạo hóa đơn";
      }
    } else {
      flagTB = true;
      thongBao = "Lỗi idGoiMon";
    }
  }

  void getCTHD(String idGoiMon) async {
    String st = await RemoteServies.getCTHD(idGoiMon: idGoiMon);

    if (st.compareTo("404") != 0) {
      try {
        var banObjsJson = jsonDecode(st);
        print(banObjsJson);
        hoaDon.value = HoaDon.fromJson(banObjsJson);
      } catch (e) {
        flagTB = true;
        thongBao = e.toString();
      }
    } else {
      flagTB = true;
      thongBao = thongBaoServer['404'] ?? '';
    }

    print(thongBao);
  }

  Future<String> suaHoaDon(
      {required String idDo, required String soLuong}) async {
    try {
      String code = await RemoteServies.updateHoaDon(
          idDo: idDo, soLuong: soLuong, idGoiDo: getIdGoiMon());
      getCTHD(getIdGoiMon());

      return thongBaoServer[code] ?? 'Lỗi';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> thanhToan() async {
    try {
      String code = await RemoteServies.thanhToan(getIdGoiMon());
      return thongBaoServer[code] ?? 'Lỗi';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> hideTable() async {
    dsBan[selectTable].trangThai = '4';
    String st = await RemoteServies.updateBan(
        id: dsBan[selectTable].id,
        idTheLoai: dsBan[selectTable].idTheLoai.id,
        soTT: dsBan[selectTable].soThuTu,
        trangThai: dsBan[selectTable].trangThai);
    resetFlag();
    flagTB = true;
    thongBao = thongBaoServer[st] ?? '';
    return thongBao;
  }

  Future<String> onTable() async {
    dsBan[selectTable].trangThai = '0';
    String st = await RemoteServies.updateBan(
        id: dsBan[selectTable].id,
        idTheLoai: dsBan[selectTable].idTheLoai.id,
        soTT: dsBan[selectTable].soThuTu,
        trangThai: dsBan[selectTable].trangThai);
    resetFlag();
    flagTB = true;
    thongBao = thongBaoServer[st] ?? '';
    return thongBao;
  }

  Future<String> editTable() async {
    resetFlag();
    String st = await RemoteServies.updateBan(
        id: insBan.id,
        idTheLoai: insBan.idTheLoai.id,
        soTT: insBan.soThuTu,
        trangThai: insBan.trangThai);
    fetchBan();
    flagTB = true;
    thongBao = thongBaoServer[st] ?? '';
    return thongBao;
  }

  List<S2Choice<String>> getDMChoise() {
    List<S2Choice<String>> days = [];

    for (var element in TLB) {
      days.add(S2Choice<String>(value: element.id, title: element.tenTheLoai));
    }

    if (days.isEmpty) {
      days.add(S2Choice<String>(value: '', title: ''));
    }

    return days;
  }

  Future<String> suaTheLoaiBan({required TheLoaiBan theLoaiBan}) async {
    String reponse = "";
    reponse = await RemoteServies.updateTheLoaiBan(tlb: theLoaiBan);
    if (reponse.compareTo("1") == 0) {
      return thongBaoServer['1'] ?? '';
    }
    if (reponse.compareTo("0") == 0) {
      flagTB = true;
      return thongBaoServer['0'] ?? '';
    }

    if (reponse.compareTo("404") == 0) {
      flagTB = true;
      return thongBaoServer['404'] ?? '';
    }
    return 'Lỗi rồi';
  }

  Future<String> themTheLoaiBan({required TheLoaiBan theLoaiBan}) async {
    String reponse = "";
    reponse = await RemoteServies.insertTheLoaiBan(tlb: theLoaiBan);
    if (reponse.compareTo("1") == 0) {
      return thongBaoServer['1'] ?? '';
    }
    if (reponse.compareTo("0") == 0) {
      flagTB = true;
      return thongBaoServer['0'] ?? '';
    }

    if (reponse.compareTo("404") == 0) {
      flagTB = true;
      return thongBaoServer['404'] ?? '';
    }
    return 'Lỗi rồi';
  }

  Future<String> themBan() async {
    String reponse = "";
    reponse = await RemoteServies.insertBan(
        id: '',
        idTheLoai: insBan.idTheLoai.id,
        soTT: insBan.soThuTu,
        trangThai: '0');
    fetchBan();
    if (reponse.compareTo("1") == 0) {
      return thongBaoServer['1'] ?? '';
    }
    if (reponse.compareTo("0") == 0) {
      flagTB = true;
      return thongBaoServer['0'] ?? '';
    }

    if (reponse.compareTo("404") == 0) {
      flagTB = true;
      return thongBaoServer['404'] ?? '';
    }
    return 'Lỗi rồi';
  }
}
