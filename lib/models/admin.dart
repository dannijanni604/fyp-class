// To parse this JSON data, do
//
//     final admin = adminFromJson(jsonString);

import 'dart:convert';

Admin adminFromJson(String str) => Admin.fromJson(json.decode(str));

String adminToJson(Admin data) => json.encode(data.toJson());

class Admin {
  Admin({
    required this.uid,
    required this.name,
    required this.groupId,
    required this.email,
  });

  final String uid;
  final String name;
  final String groupId;
  final String email;

  factory Admin.fromJson(Map<String, dynamic> json) => Admin(
        uid: json["uid"],
        name: json["name"],
        groupId: json["group_id"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "group_id": groupId,
        "email": email,
      };
}
