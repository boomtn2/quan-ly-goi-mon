import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/controller_bep.dart';
import 'widgets/card_number.dart';

class ScreenChiTietBanFillFood extends StatefulWidget {
  const ScreenChiTietBanFillFood({super.key, required this.tenMon});
  final String tenMon;

  @override
  State<ScreenChiTietBanFillFood> createState() =>
      _ScreenChiTietBanFillFoodState();
}

class _ScreenChiTietBanFillFoodState extends State<ScreenChiTietBanFillFood> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("${widget.tenMon}"),
        ),
        body: SingleChildScrollView(child: itemCard(widget.tenMon)));
  }

  Widget itemCard(String key) {
    return GetBuilder<ControllerBep>(
      builder: (controller) => Card(
        child: Column(
          children: [
            Text(
              "${key}",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
                "Số lượng: ${controller.soLuong(controller.dsFillFood[key]!)}"),
            Divider(
              color: Colors.black,
            ),
            Column(
              children: [
                for (var element in controller.dsFillFood[key]!)
                  InkWell(
                    onTap: () {
                      int soLuong = 0;
                      try {
                        soLuong = int.parse(element.chiTietGoiDo.soLuong) -
                            int.parse(element.chiTietGoiDo.soLuongPV);
                      } catch (e) {
                        soLuong = 0;
                      }

                      _showDialogSoLuong(
                          suaSoLuong: (int index) {
                            int soLuongT = 0;
                            try {
                              soLuongT =
                                  int.parse(element.chiTietGoiDo.soLuongPV) +
                                      index;
                            } catch (e) {
                              soLuongT = 0;
                            }
                            if (soLuongT
                                    .toString()
                                    .compareTo(element.chiTietGoiDo.soLuong) ==
                                0) {
                              //Đã xong
                              controller.updateCTHD(
                                  id: element.chiTietGoiDo.id,
                                  soLuong: soLuongT.toString(),
                                  trangThai: '3');
                            } else {
                              //Đang làm
                              controller.updateCTHD(
                                  id: element.chiTietGoiDo.id,
                                  soLuong: soLuongT.toString(),
                                  trangThai: '1');
                            }

                            Get.snackbar("Phục vụ", controller.thongBao);
                          },
                          ten: element.chiTietGoiDo.doo.ten,
                          soLuong: soLuong);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: Text(
                            "${element.tenBan} - ${element.theLoaiBan}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.black),
                          ),
                          trailing: RichText(
                            text: TextSpan(
                              text: 'Số lượng( ',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                    text: '${element.chiTietGoiDo.soLuong}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                        color: Colors.red)),
                                TextSpan(text: ' )'),
                              ],
                            ),
                          ),
                          subtitle: Text("${element.chiTietGoiDo.thoiGian}"),
                        ),
                        Divider(),
                      ],
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
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
