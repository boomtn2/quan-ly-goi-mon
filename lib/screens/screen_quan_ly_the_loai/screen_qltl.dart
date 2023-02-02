import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quan_ly_goi_mon/screens/screen_quan_ly_the_loai/screen_sua_tlb.dart';

import '../../controller/controller_ban.dart';
import 'screen_themtl.dart';

class ScreenQuanLyTheLoai extends StatelessWidget {
  const ScreenQuanLyTheLoai({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quản lý thể loại"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => ScreenThemTheLoai());
        },
        tooltip: 'Thêm thể loại',
        child: const Icon(Icons.add),
      ),
      body: GetX<ControllerBan>(
        builder: (controller) => ListView(
          children: [
            Column(
              children: controller.TLB
                  .map((element) => InkWell(
                        onTap: () {
                          Get.to(() => ScreenSuaTheLoai(theLoaiBan: element));
                        },
                        child: Card(
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(element.tenTheLoai),
                              ),
                            ],
                          ),
                        ),
                      ))
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}
