import 'dart:convert';

class User {
  final String id;
  final String name;
  final String password;
  final String address;
  final String email;
  final String type;
  final String token;
  final List<dynamic> cart;

  User({
    required this.id,
    required this.name,
    required this.password,
    required this.email,
    required this.address,
    required this.type,
    required this.token,
    required this.cart,
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
      cart: [],
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
      'cart': cart,
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
      // cart: json['cart'] != null ? json['cart'] as List<dynamic> : [],
      cart:
          json['cart'] != null
              ? List<Map<String, dynamic>>.from(
                json['cart'].map((x) => Map<String, dynamic>.from(x)),
              )
              : [],
    );
  }

  String toJson() => json.encode(toMap());
  //toJson(): user object to map => map to json(string using json.encode()) (encrypt it)

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
  // source is the String(JSON) from Api
  // json to map(json.decode(source)) => map to User object (using fromMap()) (decrypt it)

  User copyWith({
    String? id,
    String? name,
    String? password,
    String? address,
    String? email,
    String? type,
    String? token,
    List<dynamic>? cart,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      password: password ?? this.password,
      address: address ?? this.address,
      email: email ?? this.email,
      type: type ?? this.type,
      token: token ?? this.token,
      cart: cart ?? this.cart,
    );
    //(cart sys make a copy of user data) if data found take it isNotFound ? return empty values
  }
}
