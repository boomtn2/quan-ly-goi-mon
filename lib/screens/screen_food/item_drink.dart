import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quan_ly_goi_mon/controller/controller_mon.dart';
import 'package:quan_ly_goi_mon/controller/controller_oder.dart';
import 'package:quan_ly_goi_mon/models/do.dart';
import '../../models/class_default/default.dart';
import '../widgets/button_order.dart';

class ItemDrink extends StatefulWidget {
  const ItemDrink({super.key});

  @override
  State<ItemDrink> createState() => _ItemDrinkState();
}

class _ItemDrinkState extends State<ItemDrink> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Đồ uống"),
        actions: [ButtonOrder()],
      ),
      body: GetX<ControllerMon>(
        builder: (controller) => GridView.count(
            crossAxisCount: 2,
            children: controller.dsDoUong
                .map((e) => WidgetDrink(
                      doUong: e,
                    ))
                .toList()),
      ),
    );
  }
}

class WidgetDrink extends StatefulWidget {
  const WidgetDrink({super.key, required this.doUong});
  final Do doUong;
  @override
  State<WidgetDrink> createState() => _WidgetDrinkState();
}

class _WidgetDrinkState extends State<WidgetDrink> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ControllerOder>(
      builder: (controller) => GestureDetector(
        onTap: () {
          controller.checkDo(widget.doUong)
              ? controller.xoaDo(widget.doUong.id)
              : controller.themDo(widget.doUong, 1);
        },
        child: Banner(
          location: BannerLocation.topStart,
          message: "${trangThaiMon[widget.doUong.trangThai]}",
          child: Card(
            color: Colors.blue,
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/images/cola.png"))),
                      ),
                    ),
                    Visibility(
                      visible: controller.checkDo(widget.doUong),
                      child: GestureDetector(
                        onTap: () {
                          _showMyDialog(controller);
                        },
                        child: Card(
                          color: Colors.white,
                          child: Container(
                              margin: EdgeInsets.all(2),
                              width: MediaQuery.of(context).size.width,
                              child: Center(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "x${controller.getSoLuongOder(widget.doUong.id)}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 21),
                                  ),
                                ],
                              ))),
                        ),
                      ),
                    ),
                    Card(
                      color: Colors.yellow,
                      child: Container(
                          margin: EdgeInsets.all(2),
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${widget.doUong.ten}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 21),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "${widget.doUong.gia}",
                                style:
                                    TextStyle(color: Colors.red, fontSize: 20),
                              ),
                            ],
                          ))),
                    ),
                  ],
                ),
                Positioned(
                    right: 0,
                    child: Checkbox(
                      value: false,
                      onChanged: (value) {},
                    ))
              ],
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
          title: Text('${widget.doUong.ten}'),
          content: SizedBox(
            height: MediaQuery.of(context).size.width / 1.3,
            width: MediaQuery.of(context).size.width,
            child: GridView.count(
              crossAxisCount: 3,
              children: [
                for (int i = 1; i <= 9; ++i)
                  GestureDetector(
                    onTap: () {
                      controllerOder.suaSoLuongDo(widget.doUong.id, i);
                      Navigator.of(context).pop();
                    },
                    child: Card(
                      color:
                          controllerOder.getSoLuongOder(widget.doUong.id) == i
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
              child: const Text('Dong'),
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
