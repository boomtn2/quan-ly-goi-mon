import 'package:get/get.dart';
import 'package:quan_ly_goi_mon/models/chi_tiet_goi_do.dart';
import 'package:quan_ly_goi_mon/models/class_default/date_time_get.dart';

import '../models/bep.dart';
import '../models/services/remove_service.dart';

class ControllerBep extends GetxController {
  var dsOder = <Bep>[].obs;
  List<ChiTietGoiDo> ds = [];
  Map<String, List<Bep>> dsFillFood = {};

  String thongBao = "";
  void fetchData() async {
    dsOder.value =
        await RemoteServies.getCTGDFillBep(ngay: GetDateTime.getDateNow());
    fillFood();
    update();
  }

  void updateTrangThaiCTHD(
      {required String id,
      required String soLuong,
      required String trangThai}) async {
    String reponse = await RemoteServies.updateTrangThaiCTGD(
        id: id, soLuongPV: soLuong, trangThai: trangThai);
    if (reponse.compareTo('404') != 0 && reponse.compareTo('1') == 0) {
      thongBao = "Thành công";
    } else {
      thongBao = "Thất bại";
    }
  }

  void updateCTHD(
      {required String id,
      required String soLuong,
      required String trangThai}) async {
    String reponse = await RemoteServies.updateCTHD(
        id: id, soLuongPV: soLuong, trangThai: trangThai);
    if (reponse.compareTo('404') != 0 && reponse.compareTo('1') == 0) {
      thongBao = "Thành công";
    } else {
      thongBao = "Thất bại";
    }
  }

  void fillFood() {
    dsFillFood = {};
    for (var element in dsOder) {
      if (element.chiTietGoiDo.trangThai.compareTo('3') != 0) {
        if (dsFillFood[element.chiTietGoiDo.doo.ten] != null) {
          dsFillFood[element.chiTietGoiDo.doo.ten]?.add(element);
        } else {
          dsFillFood.addAll({
            element.chiTietGoiDo.doo.ten: [element]
          });
        }
      }
    }
    update();
  }

  int soLuong(List<Bep> ds) {
    int S = 0;
    ds.forEach((element) {
      try {
        S += int.parse(element.chiTietGoiDo.soLuong);
      } catch (e) {}
    });
    return S;
  }
}
