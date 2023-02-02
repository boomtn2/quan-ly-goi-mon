// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:quan_ly_goi_mon/models/chi_tiet_goi_do.dart';

class Bep {

  String tenBan;
  String theLoaiBan;
  ChiTietGoiDo chiTietGoiDo;
  Bep({
    required this.tenBan,
    required this.theLoaiBan,
    required this.chiTietGoiDo,
  });

      factory Bep.fromJson(Map<String, dynamic> json) => Bep(
        tenBan: json["soTT"],
        theLoaiBan: json["tenTheLoai"],
        chiTietGoiDo: ChiTietGoiDo.fromJson(json),
       
    );
}
