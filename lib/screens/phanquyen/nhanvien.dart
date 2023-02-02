import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quan_ly_goi_mon/controller/controller_ban.dart';

import '../screen_bedo/screen_bedo.dart';
import '../screen_taikhoan/screen_taikhoan.dart';
import '../screens_room/screen_room.dart';

List<Widget> screens = const [ScreenRoom(), ScreenBedo(), ScreenTaiKhoan()];

class NhanVien extends StatefulWidget {
  const NhanVien({super.key});

  @override
  State<NhanVien> createState() => _HomeState();
}

class _HomeState extends State<NhanVien> {
  int _bottomNavIndex = 0;
  final controllerBan = Get.find<ControllerBan>();
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//           if(controllerBan.flagTB)
//       {
//  Get.snackbar("Báo lỗi", controllerBan.thongBao);
//       }
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_bottomNavIndex],
      bottomNavigationBar: botom(),
    );
  }

  Widget botom() {
    return NavigationBarTheme(
      data: const NavigationBarThemeData(
        indicatorColor: Colors.orange,
      ),
      child: NavigationBar(
        selectedIndex: _bottomNavIndex,
        onDestinationSelected: (value) => setState(() {
          _bottomNavIndex = value;
        }),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.table_bar), label: "Bàn"),
          NavigationDestination(
              icon: Icon(Icons.notification_add), label: "Bê đồ"),
          NavigationDestination(icon: Icon(Icons.person), label: "Tài khoản"),
        ],
      ),
    );
  }
}
