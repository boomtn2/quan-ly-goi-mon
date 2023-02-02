class DanhMuc {
    DanhMuc({
       required this.tenDanhMuc,
       required this.id,
    });

    String tenDanhMuc;
    String id;
    bool isExpanded = false;

    factory DanhMuc.fromJson(Map<String, dynamic> json) => DanhMuc(
        tenDanhMuc: json["tenDanhMuc"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "tenDanhMuc": tenDanhMuc,
        "id": id,
    };
}
