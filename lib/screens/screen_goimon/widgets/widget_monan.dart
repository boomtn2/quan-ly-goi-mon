import 'package:flutter/material.dart';

class WidgetMonAn extends StatelessWidget {
  const WidgetMonAn(
      {super.key,
      required this.tenMon,
      required this.giaTien,
      required this.soLuong,
      required this.trangThai});
  final String tenMon;
  final double giaTien;
  final int soLuong;
  final String trangThai;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(8),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "${tenMon}}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${giaTien}",
                      style: TextStyle(color: Colors.red),
                    )
                  ],
                ),
                Text("x${soLuong}"),
                Expanded(child: SizedBox()),
                Checkbox(
                  value: false,
                  onChanged: (value) {},
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [Text("Tên món"), Text("${trangThai}")],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
