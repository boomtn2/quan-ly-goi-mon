import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quan_ly_goi_mon/controller/controller_taikhoan.dart';
import 'package:quan_ly_goi_mon/screens/screen_quan_ly_taikhoan/widget_form_input_account.dart';

class ScreenSuaTaiKhoan extends StatelessWidget {
  const ScreenSuaTaiKhoan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sửa tài khoản"),
      ),
      body: WidgetFormInPutAccount(function: () async {
        final controllerTaiKhoan = Get.find<ControllerTaiKhoan>();
        String tb = await controllerTaiKhoan.suaTaiKhoan();
        Get.snackbar('Thông báo', tb);
      }),
    );
  }
}
