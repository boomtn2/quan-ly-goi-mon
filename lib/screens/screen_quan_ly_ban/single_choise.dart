import 'package:flutter/material.dart';
import 'package:awesome_select/awesome_select.dart';
import 'package:get/get.dart';
import 'package:quan_ly_goi_mon/controller/controller_ban.dart';

class PopupTheLoaiBan extends StatefulWidget {
  const PopupTheLoaiBan({super.key, required this.theLoai});

  @override
  _FeaturesSinglePopupState createState() => _FeaturesSinglePopupState();

  final String theLoai;
}

class _FeaturesSinglePopupState extends State<PopupTheLoaiBan> {
  String? _framework = '';
  final controller = Get.find<ControllerBan>();
  @override
  void initState() {
    _framework = widget.theLoai;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetX<ControllerBan>(
      builder: (controller) => Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Card(
              child: SmartSelect<String?>.single(
                title: 'Thể loại bàn',
                selectedValue: _framework,
                choiceItems: controller.getDMChoise(),
                onChange: (selected) => setState(() {
                  _framework = selected.value;
                  controller.insBan.idTheLoai.id = _framework ?? '';
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
