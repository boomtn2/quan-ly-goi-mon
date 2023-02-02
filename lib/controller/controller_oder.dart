import 'package:get/get.dart';
import 'package:quan_ly_goi_mon/models/class_default/default.dart';
import 'package:quan_ly_goi_mon/models/goi_do.dart';
import 'package:quan_ly_goi_mon/models/chi_tiet_goi_do.dart';
import 'package:quan_ly_goi_mon/models/class_default/date_time_get.dart';

import '../models/do.dart';
import '../models/services/remove_service.dart';

class ControllerOder extends GetxController {
  List<ChiTietGoiDo> dsChiTietGoiDo = [];
  String thongBao = "";
  bool flagTB = false;
  Future<String> newOder({required String idTable}) async {
    String codeOder = idTable + GetDateTime.getCodeDateTime();

    bool isOK = await RemoteServies.insert(
        idBan: idTable,
        goimon: Goido(
            id: codeOder,
            ngay: DateTime.now(),
            trangThai: "0",
            chitietgoido: []));
    if (isOK)
      return codeOder;
    else
      return "-1";
  }

  void rsFlag() {
    thongBao = "";
    flagTB = false;
  }

  void goiDo({required String idGoiDo}) async {
    rsFlag();
    String reponse = "";
    String timeOder = GetDateTime.getTimeNow();
    for (int i = 0; i < dsChiTietGoiDo.length; ++i) {
      dsChiTietGoiDo[i].idGoiDo = idGoiDo;
      dsChiTietGoiDo[i].thoiGian = timeOder;

      reponse = await RemoteServies.insertCTGD(dsChiTietGoiDo[i], idGoiDo);
      if (reponse.compareTo("1") == 0) {
        dsChiTietGoiDo.removeAt(i);
        --i;
        update();
      }
      if (reponse.compareTo("0") == 0) {
        flagTB = true;
        thongBao = thongBaoServer['0'] ?? '';
      }

      if (reponse.compareTo("404") == 0) {
        flagTB = true;
        thongBao = thongBaoServer['404'] ?? '';
      }
    }
  }

  Future<String> huyOder({required String id}) async {
    String reponse = "";
    reponse = await RemoteServies.deleteCTGD(id: id);
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

  bool clear() {
    dsChiTietGoiDo = [];
    update();
    return false;
  }

  int getSoLuong() {
    return dsChiTietGoiDo.length;
  }

  bool checkDo(Do mon) {
    for (int i = 0; i < dsChiTietGoiDo.length; ++i) {
      if (dsChiTietGoiDo[i].doo.id == mon.id) {
        return true;
      }
    }
    return false;
  }

  int getSoLuongOder(String id) {
    for (int i = 0; i < dsChiTietGoiDo.length; ++i) {
      if (dsChiTietGoiDo[i].doo.id == id) {
        return pareInt(dsChiTietGoiDo[i].soLuong);
      }
    }
    return -1;
  }

  int pareInt(String number) {
    try {
      return int.parse(number);
    } catch (e) {
      return 0;
    }
  }

  void themDo(Do mon, int soLuong) {
    dsChiTietGoiDo.add(ChiTietGoiDo(
        id: "",
        soLuong: soLuong.toString(),
        doo: mon,
        idGoiDo: "",
        trangThai: "0",
        thoiGian: "",
        soLuongPV: "0"));
    update();
  }

  bool xoaDo(String id) {
    for (int i = 0; i < dsChiTietGoiDo.length; ++i) {
      if (dsChiTietGoiDo[i].doo.id == id) {
        dsChiTietGoiDo.removeAt(i);
        update();
        return true;
      }
    }
    return false;
  }

  bool suaSoLuongDo(String id, int soLuong) {
    for (int i = 0; i < dsChiTietGoiDo.length; ++i) {
      if (dsChiTietGoiDo[i].doo.id == id) {
        dsChiTietGoiDo[i].soLuong = soLuong.toString();
        update();
        return true;
      }
    }
    return false;
  }
}
