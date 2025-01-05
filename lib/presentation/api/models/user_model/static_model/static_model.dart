class StaticContent {
  final String id;
  final String content;

  StaticContent({
    this.id = "",
    this.content = "",
  });

  factory StaticContent.fromJson(Map<String, dynamic> json) {
    return StaticContent(
      id: json['attributes']?['_id'] ?? "",
      content: json['attributes']?['content'] ?? "",
    );
  }

  // Method to convert the model back to JSON
  Map<String, dynamic> toJson() {
    return {
      "attributes": {
        "_id": id,
        "content": content,
      },
    };
  }
}
