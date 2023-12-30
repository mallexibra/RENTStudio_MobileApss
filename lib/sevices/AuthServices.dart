import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {
  final dio = Dio();

  Future<Map> login({required String email, required String password}) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var response = await dio.post("http://localhost:8000/api/login",
          options: Options(headers: {"Content-Type": "application/json"}),
          data: {"email": email, "password": password});

      Map obj = response.data;
      if (!obj['status']) {
        return obj;
      }

      await prefs.setString('token', obj['token']);
      await prefs.setBool('isLogin', obj['status']);

      return obj;
    } catch (e) {
      return {"message": e.toString()};
    }
  }
}
