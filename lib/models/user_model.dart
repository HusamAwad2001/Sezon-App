enum UserRole { admin, user }

class UserModel {
  String id;
  final String userName;
  final String phone;
  final String password;
  final UserRole role;

  UserModel({
    required this.id,
    required this.userName,
    required this.phone,
    required this.password,
    this.role = UserRole.user,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      userName: json["userName"],
      phone: json["phone"],
      password: json["password"],
      role: json["role"] == "admin" ? UserRole.admin : UserRole.user,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "userName": userName,
      "phone": phone,
      "password": password,
      "role": role == UserRole.admin ? "admin" : "user",
    };
  }
}
