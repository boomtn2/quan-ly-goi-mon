// ignore_for_file: public_member_api_docs, sort_constructors_first
class TheLoaiMon {
  TheLoaiMon({
    required this.id,
    required this.tenTheLoai,
  });

  String id;
  String tenTheLoai;
  bool isExpanded = false;

  factory TheLoaiMon.fromJson(Map<String, dynamic> json) => TheLoaiMon(
        id: json["id"],
        tenTheLoai: json["tenTheLoai"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tenTheLoai": tenTheLoai,
      };
}
