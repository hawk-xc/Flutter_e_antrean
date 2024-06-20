import '../helpers/api_client.dart';
import 'package:flutter_e_service_app/model/device_model.dart';

class DeviceController {
  final ApiClient _apiClient = ApiClient();

  Future index() async {
    try {
      final response = await _apiClient.get('device');

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['data'];
        return data
            .map((deviceJson) => DeviceModel.fromJson(deviceJson))
            .toList();
      } else {
        throw Exception('Failed to load devices');
      }
    } catch (e) {
      return e;
    }
  }

  Future<bool> store(String userId, String deviceName, String deviceYear,
      String driveLink) async {
    try {
      final response = await _apiClient.post('store', {
        'user_id': userId,
        'device_name': deviceName,
        'device_year': deviceYear,
        'drive_link': driveLink,
      });

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      // print('Registration error: $e');
      return false;
    }
  }
}
