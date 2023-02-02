import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quan_ly_goi_mon/controller/controller_ban.dart';


class ButtonThanhToan extends StatefulWidget {
  const ButtonThanhToan({super.key});

  @override
  State<ButtonThanhToan> createState() => _ButtonThanhToanState();
}

class _ButtonThanhToanState extends State<ButtonThanhToan> {
  final _controllerBan = Get.find<ControllerBan>();
  @override
  Widget build(BuildContext context) {
    return  ElevatedButton(onPressed: () {
        showDialog(context);
        }, child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child:const Center(child: Text("Thanh Toán"))));
  }

  void showDialog(BuildContext context)
  {
    AwesomeDialog(
            context: context,
            dialogType: DialogType.question,
            animType: AnimType.rightSlide,
            title: 'Thanh toán',
            desc: 'Xác nhận bàn này đã thanh toán?',
            btnCancelOnPress: () {},
            btnOkOnPress: () async{
            String reponse = await  _controllerBan.thanhToan();
             _controllerBan.fetchBan();
             _controllerBan.getOder();
              Get.back();
                Get.snackbar("Thanh toán", "$reponse",snackPosition: SnackPosition.BOTTOM);
               
            },
            ).show();
  }
}