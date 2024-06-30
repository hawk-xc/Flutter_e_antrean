import 'package:dio/dio.dart';
import 'package:flutter_e_service_app/helpers/api_client.dart';
import 'package:flutter_e_service_app/helpers/user_info.dart';
import 'package:flutter_e_service_app/model/device_model.dart';
import 'package:flutter_e_service_app/model/ticket_model.dart';

class TicketController {
  final ApiClient apiClient = ApiClient();
  final UserInfo userInfo = UserInfo();

  Future<List<DeviceModel>> fetchDevices() async {
    try {
      String? accessToken = await userInfo.getToken();
      if (accessToken == null) {
        throw Exception('No access token found');
      }

      Response response = await apiClient
          .get('device', headers: {'Authorization': 'Bearer $accessToken'});

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['data'];
        return data
            .map((deviceJson) => DeviceModel.fromJson(deviceJson))
            .toList();
      } else {
        throw Exception('Failed to load devices: ${response.statusCode}');
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print(
            'Dio error response: ${e.response!.statusCode} - ${e.response!.statusMessage}');
        throw Exception('Failed to load devices: ${e.response!.statusCode}');
      } else {
        print('Dio error: ${e.message}');
        throw Exception('Failed to load devices: ${e.message}');
      }
    } catch (e) {
      print('General error: $e');
      throw Exception('Failed to load devices: $e');
    }
  }

  Future<List<Ticket>> fetchTickets() async {
    try {
      String? accessToken = await userInfo.getToken();
      if (accessToken == null) {
        throw Exception('No access token found');
      }

      Response response = await apiClient
          .get('antrean', headers: {'Authorization': 'Bearer $accessToken'});

      if (response.statusCode == 200) {
        // Ubah respons JSON yang diterima menjadi list dynamic
        List<dynamic> data = response.data;

        // Karena respons dari Laravel adalah array dalam array, ambil array pertama
        List<dynamic> ticketsData = data.isNotEmpty ? data[0] : [];

        // Mapping data tiket ke model Ticket
        List<Ticket> tickets =
            ticketsData.map((json) => Ticket.fromJson(json)).toList();

        return tickets;
      } else {
        throw Exception('Failed to load tickets: ${response.statusCode}');
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print(
            'Dio error response: ${e.response!.statusCode} - ${e.response!.statusMessage}');
        throw Exception('Failed to load tickets: ${e.response!.statusCode}');
      } else {
        print('Dio error: ${e.message}');
        throw Exception('Failed to load tickets: ${e.message}');
      }
    } catch (e) {
      print('General error: $e');
      throw Exception('Failed to load tickets: $e');
    }
  }

  Future<bool> show(String id) async {
    try {
      final response = await apiClient.get('antrean/$id');
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error: $e');
      return false;
    }
  }

  Future<bool> store(
      String deviceName, String description, String driveLink) async {
    try {
      final response = await apiClient.post('antrean', {
        // 'user_id': userId,
        'device_name': deviceName,
        // 'device_year': deviceYear,
        'description': description,
        'image_link': driveLink,
      });

      if (response.statusCode == 200) {
        // print(response.data['data']);
        return true;
      } else {
        // ignore: avoid_print
        print('Error: ${response.statusCode} - ${response.data}');
        return false;
      }
    } catch (e) {
      // print('Registration error: $e');
      // ignore: avoid_print
      print('Error: $e');
      return false;
    }
  }

  Future<bool> update(
      int id, String deviceName, String description, String driveLink) async {
    try {
      final response = await apiClient.put('antrean/$id', {
        // 'user_id': userId,
        'device_name': deviceName,
        'description': description,
        'image_link': driveLink,
      });
      print(deviceName);

      if (response.statusCode == 200) {
        return true;
      } else {
        // ignore: avoid_print
        print('Error: ${response.statusCode} - ${response.data}');
        return false;
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error: $e');
      return false;
    }
  }

  Future<void> destroy(int id) async {
    try {
      final response = await apiClient.delete('antrean/$id');
      if (response.statusCode != 200) {
        throw Exception('Failed to delete device');
      }
    } catch (e) {
      // Log error if necessary
      throw Exception('Failed to delete device: $e');
    }
  }
}
