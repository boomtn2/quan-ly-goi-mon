import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quan_ly_goi_mon/controller/controller_oder.dart';

import '../screen_goimon/screen_oder.dart';

class ButtonOrder extends StatelessWidget {
  const ButtonOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Badge(
          elevation: 4,
          badgeContent: GetBuilder<ControllerOder>(
              builder: (controller) => Text('${controller.getSoLuong()}')),
          child: GestureDetector(
            onTap: () {
              Get.to(() => ScreenDSMonOder());
            },
            child: Icon(Icons.menu_book_sharp),
          )),
    );
  }
}
