import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:rent_mobileapps/sevices/ReviewServices.dart';
import 'package:rent_mobileapps/sevices/Variables.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudioServices {
  final dio = Dio();
  final url = Variables().url;

  getStudio() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      var response = await dio.get("$url/studios",
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          }));

      Map obj = response.data;

      if (obj['status']) {
        final data = jsonEncode(obj['data']);

        prefs.setString('studios', data);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  getDetailStudio({required int id}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      var response = await dio.get("$url/studios/$id",
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          }));

      Map obj = response.data;

      if (obj['status']) {
        final dataReviews = await ReviewServices().getReviewsByStudio(id);
        final data = obj['data'];
        print({...data, 'reviews': dataReviews});
        return {...data, 'reviews': dataReviews};
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  searchStudio(String search) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      var response = await dio.get("$url/studios?query=$search",
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          }));

      Map obj = response.data;

      if (obj['status']) {
        final data = jsonEncode(obj['data']);

        prefs.setString('studios', data);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  bookingStudio(String id_user, String id_studio, String nama, File bukti,
      String nameBukti, String harga) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      var formData = FormData.fromMap({
        "id_user": id_user,
        "id_studio": id_studio,
        "nama": nama,
        "bukti": await MultipartFile.fromFile(bukti.path, filename: nameBukti),
        "harga": harga
      });

      var response = await dio.post("$url/transaksi",
          data: formData,
          options: Options(headers: {
            "Content-Type": "multipart/form-data",
            "Authorization": "Bearer $token"
          }));

      Map obj = response.data;
      if (obj['status']) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
