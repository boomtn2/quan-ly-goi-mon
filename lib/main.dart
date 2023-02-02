import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quan_ly_goi_mon/controller/controller_ban.dart';
import 'package:quan_ly_goi_mon/controller/controller_bep.dart';
import 'package:quan_ly_goi_mon/controller/controller_taikhoan.dart';
import 'package:quan_ly_goi_mon/controller/controller_mon.dart';
import 'package:quan_ly_goi_mon/controller/controller_oder.dart';
import 'package:quan_ly_goi_mon/controller/controller_thongke.dart';
import 'package:quan_ly_goi_mon/screens/screen_login/screen_login.dart';
import 'screens/screen_bep/screen_bep.dart';
import 'screens/screen_thongke/screen_thongke.dart';
import 'screens/screens_room/screen_room.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final controlerBan = Get.put(ControllerBan());
  final controllerOder = Get.put(ControllerOder());
  final controllerMon = Get.put(ControllerMon());
  final controllerThongKe = Get.put(ControllerThongKe());
  final controllerBep = Get.put(ControllerBep());
  final controllerTaiKhoan = Get.put(ControllerTaiKhoan());
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Oder food HIT',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ScreenLogin(),
    );
  }
}
