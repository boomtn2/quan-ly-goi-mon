import 'package:flutter/material.dart';
import 'package:quan_ly_goi_mon/screens/screen_quan_ly_taikhoan/widget_form_input_account.dart';

class ScreenSuaTaiKhoan extends StatelessWidget {
  const ScreenSuaTaiKhoan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: WidgetFormInPutAccount(),
    );
  }
}
