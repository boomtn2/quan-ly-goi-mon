import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/controller_taikhoan.dart';

class ScreenInfoAccount extends StatelessWidget {
  const ScreenInfoAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GetBuilder<ControllerTaiKhoan>(
        builder: (controller) => Column(
          children: [
            ListTile(
              title: Text(controller.thongTinTaiKhoan.taiKhoan),
            ),
            ListTile(
              leading:
                  Text(controller.thongTinTaiKhoan.theLoaiTaiKhoan.tenTheLoai),
              title: Text(controller.thongTinTaiKhoan.theLoaiTaiKhoan.id),
            ),
          ],
        ),
      ),
    );
  }
}
