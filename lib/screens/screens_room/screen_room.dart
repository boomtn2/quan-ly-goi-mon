import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quan_ly_goi_mon/controller/controller_ban.dart';
import '../../models/class_default/default.dart';
import '../screen_goimon/screen_oder_table.dart';
import '../widgets/button_reload_data.dart';

class ScreenRoom extends StatefulWidget {
  const ScreenRoom({super.key});

  @override
  State<ScreenRoom> createState() => _ScreenRoomState();
}

class _ScreenRoomState extends State<ScreenRoom> {
  final controllerBan = Get.find<ControllerBan>();
  late Timer timeAuto;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timeAuto = Timer.periodic(const Duration(seconds: 5), (timer) async {
      controllerBan.fetchBan();
    });

    if (controllerBan.flagTB) {
      Future.delayed(const Duration(seconds: 10))
          .then((value) => Get.snackbar("Báo lỗi", controllerBan.thongBao));
      timeAuto.cancel();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timeAuto.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.orange,
        title: Text("Danh Sách Trạng Thái Bàn"),
        actions: [ButtonReloadData()],
      ),
      backgroundColor: Colors.grey,
      body: GetX<ControllerBan>(
        builder: (scontroller) => ListView(children: [
          for (var ins in scontroller.TLB)
            Column(
              children: [
                Card(
                    color: Colors.orange,
                    child: ListTile(
                      title: Text(ins.tenTheLoai),
                      trailing: Icon(Icons.arrow_drop_down),
                    )),
                Row(
                  children: [
                    Wrap(
                      children: [
                        for (int index = 0;
                            index < controllerBan.dsBan.length;
                            ++index)
                          controllerBan.dsBan[index].idTheLoai.id == ins.id &&
                                  controllerBan.dsBan[index].trangThai != '4'
                              ? GestureDetector(
                                  onTap: () {
                                    controllerBan.selectTable = index;

                                    Get.to(() => ScreenOrder());
                                  },
                                  child: ban(
                                      tenBan:
                                          controllerBan.dsBan[index].soThuTu,
                                      theLoai: controllerBan
                                          .dsBan[index].idTheLoai.tenTheLoai,
                                      trangThai:
                                          controllerBan.dsBan[index].goido ==
                                                  null
                                              ? 1
                                              : 2),
                                )
                              : Container()
                      ],
                    ),
                  ],
                )
              ],
            ),
        ]),
      ),
    );
  }

  Widget ban(
      {required String tenBan,
      required String theLoai,
      required int trangThai}) {
    return Card(
      color: colorTable[trangThai],
      child: Container(
        height: MediaQuery.of(context).size.width / 3,
        width: MediaQuery.of(context).size.width / 3.3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${tenBan}",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Divider(),
            Text(
              "${theLoai}",
              style: TextStyle(fontSize: 15),
            ),
            Text(
              '${textTable[trangThai]}',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
