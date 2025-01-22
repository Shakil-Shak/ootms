
class ChatModel {
  String chat;
  String text;
  String imageUrl;
  bool seen;
  String sender;
  bool showButton;
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  ChatModel({
    this.chat = '',
    this.text = '',
    this.imageUrl = '',
    this.seen = false,
    this.sender = '',
    this.showButton = false,
    this.id = '',
    DateTime? createdAt,
    DateTime? updatedAt,
    this.v = 0,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      chat: json['chat'] ?? '',
      text: json['text'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      seen: json['seen'] ?? false,
      sender: json['sender'] ?? '',
      showButton: json['showButton'] ?? false,
      id: json['_id'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
      v: json['__v'] ?? 0,
    );
  }
}