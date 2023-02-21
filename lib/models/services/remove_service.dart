import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:quan_ly_goi_mon/key_spref.dart';
import 'package:quan_ly_goi_mon/models/bep.dart';
import 'package:quan_ly_goi_mon/models/chi_tiet_goi_do.dart';
import 'package:quan_ly_goi_mon/models/combo.dart';
import 'package:quan_ly_goi_mon/models/do.dart';
import 'package:quan_ly_goi_mon/models/goi_do.dart';
import 'package:quan_ly_goi_mon/models/tai_khoan.dart';
import 'package:quan_ly_goi_mon/models/the_loai_ban.dart';
import 'package:quan_ly_goi_mon/models/thong_ke.dart';
import 'package:quan_ly_goi_mon/models/class_default/date_time_get.dart';
import 'package:quan_ly_goi_mon/spref.dart';

class RemoteServies {
  //static var client = http.http();

  static String ipServer = "192.168.1.62";
  static String urlAPI = "http://$ipServer/oder_food_api";

  static setUrlAPI() {
    urlAPI = "http://$ipServer/oder_food_api";
  }

  static getIP() async {
    var data = SPref.instance;
    String? ip = await data.getString(ipKey);
    setUrlAPI();
    if (ip != null) {
      ipServer = ip;
      print(ipServer);
    }
  }

  static Future<String> login(
      {required String taiKhoan, required String matKhau}) async {
    String stConnection = "$urlAPI/login.php";

    try {
      var response = await http.post(Uri.parse(stConnection),
          body: {"taikhoan": taiKhoan, "matkhau": matKhau}).timeout(
        const Duration(seconds: 2),
        onTimeout: () {
          return http.Response('404', 408);
        },
      );
      return response.body;
    } on TimeoutException catch (_) {
      // A timeout occurred.
      return "404";
    } on SocketException catch (_) {
      // Other exception
      return "404";
    } catch (e) {
      return "404";
    }
  }

  static Future<String> getData() async {
    String stConnection = "$urlAPI/read_table.php";

    try {
      var response = await http.get(Uri.parse(stConnection)).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          return http.Response('404', 404);
        },
      );

      return response.body;
    } on TimeoutException catch (_) {
      // A timeout occurred.
      return "404";
    } on SocketException catch (_) {
      // Other exception
      return "404";
    } catch (e) {
      return "404";
    }
  }

  static Future<String> getTheLoaiBan() async {
    String stConnection = "$urlAPI/read_theloaiban.php";
    try {
      var response = await http.get(Uri.parse(stConnection)).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          return http.Response('404', 404);
        },
      );
      return response.body;
    } on TimeoutException catch (_) {
      // A timeout occurred.
      return "404";
    } on SocketException catch (_) {
      // Other exception
      return "404";
    } catch (e) {
      return "404";
    }
  }

  static Future<List<Bep>> getCTGD({required String ngay}) async {
    String stConnection = "$urlAPI/read_ctgd.php";

    try {
      var response = await http
          .post(Uri.parse(stConnection), body: {'ngay': ngay}).timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          return http.Response('404', 404);
        },
      );

      var banObjsJson = jsonDecode(response.body) as List;
      List<Bep> banObjects =
          banObjsJson.map((tagJson) => Bep.fromJson(tagJson)).toList();

      return banObjects;
    } on TimeoutException catch (_) {
      // A timeout occurred.
      return [];
    } on SocketException catch (_) {
      // Other exception
      return [];
    } catch (e) {
      return [];
    }
  }

  static Future<List<Bep>> getCTGDFillBep({required String ngay}) async {
    String stConnection = "$urlAPI/read_fill_ctgd.php";

    try {
      var response = await http
          .post(Uri.parse(stConnection), body: {'ngay': ngay}).timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          return http.Response('404', 404);
        },
      );

      var banObjsJson = jsonDecode(response.body) as List;
      List<Bep> banObjects =
          banObjsJson.map((tagJson) => Bep.fromJson(tagJson)).toList();

      return banObjects;
    } on TimeoutException catch (_) {
      // A timeout occurred.
      return [];
    } on SocketException catch (_) {
      // Other exception
      return [];
    } catch (e) {
      return [];
    }
  }

  static Future<String> getDataTheLoaiMon() async {
    String stConnection = "$urlAPI/read_theloaimon.php";

    try {
      var response = await http.get(Uri.parse(stConnection)).timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          return http.Response('404', 404);
        },
      );

      return response.body;
    } on TimeoutException catch (_) {
      // A timeout occurred.
      return "404";
    } on SocketException catch (_) {
      // Other exception
      return "404";
    } catch (e) {
      return "404";
    }
  }

  static Future<String> getDataDanhMuc() async {
    String stConnection = "$urlAPI/read_danhmuc.php";

    try {
      var response = await http.get(Uri.parse(stConnection)).timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          return http.Response('404', 404);
        },
      );

      return response.body;
    } on TimeoutException catch (_) {
      // A timeout occurred.
      return "404";
    } on SocketException catch (_) {
      // Other exception
      return "404";
    } catch (e) {
      return "404";
    }
  }

  static Future<String> getDataDo() async {
    String stConnection = "$urlAPI/read_do.php";

    try {
      var response = await http.get(Uri.parse(stConnection)).timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          return http.Response('404', 404);
        },
      );

      return response.body;
    } on TimeoutException catch (_) {
      // A timeout occurred.
      return "404";
    } on SocketException catch (_) {
      // Other exception
      return "404";
    } catch (e) {
      return "404";
    }
  }

  static Future<String> getOder({required String idGoiMon}) async {
    String stConnection = "$urlAPI/read_oder.php";

    try {
      var response = await http
          .post(Uri.parse(stConnection), body: {"id_goi_do": idGoiMon}).timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          return http.Response('404', 404);
        },
      );

      return response.body;
    } on TimeoutException catch (_) {
      // A timeout occurred.
      return "404";
    } on SocketException catch (_) {
      // Other exception
      return "404";
    } catch (e) {
      return "404";
    }
  }

  static Future<String> getCTHD({required String idGoiMon}) async {
    String stConnection = "$urlAPI/read_cthd.php";
    try {
      var response = await http
          .post(Uri.parse(stConnection), body: {"idGoiDo": idGoiMon}).timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          return http.Response('404', 408);
        },
      );

      return response.body;
    } on TimeoutException catch (_) {
      // A timeout occurred.
      return "404";
    } on SocketException catch (_) {
      // Other exception
      return "404";
    } catch (e) {
      return "404";
    }
  }

  static Future<String> getDSTaiKhoan() async {
    String stConnection = "$urlAPI/read_ds_taikhoan.php";
    try {
      var response = await http.post(Uri.parse(stConnection)).timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          return http.Response('404', 408);
        },
      );

      return response.body;
    } on TimeoutException catch (_) {
      // A timeout occurred.
      return "404";
    } on SocketException catch (_) {
      // Other exception
      return "404";
    } catch (e) {
      return "404";
    }
  }

  static Future<String> insertTaiKhoan({required TaiKhoan taiKhoan}) async {
    String stConnection = "$urlAPI/insert_taikhoan.php";
    try {
      var response = await http
          .post(Uri.parse(stConnection), body: taiKhoan.toMap())
          .timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          return http.Response('404', 408);
        },
      );

      return response.body;
    } on TimeoutException catch (_) {
      // A timeout occurred.
      return "404";
    } on SocketException catch (_) {
      // Other exception
      return "404";
    } catch (e) {
      return "404";
    }
  }

  static Future<String> updateTaiKhoan({required TaiKhoan taiKhoan}) async {
    String stConnection = "$urlAPI/update_taikhoan.php";
    try {
      var response = await http
          .post(Uri.parse(stConnection), body: taiKhoan.toMap())
          .timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          return http.Response('404', 408);
        },
      );

      return response.body;
    } on TimeoutException catch (_) {
      // A timeout occurred.
      return "404";
    } on SocketException catch (_) {
      // Other exception
      return "404";
    } catch (e) {
      return "404";
    }
  }

  static Future<String> deleteTaiKhoan({required TaiKhoan taiKhoan}) async {
    String stConnection = "$urlAPI/delete_taikhoan.php";
    try {
      var response = await http
          .post(Uri.parse(stConnection), body: taiKhoan.toMap())
          .timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          return http.Response('404', 408);
        },
      );

      return response.body;
    } on TimeoutException catch (_) {
      // A timeout occurred.
      return "404";
    } on SocketException catch (_) {
      // Other exception
      return "404";
    } catch (e) {
      return "404";
    }
  }

  static Future<ThongKe> getThongKe(
      {required String ngay, required String ngayNow}) async {
    String stConnection = "$urlAPI/read_tk_ngay.php";
    try {
      var response = await http.post(Uri.parse(stConnection), body: {
        "ngay": ngay,
        "ngay_now": ngayNow,
      }).timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          // Time has run out, do what you wanted to do.
          // Request Timeout response status code
          return http.Response('404', 408);
        },
      );
      var banObjsJson = jsonDecode(response.body);

      ThongKe banObjects = ThongKe.fromJson(banObjsJson);
      return banObjects;
    } catch (e) {
      return ThongKe(
          doanhThu: DoanhThu(doanhThu: ""), doanhThuDo: [], doanhThuTuan: []);
    }
  }

  static Future<ThongKe> getThongKeThang({required String ngay}) async {
    String stConnection = "$urlAPI/read_tk_thang.php";
    try {
      var response = await http.post(Uri.parse(stConnection), body: {
        "ngay": ngay,
      }).timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          return http.Response('404', 408);
        },
      );
      var banObjsJson = jsonDecode(response.body);

      ThongKe banObjects = ThongKe.fromJson(banObjsJson);
      return banObjects;
    } catch (e) {
      return ThongKe(
          doanhThu: DoanhThu(doanhThu: ""), doanhThuDo: [], doanhThuTuan: []);
    }
  }

  static Future<bool> insert(
      {required Goido goimon, required String idBan}) async {
    String stConnection = "$urlAPI/insert_oder.php";
    try {
      var response = await http
          .post(Uri.parse(stConnection), body: goimon.toJson(idBan: idBan))
          .timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          return http.Response('404', 408);
        },
      );
      ;

      String st = response.body.trim();
      if (st.compareTo("1") == 0) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<String> insertCTGD(
      ChiTietGoiDo chiTietGoiMon, String idGoiMon) async {
    String stConnection = "$urlAPI/insert_chitietgoido.php";
    try {
      var response = await http.post(Uri.parse(stConnection), body: {
        "soLuong": chiTietGoiMon.soLuong,
        "idDo": chiTietGoiMon.doo.id,
        "idGoiDo": idGoiMon,
        "thoiGian": GetDateTime.getTimeNow()
      }).timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          return http.Response('404', 408);
        },
      );

      String st = response.body.trim();
      return st;
    } catch (e) {
      return "404";
    }
  }

  static Future<String> thanhToan(String idGoiMon) async {
    String stConnection = "$urlAPI/thanhtoan.php";
    try {
      var response = await http.post(Uri.parse(stConnection), body: {
        "idGoiDo": idGoiMon,
      }).timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          return http.Response('404', 408);
        },
      );
      String st = response.body.trim();
      return st;
    } on TimeoutException catch (_) {
      // A timeout occurred.
      return "404";
    } on SocketException catch (_) {
      // Other exception
      return "404";
    } catch (e) {
      return "404";
    }
  }

  static Future<String> insertCTHD(
      {required String idDo,
      required String idGoiMon,
      required String soLuong}) async {
    String stConnection = "$urlAPI/insert_cthd.php";
    var response = await http.post(Uri.parse(stConnection), body: {
      "idDo": idDo,
      "idGoiDo": idGoiMon,
      "soLuong": soLuong,
    }).timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        return http.Response('404', 408);
      },
    );

    String st = response.body.trim();
    return st;
  }

  static Future<String> updateCTHD(
      {required String id,
      required String soLuongPV,
      required String trangThai}) async {
    String stConnection = "$urlAPI/update_chitietgoido.php";
    var response = await http.post(Uri.parse(stConnection), body: {
      "id": id,
      "soLuong": soLuongPV,
      "trangThai": trangThai,
    }).timeout(
      const Duration(seconds: 20),
      onTimeout: () {
        return http.Response("404", 404);
      },
    );

    String st = response.body.trim();
    return st;
  }

  static Future<String> updateTrangThaiCTGD(
      {required String id,
      required String soLuongPV,
      required String trangThai}) async {
    String stConnection = "$urlAPI/update_trangthai_ctgd.php";
    var response = await http.post(Uri.parse(stConnection), body: {
      "id": id,
      "trangThai": trangThai,
    }).timeout(
      const Duration(seconds: 20),
      onTimeout: () {
        return http.Response("404", 404);
      },
    );

    String st = response.body.trim();
    return st;
  }

  static Future<String> insertBan(
      {required String id,
      required String soTT,
      required String idTheLoai,
      required String trangThai}) async {
    String stConnection = "$urlAPI/insert_ban.php";
    var response = await http.post(Uri.parse(stConnection), body: {
      "id": id,
      "soTT": soTT,
      "trangThai": trangThai,
      "idTheLoai": idTheLoai
    }).timeout(
      const Duration(seconds: 20),
      onTimeout: () {
        return http.Response("404", 404);
      },
    );

    String st = response.body.trim();
    return st;
  }

  static Future<String> updateBan(
      {required String id,
      required String soTT,
      required String idTheLoai,
      required String trangThai}) async {
    String stConnection = "$urlAPI/update_ban.php";
    var response = await http.post(Uri.parse(stConnection), body: {
      "id": id,
      "soTT": soTT,
      "trangThai": trangThai,
      "idTheLoai": idTheLoai
    }).timeout(
      const Duration(seconds: 20),
      onTimeout: () {
        return http.Response("404", 404);
      },
    );

    String st = response.body.trim();
    return st;
  }

  static Future<String> updateHoaDon({
    required String idDo,
    required String soLuong,
    required String idGoiDo,
  }) async {
    String stConnection = "$urlAPI/update_cthd.php";
    var response = await http.post(Uri.parse(stConnection), body: {
      "idDo": idDo,
      "soLuong": soLuong,
      "idGoiDo": idGoiDo,
    }).timeout(
      const Duration(seconds: 20),
      onTimeout: () {
        return http.Response("404", 404);
      },
    );

    String st = response.body.trim();
    return st;
  }

  static Future<String> insertTheLoaiBan({required TheLoaiBan tlb}) async {
    String stConnection = "$urlAPI/insert_tlb.php";
    var response =
        await http.post(Uri.parse(stConnection), body: tlb.toJson()).timeout(
      const Duration(seconds: 20),
      onTimeout: () {
        return http.Response("404", 404);
      },
    );

    String st = response.body.trim();
    return st;
  }

  static Future<String> updateTheLoaiBan({required TheLoaiBan tlb}) async {
    String stConnection = "$urlAPI/update_tlb.php";
    var response =
        await http.post(Uri.parse(stConnection), body: tlb.toJson()).timeout(
      const Duration(seconds: 20),
      onTimeout: () {
        return http.Response("404", 404);
      },
    );

    String st = response.body.trim();
    return st;
  }

  static Future<String> updateDo({required Do insDo}) async {
    String stConnection = "$urlAPI/update_do.php";
    var response =
        await http.post(Uri.parse(stConnection), body: insDo.toJson()).timeout(
      const Duration(seconds: 20),
      onTimeout: () {
        return http.Response("404", 404);
      },
    );

    String st = response.body.trim();
    return st;
  }

  static Future<String> insertDo({required Do insDo}) async {
    String stConnection = "$urlAPI/insert_do.php";
    var response =
        await http.post(Uri.parse(stConnection), body: insDo.toJson()).timeout(
      const Duration(seconds: 20),
      onTimeout: () {
        return http.Response("404", 404);
      },
    );

    String st = response.body.trim();
    return st;
  }

  static Future<String> insertCombo(
      {required Combo combo, required String idDo}) async {
    String stConnection = "$urlAPI/insert_combo.php";
    var response = await http.post(Uri.parse(stConnection),
        body: {"idDo": idDo, "tenThanhPhan": combo.tenThanhPhan}).timeout(
      const Duration(seconds: 20),
      onTimeout: () {
        return http.Response("404", 404);
      },
    );

    String st = response.body.trim();
    return st;
  }

  static Future<String> deleteCombo({required String idDo}) async {
    String stConnection = "$urlAPI/delete_combo.php";
    var response = await http.post(Uri.parse(stConnection), body: {
      "idDo": idDo,
    }).timeout(
      const Duration(seconds: 20),
      onTimeout: () {
        return http.Response("404", 404);
      },
    );

    String st = response.body.trim();
    return st;
  }

  static Future<String> deleteCTGD({required String id}) async {
    String stConnection = "$urlAPI/delete_ctgd.php";
    var response = await http.post(Uri.parse(stConnection), body: {
      "id": id,
    }).timeout(
      const Duration(seconds: 20),
      onTimeout: () {
        return http.Response("404", 404);
      },
    );

    String st = response.body.trim();
    return st;
  }
}
