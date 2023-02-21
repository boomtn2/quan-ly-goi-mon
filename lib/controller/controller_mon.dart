import 'dart:convert';

import 'package:get/get.dart';
import 'package:quan_ly_goi_mon/models/class_default/date_time_get.dart';
import 'package:quan_ly_goi_mon/models/danh_muc.dart';
import 'package:quan_ly_goi_mon/models/do.dart';
import 'package:quan_ly_goi_mon/models/the_loai_mon.dart';
import '../models/class_default/default.dart';
import '../models/services/remove_service.dart';
import 'package:awesome_select/awesome_select.dart' show S2Choice;

class ControllerMon extends GetxController {
  var dsCombo = <Do>[].obs;
  var dsMon = <Do>[].obs;
  var dsDoUong = <Do>[].obs;
  var dmCombo = <DanhMuc>[].obs;
  var dmMonLe = <DanhMuc>[].obs;
  var dmDoUong = <DanhMuc>[].obs;
  var dsDM = <DanhMuc>[].obs;
  var dsTL = <TheLoaiMon>[].obs;

  String thongBao = "";
  Do insDo = Do(
      id: "",
      ten: "",
      idTheLoai: "",
      idDanhMuc: "",
      gia: "",
      trangThai: "",
      combo: []);
  @override
  void onInit() {
    //fetchMonAn();
    super.onInit();
  }

  void updateUI() {
    update();
  }

  void themDo() async {
    thongBao = "";
    insDo.id = GetDateTime.getCodeDateTime();
    String stJson = await RemoteServies.insertDo(insDo: insDo);
    if (stJson.compareTo('1') == 0) {
      if (insDo.combo != null) {
        insDo.combo!.forEach((element) async {
          stJson =
              await RemoteServies.insertCombo(combo: element, idDo: insDo.id);
        });
      }
    }
    thongBao = thongBaoServer[stJson] ?? 'Lỗi không xác định';
  }

  Future<String> thongBaoConMon() async {
    insDo.trangThai = '0';
    String stJson = await RemoteServies.updateDo(insDo: insDo);
    thongBao = thongBaoServer[stJson] ?? '';
    return thongBao;
  }

  Future<String> thongBaoHetMon() async {
    insDo.trangThai = '1';
    String stJson = await RemoteServies.updateDo(insDo: insDo);
    thongBao = thongBaoServer[stJson] ?? '';
    return thongBao;
  }

  void suaDo() async {
    thongBao = "";
    String stJson = await RemoteServies.updateDo(insDo: insDo);
    if (insDo.combo != null) {
      await RemoteServies.deleteCombo(idDo: insDo.id);
      insDo.combo!.forEach((element) async {
        await RemoteServies.insertCombo(combo: element, idDo: insDo.id);
      });
    }
    thongBao = thongBaoServer[stJson] ?? 'Lỗi không xác định';
  }

  String getNameDM({required String id}) {
    String st = '';
    dsDM.forEach((element) {
      if (id.compareTo(element.id) == 0) {
        st = element.tenDanhMuc;
      }
    });

    return st;
  }

  String getIDDM({required String tenDanhMuc}) {
    String st = '';
    dsDM.forEach((element) {
      if (tenDanhMuc.compareTo(element.tenDanhMuc) == 0) {
        st = element.id;
      }
    });

    return st;
  }

  String getNameTLM({required String id}) {
    String st = '';
    dsTL.forEach((element) {
      if (id.compareTo(element.id) == 0) {
        st = element.tenTheLoai;
      }
    });

    return st;
  }

  String getIDTLM({required String tenTL}) {
    String st = '';
    dsTL.forEach((element) {
      if (tenTL.compareTo(element.tenTheLoai) == 0) {
        st = element.id;
      }
    });

    return st;
  }

  void xoaCombo({required String tenCombo}) {
    if (insDo.combo != null) {
      for (int i = 0; i < insDo.combo!.length; ++i) {
        if (tenCombo.compareTo(insDo.combo![i].tenThanhPhan) == 0) {
          insDo.combo!.removeAt(i);
        }
      }
    }
  }

  void fetchMonAn() async {
    try {
      String stJson = await RemoteServies.getDataDo();

      var jsonD = jsonDecode(stJson);

      dmCombo.value =
          List<DanhMuc>.from(jsonD["dm_combo"].map((x) => DanhMuc.fromJson(x)));
      dmMonLe.value =
          List<DanhMuc>.from(jsonD["dm_monle"].map((x) => DanhMuc.fromJson(x)));
      dmDoUong.value = List<DanhMuc>.from(
          jsonD["dm_douong"].map((x) => DanhMuc.fromJson(x)));

      dsDoUong.value =
          List<Do>.from(jsonD["douong"].map((x) => Do.fromJson(x)));
      dsMon.value = List<Do>.from(jsonD["monle"].map((x) => Do.fromJson(x)));
      dsCombo.value = List<Do>.from(jsonD["combo"].map((x) => Do.fromJson(x)));
    } catch (e) {
      print("Lỗi json đồ");
    }
  }

  void fetchTLM() async {
    try {
      String stJson = await RemoteServies.getDataTheLoaiMon();

      var jsonD = jsonDecode(stJson);
      dsTL.value =
          List<TheLoaiMon>.from(jsonD.map((x) => TheLoaiMon.fromJson(x)));
    } catch (e) {
      print("Lỗi json đồ");
    }
  }

  void fetchDM() async {
    try {
      String stJson = await RemoteServies.getDataDanhMuc();

      var jsonD = jsonDecode(stJson);
      dsDM.value = List<DanhMuc>.from(jsonD.map((x) => DanhMuc.fromJson(x)));
    } catch (e) {
      print("Lỗi json đồ");
    }
  }

  List<S2Choice<String>> getDMChoise() {
    List<S2Choice<String>> days = [];

    dsDM.forEach((element) {
      days.add(S2Choice<String>(value: element.id, title: element.tenDanhMuc));
    });
    if (days.isEmpty) {
      days.add(S2Choice<String>(value: '', title: ''));
    }

    return days;
  }

  List<S2Choice<String>> getTLMChoise() {
    List<S2Choice<String>> days = [];

    dsTL.forEach((element) {
      days.add(S2Choice<String>(value: element.id, title: element.tenTheLoai));
    });
    if (days.isEmpty) {
      days.add(S2Choice<String>(value: '', title: ''));
    }

    return days;
  }
}
