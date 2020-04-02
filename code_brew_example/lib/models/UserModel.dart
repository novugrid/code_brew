import 'package:code_brew/code_brew.dart';

///
/// project: code_brew
/// @package: 
/// @author dammyololade <dammyololade2010@gmail.com>
/// created on 2020-01-23

class UserModel extends CBBaseModel{
  UserData userData;
  bool success;

  UserModel({
    this.userData,
    this.success,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    userData: UserData.fromJson(json["data"]),
    success: json["success"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "success": success,
  };

  @override
  fromJson(Map<String, dynamic> response) {
    success = true;
    this.total = 100;
    this.data = UserData.fromJson(response["data"]).users;
    return this;
  }
}

class UserData {
  List<User> users;

  UserData({
    this.users,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "users": List<dynamic>.from(users.map((x) => x.toJson())),
  };
}

class User {
  String id;
  DateTime createdAt;
  String name;
  String avatar;
  String email;
  String address;

  User({
    this.id,
    this.createdAt,
    this.name,
    this.avatar,
    this.email,
    this.address,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    createdAt: DateTime.parse(json["createdAt"]),
    name: json["name"],
    avatar: json["avatar"],
    email: json["email"],
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "createdAt": createdAt.toIso8601String(),
    "name": name,
    "avatar": avatar,
    "email": email,
    "address": address,
  };
}
