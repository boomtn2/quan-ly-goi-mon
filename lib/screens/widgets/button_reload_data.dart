import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:quan_ly_goi_mon/controller/controller_ban.dart';

class ButtonReloadData extends StatefulWidget {
  const ButtonReloadData({super.key});

  @override
  State<ButtonReloadData> createState() => _ButtonReloadDataState();
}

class _ButtonReloadDataState extends State<ButtonReloadData> {
  final ControllerBan _controllerBan = Get.find<ControllerBan>();

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () async {
          _controllerBan.data();

          if (_controllerBan.flagTB) {
            Future.delayed(const Duration(seconds: 10)).then(
                (value) => Get.snackbar("Báo lỗi", _controllerBan.thongBao));
          }
        },
        icon: Icon(Icons.replay_outlined));
  }
}
