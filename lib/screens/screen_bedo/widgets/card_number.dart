import 'package:flutter/material.dart';

class CardNumber extends StatefulWidget {
  const CardNumber(
      {super.key,
      required this.soLuong,
      required this.getIndex,
      required this.close});
  final int soLuong;
  final Function getIndex;
  final Function close;
  @override
  State<CardNumber> createState() => _CardNumberState();
}

class _CardNumberState extends State<CardNumber> {
  List<bool> stateBox = [true];
  int indexSlelect = 0;
  @override
  void initState() {
    // TODO: implement initState
    for (int i = 0; i < widget.soLuong; ++i) {
      if (stateBox.length < widget.soLuong) {
        stateBox.add(false);
      }
    }
    super.initState();
  }

  void choose(int index) {
    setState(() {
      stateBox[indexSlelect] = false;
      stateBox[index] = true;
      indexSlelect = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.width / 1.3,
          width: MediaQuery.of(context).size.width,
          child: GridView.count(
            crossAxisCount: 3,
            children: [
              for (int i = 1; i <= widget.soLuong; ++i)
                GestureDetector(
                  onTap: () {
                    choose(i - 1);
                  },
                  child: Card(
                    color: stateBox[i - 1] ? Colors.blue : Colors.white,
                    child: Center(
                      child: Text("${i}"),
                    ),
                  ),
                ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Card(
              color: Colors.blue,
              child: TextButton(
                  onPressed: () {
                    widget.getIndex(indexSlelect + 1);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      "Xác nhận",
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
            ),
            Card(
              color: Colors.red,
              child: TextButton(
                child: const Text(
                  'X',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  widget.close();
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}
