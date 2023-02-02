import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quan_ly_goi_mon/controller/controller_mon.dart';
import 'package:quan_ly_goi_mon/models/danh_muc.dart';
import 'package:quan_ly_goi_mon/models/the_loai_mon.dart';
import '../../widgets/button_order.dart';
import 'item_combo.dart';

class ItemCombo extends StatefulWidget {
  const ItemCombo({super.key});

  @override
  State<ItemCombo> createState() => _ItemComboState();
}

class _ItemComboState extends State<ItemCombo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Combo"),
        actions: [
          ButtonOrder(),
        ],
      ),
      body: theLoai(),
    );
  }

  Widget theLoai() {
    return SingleChildScrollView(
      child: GetX<ControllerMon>(
        builder: (controller) => ExpansionPanelList(
          expansionCallback: (panelIndex, isExpanded) {
            setState(() {
              controller.dmCombo[panelIndex].isExpanded = !isExpanded;
            });
          },
          children: controller.dmCombo.map<ExpansionPanel>((DanhMuc danhMuc) {
            print(controller.dsCombo.length);
            return ExpansionPanel(
              headerBuilder: (context, isExpanded) {
                return ListTile(
                  title: Text(danhMuc.tenDanhMuc),
                );
              },
              isExpanded: danhMuc.isExpanded,
              body: Column(
                children: controller.dsCombo
                    .map((e) => e.combo != null && e.idDanhMuc == danhMuc.id
                        ? FoodCombo(mon: e)
                        : Container())
                    .toList(),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
