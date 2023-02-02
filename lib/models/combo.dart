class Combo {
    Combo({
      required  this.tenThanhPhan,
    });

    String id = "";
    String tenThanhPhan;

    factory Combo.fromJson(Map<String, dynamic> json) => Combo(
        tenThanhPhan: json["tenThanhPhan"],
    );

    Map<String, dynamic> toJson() => {
        "tenThanhPhan": tenThanhPhan,
    };
}