import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import '../../controller/controller_bep.dart';

class ScreenFillTime extends StatefulWidget {
  const ScreenFillTime({super.key});

  @override
  State<ScreenFillTime> createState() => _ScreenFillTimeState();
}

class _ScreenFillTimeState extends State<ScreenFillTime> {
  final _controllerBep = Get.find<ControllerBep>();
  @override
  Widget build(BuildContext context) {
    return GetX<ControllerBep>(
      builder: (controller) => ListView(
          children: controller.dsOder
              .map((element) => foodOder(
                  id: element.chiTietGoiDo.id,
                  ten: element.chiTietGoiDo.doo.ten,
                  sL: element.chiTietGoiDo.soLuong,
                  trangThai: element.chiTietGoiDo.trangThai,
                  thoiGian: "${element.tenBan}-${element.theLoaiBan}"))
              .toList()),
    );
  }

  Widget foodOder(
      {required String id,
      required String ten,
      required String sL,
      required String thoiGian,
      required String trangThai}) {
    return Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            GestureDetector(
              onTap: () {
                print("Hetmon");
              },
              child: const Card(
                color: Colors.red,
                child: SizedBox(
                  height: 80,
                  width: 80,
                  child: Icon(
                    Icons.report,
                    size: 50,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                print("Bedo");
              },
              child: const Card(
                color: Colors.yellow,
                child: SizedBox(
                  height: 80,
                  width: 80,
                  child: Icon(
                    Icons.notifications,
                    size: 50,
                  ),
                ),
              ),
            ),
          ],
        ),
        child: GestureDetector(
          onTap: () {
            _controllerBep.updateTrangThaiCTHD(
                id: id, soLuong: sL, trangThai: '1');
            _controllerBep.fetchData();
          },
          child: Card(
            child: SizedBox(
              height: 80,
              width: MediaQuery.of(context).size.width,
              child: ListTile(
                leading: Icon(
                  Icons.check,
                  color: trangThai.compareTo('1') == 0
                      ? Colors.green
                      : Colors.grey,
                ),
                title: Text(
                  ten,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: Text(
                  sL,
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.red,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text("Bàn " + thoiGian),
              ),
            ),
          ),
        ));
  }
}
