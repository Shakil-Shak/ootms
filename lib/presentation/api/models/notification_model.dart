

class NotificationModel {
  bool isRead;
  String id;
  String message;
  String linkId;
  String type;
  String role;
  String sender;
  String receiver;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  NotificationModel({
    this.isRead = false,
    this.id = "",
    this.message = "",
    this.linkId = "",
    this.type = "",
    this.role = "",
    this.sender = "",
    this.receiver = "",
    DateTime? createdAt,
    DateTime? updatedAt,
    this.v = 0,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      isRead: json["isRead"] ?? false,
      id: json["_id"] ?? "",
      message: json["message"] ?? "",
      linkId: json["linkId"] ?? "",
      type: json["type"] ?? "",
      role: json["role"] ?? "",
      sender: json["sender"] ?? "",
      receiver: json["receiver"] ?? "",
      createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : null,
      updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : null,
      v: json["__v"] ?? 0,
    );
  }
}
