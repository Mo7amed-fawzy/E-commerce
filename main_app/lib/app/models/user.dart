import 'dart:convert';

class User {
  final String id;
  final String name;
  final String password;
  final String address;
  final String email;
  final String type;
  final String token;

  User({
    required this.id,
    required this.name,
    required this.password,
    required this.email,
    required this.address,
    required this.type,
    required this.token,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'password': password,
      'address': address,
      'email': email,
      'type': type,
      'token': token,
    };
  }

  factory User.fromMap(Map<String, dynamic> json) {
    return User(
      id: json['_id'] as String,
      name: json['name'] as String,
      password: json['password'] as String,
      address: json['address'] as String,
      email: json['email'] as String,
      type: json['type'] as String,
      token: json['token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
