import 'package:dio/dio.dart';
import 'package:flutter_e_service_app/helpers/user_info.dart';

// Inisialisasi objek Dio dengan pengaturan dasar
final Dio dio = Dio(BaseOptions(
  baseUrl: 'http://localhost:8000/api/', // URL dasar untuk API
  // baseUrl:
  //     'https://effb-103-164-115-58.ngrok-free.app/api/', // URL dasar untuk API
  connectTimeout: const Duration(
      seconds:
          5000), // Waktu maksimum untuk mencoba menghubungkan (dalam milidetik)
  receiveTimeout: const Duration(
      seconds: 3000), // Waktu maksimum untuk menerima respons (dalam milidetik)
));

// Kelas ApiClient untuk menangani permintaan HTTP
class ApiClient {
  final UserInfo _userInfo = UserInfo();

  Future<Map<String, dynamic>> _getHeaders() async {
    final token = await _userInfo.getToken();
    return {
      'Authorization': 'Bearer $token',
      // 'Authorization':
      //     'Bearer 2|H0OEPtrPor4anQPXelHTs44Dk7s3Rpq9JP6SiglC4b6f6d16',
    };
  }

  Future<Response> getUserData() async {
    try {
      final headers = await _getHeaders();
      final response = await dio.get(
        'user',
        options: Options(headers: headers),
      );
      return response;
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  // Metode untuk melakukan permintaan GET
  Future<Response> get(String path, {Map<String, dynamic>? headers}) async {
    try {
      final headers = await _getHeaders();
      final response = await dio.get(
        Uri.encodeFull(path),
        options: Options(headers: headers),
      ); // Melakukan permintaan GET
      return response;
    } on DioException catch (e) {
      throw Exception(e.message); // Menangani kesalahan permintaan
    }
  }

  // Metode untuk melakukan permintaan POST
  Future<Response> post(String path, dynamic data) async {
    try {
      final headers = await _getHeaders();
      final response = await dio.post(Uri.encodeFull(path),
          data: data,
          options: Options(
              headers: headers)); // Melakukan permintaan POST dengan data
      return response;
    } on DioException catch (e) {
      throw Exception(e.message); // Menangani kesalahan permintaan
    }
  }

  // Metode untuk melakukan permintaan PUT
  Future<Response> put(String path, dynamic data) async {
    try {
      final headers = await _getHeaders();
      final response = await dio.put(Uri.encodeFull(path),
          data: data,
          options: Options(
              headers: headers)); // Melakukan permintaan PUT dengan data
      return response;
    } on DioException catch (e) {
      throw Exception(e.message); // Menangani kesalahan permintaan
    }
  }

  // Metode untuk melakukan permintaan DELETE
  Future<Response> delete(String path) async {
    try {
      final headers = await _getHeaders();
      final response = await dio.delete(Uri.encodeFull(path),
          options: Options(headers: headers)); // Melakukan permintaan DELETE
      return response;
    } on DioException catch (e) {
      throw Exception(e.message); // Menangani kesalahan permintaan
    }
  }
}
