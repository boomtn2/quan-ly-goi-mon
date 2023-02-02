import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quan_ly_goi_mon/controller/controller_mon.dart';
import 'package:quan_ly_goi_mon/models/combo.dart';

class ItemCombo extends StatefulWidget {
  const ItemCombo({super.key, required this.stateCombo});
  final bool stateCombo;
  @override
  State<ItemCombo> createState() => _ItemComboState();
}

class _ItemComboState extends State<ItemCombo> {
  final TextEditingController giaController = TextEditingController();
  bool isCombo = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isCombo = widget.stateCombo;
    giaController.text = ".";
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ControllerMon>(
      builder: (controller) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Combo:"),
                  Switch(
                    value: isCombo,
                    onChanged: (value) {
                      setState(() {
                        isCombo = !isCombo;
                      });
                      if (isCombo) {
                        controller.insDo.combo = [];
                      } else {
                        controller.insDo.combo = null;
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          Visibility(
              visible: isCombo,
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: TextFormField(
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(
                            fontSize: 17.0, color: Colors.white),
                        labelStyle: const TextStyle(
                            fontSize: 20.0, color: Colors.white),
                        errorStyle: const TextStyle(fontSize: 20.0),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        hintText: 'Nhập tên thành phần',
                        labelText: 'Tên',
                        suffixIcon: Card(
                            child: TextButton(
                                onPressed: () {
                                  if (controller.insDo.combo != null) {
                                    controller.insDo.combo?.add(Combo(
                                        tenThanhPhan: giaController.text));
                                    giaController.text = " ";
                                    controller.updateUI();
                                  }
                                },
                                child: Text("Nhập"))),
                      ),
                      controller: giaController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Chưa nhập';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: Colors.grey,
                        border: Border.all(color: Colors.white, width: 1)),
                    child: controller.insDo.combo == null
                        ? Container()
                        : Wrap(
                            children: controller.insDo.combo!
                                .map((e) => Card(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(e.tenThanhPhan),
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                controller.xoaCombo(
                                                    tenCombo: e.tenThanhPhan);
                                                controller.update();
                                              },
                                              icon: Icon(Icons.delete))
                                        ],
                                      ),
                                    ))
                                .toList()),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
