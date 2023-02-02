import 'package:flutter/material.dart';
import 'package:awesome_select/awesome_select.dart';
import 'package:get/get.dart';
import 'package:quan_ly_goi_mon/controller/controller_mon.dart';

class FeaturesSinglePopup extends StatefulWidget {
  const FeaturesSinglePopup(
      {super.key, required this.danhMuc, required this.theLoai});

  @override
  _FeaturesSinglePopupState createState() => _FeaturesSinglePopupState();

  final String danhMuc;
  final String theLoai;
}

class _FeaturesSinglePopupState extends State<FeaturesSinglePopup> {
  String? _fruit = '';
  String? _framework = '';
  final controller = Get.find<ControllerMon>();
  @override
  void initState() {
    _fruit = widget.danhMuc;
    _framework = widget.theLoai;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetX<ControllerMon>(
      builder: (controller) => Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Card(
              child: SmartSelect<String?>.single(
                title: 'Danh mục',
                selectedValue: _fruit,
                choiceItems: controller.getDMChoise(),
                onChange: (selected) => setState(() {
                  _fruit = selected.value;
                  controller.insDo.idDanhMuc = _fruit ?? '';
                }),
                modalType: S2ModalType.popupDialog,
                tileBuilder: (context, state) {
                  return S2Tile.fromState(
                    state,
                    leading: const Icon(Icons.category_outlined),
                  );
                },
              ),
            ),
          ),
          const Divider(indent: 20),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Card(
              child: SmartSelect<String?>.single(
                title: 'Thể loại món',
                selectedValue: _framework,
                choiceItems: controller.getTLMChoise(),
                onChange: (selected) => setState(() {
                  _framework = selected.value;
                  controller.insDo.idTheLoai = _framework ?? '';
                }),
                modalType: S2ModalType.popupDialog,
                tileBuilder: (context, state) {
                  return S2Tile.fromState(
                    state,
                    leading: const Icon(Icons.category_outlined),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
