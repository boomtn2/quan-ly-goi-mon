import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quan_ly_goi_mon/controller/controller_mon.dart';
import 'package:quan_ly_goi_mon/controller/controller_oder.dart';
import 'package:quan_ly_goi_mon/models/do.dart';
import '../../../models/class_default/default.dart';
import 'widgets/widget_ten_mon.dart';

class FoodCombo extends StatefulWidget {
  const FoodCombo({super.key, required this.mon});
  final Do mon;

  @override
  State<FoodCombo> createState() => _FoodComboState();
}

class _FoodComboState extends State<FoodCombo> {
  int index = 1;
  final ControllerOder controllerOder = Get.find<ControllerOder>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ControllerOder>(builder: (controller) {
      bool checkBox = controller.checkDo(widget.mon);
      return GestureDetector(
        onTap: () {
          controllerOder.checkDo(widget.mon)
              ? controllerOder.xoaDo(widget.mon.id)
              : controllerOder.themDo(widget.mon, 1);
        },
        child: Card(
          color: Color.fromARGB(127, 221, 255, 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              tenMonvaGia(checkBox),
              danhSachMon(),
            ],
          ),
        ),
      );
    });
  }

  Widget danhSachMon() {
    return SizedBox(
        height: 70,
        width: MediaQuery.of(context).size.width,
        child: Wrap(
            alignment: WrapAlignment.center,
            children: widget.mon.combo!
                .map((e) => WidgetTenMon(food: e.tenThanhPhan))
                .toList()));
  }

  Widget tenMonvaGia(bool checkBox) {
    return GetBuilder<ControllerOder>(
      builder: (controller) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Banner(
          location: BannerLocation.topStart,
          message: "${trangThaiMon[widget.mon.trangThai]}",
          child: Column(children: [
            Text(
              "${widget.mon.ten}",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/lau.png"),
                      fit: BoxFit.fill)),
              child: ListTile(
                leading: Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      "${widget.mon.gia}",
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                  ),
                ),
                trailing: controller.getSoLuongOder(widget.mon.id) != -1
                    ? GestureDetector(
                        onTap: () {
                          // _showMyDialog(controller);
                        },
                        child: GestureDetector(
                          onTap: () {
                            _showMyDialog(controller);
                          },
                          child: Card(
                            color: Colors.white,
                            child: Container(
                              //margin: EdgeInsets.only(top: 20, bottom: 20),
                              width: MediaQuery.of(context).size.width / 5,
                              child: Center(
                                  child: Text(
                                      "X${controllerOder.getSoLuongOder(widget.mon.id)}")),
                            ),
                          ),
                        ),
                      )
                    : Checkbox(
                        value: false,
                        onChanged: (value) {
                          controllerOder.themDo(widget.mon, 1);
                        }),
              ),
            ),
          ]),
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
