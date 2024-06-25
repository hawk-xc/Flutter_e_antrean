// import 'package:dio/dio.dart';
import 'package:flutter_e_service_app/model/user_model.dart';
import 'package:flutter_e_service_app/helpers/api_client.dart';
import 'package:flutter_e_service_app/helpers/user_info.dart';

class LoginController {
  final ApiClient _apiClient = ApiClient();

  // Fungsi untuk memvalidasi kredensial login dengan API
  Future<bool> login(UserModel user) async {
    try {
      final response = await _apiClient.post('/login', user.toJson());

      // print(response);

      if (response.statusCode == 200) {
        // Memeriksa apakah login berhasil berdasarkan respons API
        final jsonData = response.data;
        final token =
            jsonData['token']; // Menyesuaikan dengan struktur API Anda

        // Menyimpan token dan email menggunakan SharedPreferences
        await UserInfo().setToken(token);

        // Menyimpan token dan email menggunakan SharedPreferences
        // await UserInfo().setEmail(email);

        return true;
      } else {
        // Menangani respons login yang tidak valid
        return false;
      }
    } catch (e) {
      // Menangani kesalahan (misalnya, masalah jaringan)
      // print('Login error: $e');
      return false;
    }
  }
}
