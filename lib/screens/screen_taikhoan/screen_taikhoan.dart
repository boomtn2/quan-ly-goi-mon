import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quan_ly_goi_mon/controller/controller_taikhoan.dart';
import 'package:quan_ly_goi_mon/screens/screen_quan_ly_ban/screen_quan_ly_ban.dart';
import 'package:quan_ly_goi_mon/screens/screen_quanly_do/screen_quanly_do.dart';

import '../screen_quan_ly_the_loai/screen_qltl.dart';

class ScreenTaiKhoan extends StatelessWidget {
  const ScreenTaiKhoan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(76, 158, 158, 158),
      body: GetBuilder<ControllerTaiKhoan>(
        builder: (controller) => ListView(
          children: [
            Card(
              color: Colors.orange,
              child: SizedBox(
                height: 70,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Tài khoản:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            controller.thongTinTaiKhoan.taiKhoan,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text("Mức:",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(controller
                              .thongTinTaiKhoan.theLoaiTaiKhoan.tenTheLoai),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
                visible: controller.thongTinTaiKhoan.theLoaiTaiKhoan.id
                        .compareTo("3") ==
                    0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(() => ScreenQuanLyDo());
                      },
                      child: textButton(
                        text: "Quản lý món",
                      ),
                    ),
                  ],
                )),
            Visibility(
                visible: controller.thongTinTaiKhoan.theLoaiTaiKhoan.id
                        .compareTo("2") ==
                    0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(() => const ScreenQuanLyBan());
                      },
                      child: textButton(
                        text: "Quản lý bàn",
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => const ScreenQuanLyTheLoai());
                      },
                      child: textButton(
                        text: "Quản thể loại",
                      ),
                    ),
                  ],
                )),
            InkWell(child: textButton(text: "Đổi mật khẩu")),
            InkWell(
                onTap: () {
                  Get.back();
                },
                child: textButton(text: "Đăng xuất")),
          ],
        ),
      ),
    );
  }

  Widget textButton({required String text}) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: Icon(Icons.arrow_right),
          ),
        ],
      ),
    );
  }
}
