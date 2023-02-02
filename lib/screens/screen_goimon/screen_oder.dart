import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:quan_ly_goi_mon/controller/controller_ban.dart';
import 'package:quan_ly_goi_mon/controller/controller_oder.dart';

class ScreenDSMonOder extends StatefulWidget {
  const ScreenDSMonOder({super.key});

  @override
  State<ScreenDSMonOder> createState() => _ScreenDSMonOderState();
}

class _ScreenDSMonOderState extends State<ScreenDSMonOder> {
  final ControllerBan controllerTable = Get.find<ControllerBan>();
  final ControllerOder controllerOder = Get.find<ControllerOder>();
  final styTile =const TextStyle(fontWeight: FontWeight.bold);
  int soLuong = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách Oder - ${controllerTable.selectTable}'),
      ),
      body: GetBuilder<ControllerOder>(
        builder: (controller) => ListView(
          children: [
            DataTable(
              columnSpacing: 0,
              columns: [
                DataColumn(
                    label: Text(
                  "Món",
                  style: styTile,
                )),
                DataColumn(label: Text("Số Lượng", style: styTile)),
                DataColumn(label: Text("Xóa", style: styTile)),
              ],
              rows: controller.dsChiTietGoiDo
                  .map((e) => DataRow(
                          onLongPress: () {
                            _showDialogSoLuong(
                                suaSoLuong: (int i) {
                                  controllerOder.suaSoLuongDo(e.doo.id, i);
                                },
                                ten: e.doo.ten,
                                soLuong:
                                    controllerOder.getSoLuongOder(e.doo.id));
                          },
                          cells: [
                            DataCell(
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 3,
                                child: Text("${e.doo.ten}"),
                              ),
                            ),
                            DataCell(
                              SizedBox(
                                child: Center(child: Text("${e.soLuong}")),
                              ),
                            ),
                            DataCell(
                              onTap: () {
                                controllerOder.xoaDo(e.doo.id);
                              },
                              SizedBox(
                                child: buttonDetele(),
                              ),
                            ),
                          ]))
                  .toList(),
            ),
          ],
        ),
      ),
      persistentFooterButtons: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
                onPressed: () async{
                  var idGoiMon =
                      controllerTable.dsBan[controllerTable.selectTable].goido;
                  if (idGoiMon != null) {
                    controllerOder.goiDo(idGoiDo: idGoiMon.id);
                     if(controllerOder.flagTB)
                                {
                                  Get.snackbar("Lỗi", controllerOder.thongBao);
                                }else{
                                  Get.snackbar("Oder", "Thành công");
                                }
                  } else {
                 String id = await controllerOder.newOder(
                        idTable:
                            controllerTable.dsBan[controllerTable.selectTable].id);
                             
                            if(id.compareTo("-1") != 0)
                            {
                             
                                controllerOder.goiDo(idGoiDo: id);
                                if(controllerOder.flagTB)
                                {
                                  Get.snackbar("Lỗi", controllerOder.thongBao);
                                }else{
                                  Get.snackbar("Oder", "Thành công");
                                }
                            }    
                  }
                },
                child: SizedBox(
                  height: 70,
                  width: MediaQuery.of(context).size.width/2,
                  child: Center(child: Text("Gọi Đồ")))),
                    ElevatedButton(
            onPressed: () {
              showDialogClear(context,(){
   controllerOder.clear();
              });
           
            },
            child: Center(child: Text("Clear"))),
          ],
        ),
      
      ],
    );
  }



  Widget buttonDetele() {
    return Icon(
      Icons.delete,
      color: Colors.red,
    );
  }

    void showDialogClear(BuildContext context, Function clear)
  {
    AwesomeDialog(
            context: context,
            dialogType: DialogType.question,
            animType: AnimType.rightSlide,
            title: 'Xóa tất cả',
            desc: 'Bạn có muốn xóa hết danh sách?',
            btnCancelOnPress: () {},
            btnOkOnPress: () {
              clear();
                Get.snackbar("Xóa", "Thành công",snackPosition: SnackPosition.BOTTOM);
            },
            ).show();
  }


  Future<void> _showDialogSoLuong(
      {required Function suaSoLuong,
      required String ten,
      required int soLuong})  {
    return showDialog<void>(
      context: context,

      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('${ten}'),
          content: SizedBox(
            height: MediaQuery.of(context).size.width / 1.3,
            width: MediaQuery.of(context).size.width,
            child: GridView.count(
              crossAxisCount: 3,
              children: [
                for (int i = 1; i <= 9; ++i)
                  GestureDetector(
                    onTap: () {
                      suaSoLuong(i);
                      Navigator.of(context).pop();
                    },
                    child: Card(
                      color: soLuong == i ? Colors.blue : Colors.white,
                      child: Center(
                        child: Text("${i}"),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          actions: <Widget>[
            Card(
              color: Colors.red,
              child: TextButton(
                child: const Text(
                  'X',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
