import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quan_ly_goi_mon/controller/controller_mon.dart';
import 'package:quan_ly_goi_mon/models/do.dart';
import 'package:quan_ly_goi_mon/screens/screen_quanly_do/button_reload.dart';

import 'edit_do.dart';

class ScreenQuanLyDo extends StatefulWidget {
  const ScreenQuanLyDo({super.key});

  @override
  State<ScreenQuanLyDo> createState() => _ScreenQuanlyDoState();
}

class _ScreenQuanlyDoState extends State<ScreenQuanLyDo> {
  final _controller = Get.find<ControllerMon>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dsChoose = {};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quản lý đồ"),
        actions: [ButtonReload()],
      ),
      body: GetX<ControllerMon>(
        builder: (controller) => ListView(children: [
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    controller.insDo = Do(
                        id: "",
                        ten: "",
                        idTheLoai: "",
                        idDanhMuc: "",
                        gia: "",
                        trangThai: "",
                        combo: null);
                    controller.fetchDM();
                    controller.fetchTLM();
                    Get.to(() => EditDo(
                          insDo: controller.insDo,
                          isEdit: false,
                        ));
                  },
                  child: Card(
                    color: Colors.red,
                    child: SizedBox(
                      height: 70,
                      child: Center(
                        child: Text("Thêm"),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Card(
                  color: Colors.red,
                  child: SizedBox(
                    height: 70,
                    child: Center(
                      child: Text("Reset Status ALL"),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Card(
            color: Colors.grey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text("Combo"),
                trailing: Icon(Icons.arrow_right),
              ),
            ),
          ),
          Column(
            children: controller.dsCombo
                .map((element) => ItemCheckBox(
                      insDo: element,
                    ))
                .toList(),
          ),
          Card(
            color: Colors.grey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text("Món lẻ"),
                trailing: Icon(Icons.arrow_right),
              ),
            ),
          ),
          Column(
            children: controller.dsMon
                .map((element) => ItemCheckBox(
                      insDo: element,
                    ))
                .toList(),
          ),
          Card(
            color: Colors.grey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text("Đồ uống"),
                trailing: Icon(Icons.arrow_right),
              ),
            ),
          ),
          Column(
            children: controller.dsDoUong
                .map((element) => ItemCheckBox(
                      insDo: element,
                    ))
                .toList(),
          ),
        ]),
      ),
      persistentFooterButtons: [
        TextButton(
            onPressed: () {
              dsChoose.values.forEach((element) {
                print(element);
              });
            },
            child: Text("Xóa"))
      ],
    );
  }
}

Map<String, String> dsChoose = {};

class ItemCheckBox extends StatefulWidget {
  const ItemCheckBox({super.key, required this.insDo});
  final Do insDo;

  @override
  State<ItemCheckBox> createState() => _ItemCheckBoxState();
}

class _ItemCheckBoxState extends State<ItemCheckBox> {
  final controller = Get.find<ControllerMon>();
  bool stateCheckBox = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: Checkbox(
        onChanged: (value) {
          setState(() {
            stateCheckBox = !stateCheckBox;
          });

          if (dsChoose[widget.insDo.id] != null) {
            dsChoose.remove(widget.insDo.id);
          } else {
            dsChoose.addAll({widget.insDo.id: widget.insDo.id});
          }
        },
        value: stateCheckBox,
      ),
      title: Text(widget.insDo.ten),
      leading: InkWell(
          onTap: () {
            controller.fetchDM();
            controller.fetchTLM();
            controller.insDo = widget.insDo;
            Get.to(() => EditDo(
                  insDo: widget.insDo,
                  isEdit: true,
                ));
          },
          child: Icon(Icons.edit)),
    );
  }
}
