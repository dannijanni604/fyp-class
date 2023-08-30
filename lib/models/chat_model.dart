class ChatModel {
  final List<String> uid;
  final String message;
  final String sendBy;
  final String sendAt;

  ChatModel({
    required this.uid,
    required this.message,
    required this.sendBy,
    required this.sendAt,
  });

  factory ChatModel.fromJson(Map<String, dynamic> res) {
    return ChatModel(
      uid: res['uid'],
      message: res['message'],
      sendBy: res['sendBy'],
      sendAt: res['sendAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'message': message,
      'sendBy': sendBy,
      'sendAt': sendAt,
    };
  }
}
