class Ticket {
  final int id;
  final String idTicket;
  final int deviceId;
  final String description;
  final String createdAt;
  final String updatedAt;
  final String closedAt;
  final String imageLink;
  final String createdAtDiff;
  final int totalAntrean;
  final Process process;
  final Device device;

  Ticket({
    required this.id,
    required this.idTicket,
    required this.deviceId,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.closedAt,
    required this.imageLink,
    required this.createdAtDiff,
    required this.totalAntrean,
    required this.process,
    required this.device,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['id'] ?? 0,
      idTicket: json['id_ticket'] ?? '',
      deviceId: json['device_id'] ?? 0,
      description: json['description'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      closedAt: json['closed_at'] ?? '',
      imageLink: json['image_link'] ?? '',
      createdAtDiff: json['created_at_diff'] ?? '',
      totalAntrean: json['total_antrean'] ?? 0,
      process: Process.fromJson(json['proces'] ?? {}),
      device: Device.fromJson(json['device'] ?? {}),
    );
  }
}

class Process {
  final int id;
  final int statusId;
  final int ticketId;
  final int userId;
  final String createdAt;
  final String updatedAt;

  Process({
    required this.id,
    required this.statusId,
    required this.ticketId,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Process.fromJson(Map<String, dynamic> json) {
    return Process(
      id: json['id'] ?? 0,
      statusId: json['status_id'] ?? 0,
      ticketId: json['ticket_id'] ?? 0,
      userId: json['user_id'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}

class Device {
  final int id;
  final int userId;
  final String deviceName;
  final String deviceYear;
  final String createdAt;
  final String updatedAt;
  final String driveLink;
  final String imageLink;

  Device({
    required this.id,
    required this.userId,
    required this.deviceName,
    required this.deviceYear,
    required this.createdAt,
    required this.updatedAt,
    required this.driveLink,
    required this.imageLink,
  });

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      deviceName: json['device_name'] ?? '',
      deviceYear: json['device_year'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      driveLink: json['drive_link'] ?? '',
      imageLink: json['image_link'] ?? '',
    );
  }
}
