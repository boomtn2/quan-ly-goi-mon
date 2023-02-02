import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import '../../controller/controller_bep.dart';
import '../../models/class_default/default.dart';
import 'widgets/card_number.dart';

class ScreenFillTime extends StatefulWidget {
  const ScreenFillTime({super.key});

  @override
  State<ScreenFillTime> createState() => _ScreenFillTimeState();
}

class _ScreenFillTimeState extends State<ScreenFillTime> {
  final controllerBep = Get.find<ControllerBep>();
  @override
  Widget build(BuildContext context) {
    return GetX<ControllerBep>(
      builder: (controller) => ListView(
          children: controller.dsOder
              .map((element) =>
                  element.chiTietGoiDo.trangThai.compareTo('3') == 0
                      ? Container()
                      : foodOder(
                          id: element.chiTietGoiDo.id,
                          ten: element.chiTietGoiDo.doo.ten,
                          sL: element.chiTietGoiDo.soLuong,
                          sLPV: element.chiTietGoiDo.soLuongPV,
                          trangThai: element.chiTietGoiDo.trangThai,
                          thoiGian: "${element.tenBan}-${element.theLoaiBan}"))
              .toList()),
    );
  }

  Widget foodOder(
      {required String id,
      required String ten,
      required String sL,
      required String sLPV,
      required String trangThai,
      required String thoiGian}) {
    return Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            GestureDetector(
              onTap: () {
                int soLuong = 0;
                try {
                  soLuong = int.parse(sL) - int.parse(sLPV);
                } catch (e) {
                  soLuong = 0;
                }
                _showDialogSoLuong(
                    ten: ten,
                    soLuong: soLuong,
                    suaSoLuong: (int index) {
                      int soLuongT = 0;
                      try {
                        soLuongT = int.parse(sLPV) + index;
                      } catch (e) {
                        soLuongT = 0;
                      }
                      if (soLuongT.toString().compareTo(sL) == 0) {
                        //Đã phục vụ xong
                        controllerBep.updateCTHD(
                            id: id,
                            soLuong: soLuongT.toString(),
                            trangThai: '3');
                      } else {
                        //Đang làm
                        controllerBep.updateCTHD(
                            id: id,
                            soLuong: soLuongT.toString(),
                            trangThai: '1');
                      }

                      Get.snackbar("Phục vụ", controllerBep.thongBao);
                    });
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
        child: Card(
          child: SizedBox(
            height: 80,
            width: MediaQuery.of(context).size.width,
            child: ListTile(
              leading: Text(
                "Bàn $thoiGian",
                overflow: TextOverflow.ellipsis,
              ),
              title: Text(
                ten,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                        text: '$sLPV',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.red)),
                    TextSpan(
                      text: '/',
                    ),
                    TextSpan(text: ' $sL'),
                  ],
                ),
              ),
              subtitle: Text("${trangThaiDo[int.tryParse(trangThai)]}"),
            ),
          ),
        ));
  }

  Future<void> _showDialogSoLuong(
      {required Function suaSoLuong,
      required String ten,
      required int soLuong}) {
    return showDialog<void>(
      context: context,

      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('${ten}'),
          content: CardNumber(
              soLuong: soLuong,
              getIndex: (index) {
                suaSoLuong(index);
                Navigator.of(context).pop();
              },
              close: () {
                Navigator.of(context).pop();
              }),
        );
      },
    );
  }
}
