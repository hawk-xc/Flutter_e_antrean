import '../model/user_model.dart';
import '../helpers/api_client.dart';
import '../helpers/user_info.dart';

class LoginController {
  final ApiClient _apiClient = ApiClient();

  // Fungsi untuk memvalidasi kredensial login dengan API
  Future<bool> login(UserModel user) async {
    try {
      // Mengirim permintaan POST ke API untuk login
      final response = await _apiClient.post('/login', user.toJson());

      // Memeriksa status respons API
      if (response.statusCode == 200) {
        final jsonData = response.data;
        final token =
            jsonData['token']; // Menyesuaikan dengan struktur API Anda
        final username = jsonData['username'];

        // Menyimpan token dan username menggunakan SharedPreferences
        await UserInfo().setToken(token);
        await UserInfo().setUsername(username);

        return true;
      } else {
        // Menangani respons login yang tidak valid
        return false;
      }
    } catch (e) {
      // Menangani kesalahan (misalnya, masalah jaringan)
      print('Login error: $e');
      return false;
    }
  }
}
