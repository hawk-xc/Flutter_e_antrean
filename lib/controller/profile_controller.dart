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
                Navigator.of(context).pop(false);
              },
              child: const Text('Tidak'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
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
        Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (context) => const LoginView()),
        );
      }
    }
  }

  Future<bool> update(
    String username,
    String name,
    String email,
    String bPassword,
    String nPassword,
    String cPassword,
  ) async {
    try {
      final response = await _apiClient.put('profile/1', {
        'username': username,
        'name': name,
        'email': email,
        'b_password': bPassword,
        'n_password': nPassword,
        'c_password': cPassword,
      });

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<void> confirmUpdate(
      BuildContext context,
      String username,
      String name,
      String email,
      String bPassword,
      String nPassword,
      String cPassword) async {
    bool? shouldUpdate = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi Pembaruan data?'),
          content:
              const Text('Apakah Anda yakin ingin memperbarui data akun anda?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Tidak'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Ya'),
            ),
          ],
        );
      },
    );

    if (shouldUpdate == true) {
      bool success =
          await update(username, name, email, bPassword, nPassword, cPassword);
      if (success) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data berhasil diperbarui')),
        );
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data gagal diperbahrui!')),
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
        'profile',
        headers: {'Authorization': 'Bearer $token'},
      );
      return response.data;
    } catch (e) {
      return {'error': e.toString()};
    }
  }

  Future<void> deleteAccount(BuildContext context) async {
    String? token = await userInfo.getToken();

    if (token == null) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Gagal menghapus akun. Token tidak ditemukan.')),
      );
      return;
    }

    try {
      final response = await _apiClient.delete('profile/1');
      if (response.statusCode == 200) {
        await userInfo.logout();
        Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (context) => const LoginView()),
        );
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Akun berhasil dihapus')),
        );
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gagal menghapus akun')),
        );
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        // SnackBar(content: Text('Gagal menghapus akun. Error: $e')),
        const SnackBar(
            content: Text('Gagal menghapus akun. Akun dalam keadaan aktif')),
      );
    }
  }
}
