// ignore_for_file: public_member_api_docs, sort_constructors_first
class TheLoaiBan {
  TheLoaiBan({
    required this.id,
    required this.tenTheLoai,
    required this.moTa,
  });
  String id;
  String tenTheLoai;
  String moTa;

  TheLoaiBan.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        moTa = json['moTa'],
        tenTheLoai = json['tenTheLoai'];
  Map<String, dynamic> toJson() =>
      {'id': id, 'moTa': moTa, 'tenTheLoai': tenTheLoai};
}
