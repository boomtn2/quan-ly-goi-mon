import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quan_ly_goi_mon/controller/controller_oder.dart';
import 'package:quan_ly_goi_mon/models/do.dart';

import '../../models/class_default/default.dart';

class WidgetMonLe extends StatefulWidget {
  const WidgetMonLe({super.key, required this.mon});
  final Do mon;
  @override
  State<WidgetMonLe> createState() => _WidgetMonLeState();
}

class _WidgetMonLeState extends State<WidgetMonLe> {
  final TextEditingController soLuongController =
      TextEditingController(text: '1');

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ControllerOder>(
      builder: (controller) => GestureDetector(
        onTap: () {
          controller.checkDo(widget.mon)
              ? controller.xoaDo(widget.mon.id)
              : controller.themDo(widget.mon, 1);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Banner(
            location: BannerLocation.topStart,
            message: "${trangThaiMon[widget.mon.trangThai]}",
            child: Card(
              color: Colors.yellow,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/lau.png"),
                            fit: BoxFit.fill),
                      ),
                      child: Card(
                        child: SizedBox(
                          height: 50,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "${widget.mon.gia}k",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                          child: Text(
                        "${widget.mon.ten}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                        overflow: TextOverflow.clip,
                      )),
                    ),
                    controller.getSoLuongOder(widget.mon.id) != -1
                        ? GestureDetector(
                            onTap: () {
                              _showMyDialog(controller);
                            },
                            child: Card(
                              color: Colors.white,
                              child: Container(
                                margin: EdgeInsets.only(top: 20, bottom: 20),
                                width: MediaQuery.of(context).size.width / 5,
                                child: Center(
                                    child: Text(
                                        "X${controller.getSoLuongOder(widget.mon.id)}")),
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showMyDialog(ControllerOder controllerOder) async {
    return showDialog<void>(
      context: context,

      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('${widget.mon.ten}'),
          content: SizedBox(
            height: MediaQuery.of(context).size.width / 1.3,
            width: MediaQuery.of(context).size.width,
            child: GridView.count(
              crossAxisCount: 3,
              children: [
                for (int i = 1; i <= 9; ++i)
                  GestureDetector(
                    onTap: () {
                      controllerOder.suaSoLuongDo(widget.mon.id, i);
                      Navigator.of(context).pop();
                    },
                    child: Card(
                      color: controllerOder.getSoLuongOder(widget.mon.id) == i
                          ? Colors.blue
                          : Colors.white,
                      child: Center(
                        child: Text("${i}"),
                      ),
                    ),
                  ),
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
}
