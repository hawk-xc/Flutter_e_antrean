class DeviceModel {
  final int id;
  final int userId;
  final String? userName;
  final String deviceName;
  final String deviceYear; // Changed to String to match API
  final String createdAt;
  final String updatedAt;
  final String? driveLink;
  final String imageLink;
  final String? createdAtDiff;

  DeviceModel({
    required this.id,
    required this.userId,
    required this.userName,
    required this.deviceName,
    required this.deviceYear,
    required this.createdAt,
    required this.updatedAt,
    this.driveLink,
    required this.imageLink,
    required this.createdAtDiff,
  });

  factory DeviceModel.fromJson(Map<String, dynamic> json) {
    return DeviceModel(
      id: json['id'],
      userId: json['user_id'],
      userName: json['user_name'],
      deviceName: json['device_name'],
      deviceYear: json['device_year'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      driveLink: json['drive_link'],
      imageLink: json['image_link'],
      createdAtDiff: json['created_at_diff'],
    );
  }
}
