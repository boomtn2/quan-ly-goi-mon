import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quan_ly_goi_mon/controller/controller_mon.dart';
import 'package:quan_ly_goi_mon/models/danh_muc.dart';
import 'package:quan_ly_goi_mon/models/the_loai_mon.dart';

import '../widgets/button_order.dart';
import 'widget_monle.dart';

class ItemFood extends StatefulWidget {
  const ItemFood({super.key});

  @override
  State<ItemFood> createState() => _ItemFoodState();
}

class _ItemFoodState extends State<ItemFood> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: Text("Món lẻ"),
          actions: [ButtonOrder()],
        ),
        body: theLoai());
  }

  Widget theLoai() {
    return SingleChildScrollView(
        child: GetX<ControllerMon>(
      builder: (controller) => ExpansionPanelList(
        expansionCallback: (panelIndex, isExpanded) {
          setState(() {
            controller.dmMonLe[panelIndex].isExpanded = !isExpanded;
          });
        },
        children:
            controller.dmMonLe.map<ExpansionPanel>((DanhMuc danhmuc) {
          return ExpansionPanel(
            headerBuilder: (context, isExpanded) {
              return ListTile(
                title: Text(danhmuc.tenDanhMuc),
              );
            },
            isExpanded: danhmuc.isExpanded,
            body: Column(
              children: [
                Card(
                  child: Column(
                    children: controller.dsMon.map((e) {
                      if (e.combo == null && danhmuc.id == e.idDanhMuc) {
                        return WidgetMonLe(
                          mon: e,
                        );
                      } else
                        return Container();
                    }).toList(),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    ));
  }
}
