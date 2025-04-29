import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? id;
  String? email;
  String? role;
  String? fullName;
  String? avatarUrl;

  UserModel({
    this.id,
    this.email,
    this.role,
    this.fullName,
    this.avatarUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        email: json["email"],
        role: json["role"],
        fullName: json["user_metadata"]?["full_name"],
        avatarUrl: json["user_metadata"]?["avatar_url"],
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        "id": id,
        "email": email,
        "full_name": fullName,
        "avatar_url": avatarUrl,
      };
}
