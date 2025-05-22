import 'dart:convert';

class LoginResponseModel {
  String? message;
  String? token;
  User? user;
  LoginResponseModel({
    this.message,
    this.token,
    this.user,
  });

  LoginResponseModel copyWith({
    String? message,
    String? token,
    User? user,
  }) {
    return LoginResponseModel(
      message: message ?? this.message,
      token: token ?? this.token,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'token': token,
      'user': user?.toMap(),
    };
  }

  factory LoginResponseModel.fromMap(Map<String, dynamic> map) {
    return LoginResponseModel(
      message: map['message'] != null ? map['message'] as String : null,
      token: map['token'] != null ? map['token'] as String : null,
      user: map['user'] != null
          ? User.fromMap(map['user'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginResponseModel.fromJson(String source) =>
      LoginResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'LoginResponseModel(message: $message, token: $token, user: $user)';

  @override
  bool operator ==(covariant LoginResponseModel other) {
    if (identical(this, other)) return true;

    return other.message == message &&
        other.token == token &&
        other.user == user;
  }

  @override
  int get hashCode => message.hashCode ^ token.hashCode ^ user.hashCode;
}

class User {
  int? id;
  String? username;
  String? email;
  String? phone;
  String? createdAt;
  User({
    this.id,
    this.username,
    this.email,
    this.phone,
    this.createdAt,
  });

  User copyWith({
    int? id,
    String? username,
    String? email,
    String? phone,
    String? createdAt,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'email': email,
      'phone': phone,
      'createdAt': createdAt,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] != null ? map['id'] as int : null,
      username: map['username'] != null ? map['username'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(id: $id, username: $username, email: $email, phone: $phone, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.username == username &&
        other.email == email &&
        other.phone == phone &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        username.hashCode ^
        email.hashCode ^
        phone.hashCode ^
        createdAt.hashCode;
  }
}
