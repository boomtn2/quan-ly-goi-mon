import 'package:get/get.dart';
import 'package:quan_ly_goi_mon/models/thong_ke.dart';
import 'package:quan_ly_goi_mon/models/class_default/date_time_get.dart';
import 'package:quan_ly_goi_mon/models/services/remove_service.dart';

class ControllerThongKe extends GetxController {
  ThongKe thongKe = ThongKe(
      doanhThu: DoanhThu(doanhThu: ""), doanhThuDo: [], doanhThuTuan: []);
  ThongKe thongKeThang = ThongKe(
      doanhThu: DoanhThu(doanhThu: ""), doanhThuDo: [], doanhThuTuan: []);
  Map<double, String> tiles = {
    0: "T2",
    1: "T3",
    2: "T4",
    3: "T5",
    4: "T6",
    5: "T7",
    6: "CN"
  };

  Map<double, String> tilesMonth = {
    0: "T1",
    1: "T2",
    2: "T3",
    3: "T4",
    4: "T5",
    5: "T6",
    6: "T7",
    7: "T8",
    8: "T9",
    9: "T10",
    10: "T11",
    11: "T12"
  };

  List<double> dataFlowMonth = [10, 20, 30, 40, 50, 10, 20, 30, 40, 50, 10, 20];

  List<double> dataFlow = [10, 20, 30, 40, 50];

  @override
  void onInit() {
    // TODO: implement onInit
    getData();
    super.onInit();
  }

  void getData() async {
    thongKe = await RemoteServies.getThongKe(
        ngayNow: GetDateTime.getDateNow(), ngay: GetDateTime.getDayMonday());
    thongKeThang =
        await RemoteServies.getThongKeThang(ngay: GetDateTime.getDateNow());
    dataFlow = thongKe.getDataWeek();
    dataFlowMonth = thongKeThang.getDataMonth();
    update();
  }
}
