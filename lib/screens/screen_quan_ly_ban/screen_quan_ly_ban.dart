import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quan_ly_goi_mon/controller/controller_ban.dart';
import 'package:quan_ly_goi_mon/screens/screen_quan_ly_ban/screen_themban.dart';
import 'package:quan_ly_goi_mon/screens/screen_quan_ly_ban/widgets/item_ban.dart';
import '../../models/class_default/default.dart';
import '../screen_goimon/screen_oder_table.dart';
import '../widgets/button_reload_data.dart';
import 'edit_table.dart';

class ScreenQuanLyBan extends StatefulWidget {
  const ScreenQuanLyBan({super.key});

  @override
  State<ScreenQuanLyBan> createState() => _ScreenRoomState();
}

class _ScreenRoomState extends State<ScreenQuanLyBan> {
  final controllerBan = Get.find<ControllerBan>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //   automaticallyImplyLeading: false,
        backgroundColor: Colors.orange,
        title: Text("Quản lý bàn"),
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
                Wrap(
                  children: [
                    for (int index = 0;
                        index < controllerBan.dsBan.length;
                        ++index)
                      controllerBan.dsBan[index].idTheLoai.id == ins.id
                          ? GestureDetector(
                              onTap: () {
                                controllerBan.selectTable = index;

                                _showMyDialog(controllerBan);
                              },
                              child: ItemBan(
                                  tenBan: controllerBan.dsBan[index].soThuTu,
                                  theLoai: controllerBan
                                      .dsBan[index].idTheLoai.tenTheLoai,
                                  trangThai: controllerBan.dsBan[index]
                                      .getTrangThai()),
                            )
                          : Container()
                  ],
                )
              ],
            ),
        ]),
      ),
      persistentFooterButtons: [
        ElevatedButton(
            onPressed: () {
              Get.to(() => ScreenThemBan());
            },
            child: const Text('Tạo bàn')),
      ],
    );
  }

  Future<void> _showMyDialog(ControllerBan controller) async {
    return showDialog<void>(
      context: context,

      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(''),
          content: SizedBox(
            height: MediaQuery.of(context).size.width / 1.3,
            width: MediaQuery.of(context).size.width,
            child: ListView(
              children: [
                GestureDetector(
                    onTap: () {
                      controllerBan.insBan = controllerBan.getBan();
                      Get.to(() => EditTable());
                    },
                    child: _button('Sửa')),
                GestureDetector(
                    onTap: () async {
                      String tb = "";
                      if (controller.getBan().trangThai.compareTo('4') == 0) {
                        tb = await controller.onTable();
                      } else {
                        tb = await controller.hideTable();
                      }
                      Navigator.of(context).pop();
                      Get.snackbar("Thông báo:", tb);
                      controller.fetchBan();
                    },
                    child: controller.getBan().trangThai.compareTo('4') == 0
                        ? _button('Hiển thị bàn')
                        : _button('Ẩn')),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Đóng'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _button(String ten) {
    return Card(
      color: Colors.grey,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: Card(child: Icon(Icons.touch_app)),
          title: Text(ten),
          trailing: Icon(Icons.arrow_right),
        ),
      ),
    );
  }
}
