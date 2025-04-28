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

  factory User.getNewEmptyUser() {
    return User(
      id: '',
      name: '',
      password: '',
      email: '',
      address: '',
      type: '',
      token: '',
    );
  }

  Map<String, dynamic> toMap() {
    // Convert the User object to a Map<String, dynamic>
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

  // Convert the Map<String, dynamic> back to a User object
  factory User.fromMap(Map<String, dynamic> json) {
    return User(
      // 'name' => User.name
      id: json['_id'] != null ? json['_id'] as String : '',
      name: json['name'] != null ? json['name'] as String : '',
      password: json['password'] != null ? json['password'] as String : '',
      address: json['address'] != null ? json['address'] as String : '',
      email: json['email'] != null ? json['email'] as String : '',
      type: json['type'] != null ? json['type'] as String : '',
      token: json['token'] != null ? json['token'] as String : '',
    );
  }

  String toJson() => json.encode(toMap());
  //toJson(): user object to map => map to json(string using json.encode()) (encrypt it)

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
  // source is the String(JSON) from Api
  // json to map(json.decode(source)) => map to User object (using fromMap()) (decrypt it)
}
