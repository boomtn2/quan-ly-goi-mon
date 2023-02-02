import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quan_ly_goi_mon/controller/controller_mon.dart';

class ButtonReload extends StatefulWidget {
  const ButtonReload({super.key});

  @override
  State<ButtonReload> createState() => _ButtonReloadState();
}

class _ButtonReloadState extends State<ButtonReload> {
  final _controller = Get.find<ControllerMon>();
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          _controller.fetchMonAn();
        },
        icon: Icon(Icons.replay_outlined));
  }
}
