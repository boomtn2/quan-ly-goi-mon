import 'package:flutter/material.dart';

import '../../../models/class_default/default.dart';

class ItemBan extends StatefulWidget {
  const ItemBan(
      {super.key,
      required this.tenBan,
      required this.theLoai,
      required this.trangThai});
  final String tenBan;
  final String theLoai;
  final int trangThai;
  @override
  State<ItemBan> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ItemBan> {
  @override
  Widget build(BuildContext context) {
    return ban(
        tenBan: widget.tenBan,
        theLoai: widget.theLoai,
        trangThai: widget.trangThai);
  }

  Widget ban(
      {required String tenBan,
      required String theLoai,
      required int trangThai}) {
    return Card(
      color: colorTable[trangThai],
      child: SizedBox(
        height: MediaQuery.of(context).size.width / 3,
        width: MediaQuery.of(context).size.width / 3.2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              tenBan,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const Divider(),
            Text(
              theLoai,
              style: const TextStyle(fontSize: 15),
            ),
            Text(
              '${textTable[trangThai]}',
              style: const TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
