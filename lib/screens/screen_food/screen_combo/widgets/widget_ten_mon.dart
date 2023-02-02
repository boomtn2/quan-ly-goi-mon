import 'package:flutter/material.dart';

class WidgetTenMon extends StatelessWidget {
  const WidgetTenMon({super.key, required this.food});
  final String food;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2.2,
      child: Row(
        children: [
          Icon(
            Icons.edit_location_alt_sharp,
            size: 16,
          ),
          Text(food),
        ],
      ),
    );
  }
}
