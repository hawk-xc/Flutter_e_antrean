import '../helpers/api_client.dart';

class DeviceController {
  final ApiClient _apiClient = ApiClient();

  Future index() async {
    try {
      final response = await _apiClient.get('device');

      if (response.statusCode == 200) {
        return response.data;
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
