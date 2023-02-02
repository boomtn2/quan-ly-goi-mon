import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class TaiKhoan {
  String id;
  String taiKhoan;
  String matKhau;
  TheLoaiTaiKhoan theLoaiTaiKhoan;
  TaiKhoan({
      required this.id,
    required this.taiKhoan,
    required this.matKhau,
    required this.theLoaiTaiKhoan,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'taiKhoan': taiKhoan,
      'matKhau': matKhau,
      'idTheLoaiTaiKhoan':theLoaiTaiKhoan.id ,
    };
  }

  factory TaiKhoan.fromMap(Map<String, dynamic> map) {
    return TaiKhoan(
      id: map['id'],
      taiKhoan: map['taiKhoan'],
      matKhau: map['matKhau'] ,
      theLoaiTaiKhoan: TheLoaiTaiKhoan.fromMap(map),
    );
  }
}

class TheLoaiTaiKhoan {
  String id;
    String tenTheLoai;
  TheLoaiTaiKhoan({
    required this.id,
    required this.tenTheLoai
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'tenTheLoai': tenTheLoai,
    };
  }

  factory TheLoaiTaiKhoan.fromMap(Map<String, dynamic> map) {
    return TheLoaiTaiKhoan(
      id: map['idTL'] as String,
      tenTheLoai: map['tenTheLoai'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TheLoaiTaiKhoan.fromJson(String source) => TheLoaiTaiKhoan.fromMap(json.decode(source) as Map<String, dynamic>);
}
