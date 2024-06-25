import 'package:flutter/material.dart';
import 'package:flutter_e_service_app/helpers/user_info.dart';
import 'package:flutter_e_service_app/helpers/api_client.dart';
import 'package:flutter_e_service_app/ui/login_view.dart';

class ProfileController {
  final UserInfo userInfo = UserInfo();
  final ApiClient _apiClient = ApiClient();

  Future<void> logout(BuildContext context) async {
    bool? shouldLogout = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi Logout'),
          content: const Text('Apakah Anda yakin ingin logout?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pop(false); // Tutup dialog dan kembalikan false
              },
              child: const Text('Tidak'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pop(true); // Tutup dialog dan kembalikan true
              },
              child: const Text('Ya'),
            ),
          ],
        );
      },
    );

    if (shouldLogout == true) {
      await userInfo.logout();
      String? token = await userInfo.getToken();
      if (token == null || token.isEmpty) {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(
              builder: (context) =>
                  const LoginView()), // Sesuaikan dengan nama widget splash screen Anda
        );
      }
    }
  }

  Future<Map<String, dynamic>> getUserData() async {
    String? token = await userInfo.getToken();

    if (token == null) {
      return {'error': 'No token found'};
    }

    try {
      final response = await _apiClient.get(
        'user',
        headers: {'Authorization': 'Bearer $token'},
      );
      return response.data;
    } catch (e) {
      return {'error': e.toString()};
    }
  }
}
