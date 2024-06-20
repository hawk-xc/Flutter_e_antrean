class DeviceModel {
  // ignore: non_constant_identifier_names
  int? userId;
  String? deviceName;
  int? deviceYear;
  String? driveLink;

  DeviceModel(
      {required this.userId,
      required this.deviceName,
      required this.deviceYear,
      required this.driveLink});

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'device_name': deviceName,
      'device_year': deviceYear,
      'drive_link': driveLink
    };
  }

  factory DeviceModel.fromJson(Map<String, dynamic> json) {
    return DeviceModel(
      userId: json['user_id'],
      deviceName: json['device_name'],
      deviceYear: json['device_year'],
      driveLink: json['driveLink'],
    );
  }
}
