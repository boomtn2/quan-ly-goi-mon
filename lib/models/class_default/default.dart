import 'package:flutter/material.dart';

Map<int, Color> colorTable = {
  0: Colors.blue,
  1: Colors.blue,
  2: Colors.red,
  3: Colors.yellow,
  4: Colors.grey
};

Map<String, String> thongBaoServer = {
  "0": "Thất bại",
  "1": "Thành công",
  "404": "Lỗi kết nối",
};

Map<int, String> textTable = {
  0: "Trống",
  1: "Trống",
  2: "Đang gọi món",
  3: "Đã có người đặt",
  4: "Bàn bị ẩn",
};

Map<String, String> trangThaiMon = {
  '0': "Còn",
  '1': "Hết món",
  '2': "Không bán"
};

Map<int, String> trangThaiDo = {
  0: "Oder",
  1: "Đang làm",
  2: "Hết món",
  3: "Đã xong"
};

Map<int, String> theLoaiTK = {0: "", 1: "Nhân viên", 2: "Quản lý", 3: "Bếp"};
