
class UserModel {
  late int id;
  late String name;
  late String email;
  late String telephone;
  late String roles;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.roles,
    required this.telephone,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      telephone: json['telephone'],
      roles: json['roles'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,
      'name': name,
      'email': email,
      'roles': roles,
      'telephone': telephone,
    };

    return data;
  }

 
}
