// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SinupModel {
  final String? userId;
  final String userName;
  final String email;
  final String password;
  // final String phone;

  SinupModel({
    this.userId,
    required this.userName,
    required this.email,
    required this.password,
    // required this.phone,
  });

  SinupModel copyWith({
    String? userId,
    String? userName,
    String? email,
    String? password,
    // String? phone,
  }) {
    return SinupModel(
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      password: password ?? this.password,
      // phone: phone ?? this.phone,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'userName': userName,
      'email': email,
      'password': password,
      // 'phone': phone,
    };
  }

  factory SinupModel.fromMap(Map<String, dynamic> map) {
    return SinupModel(
      userId: map['userId'] != null ? map['userId'] as String : null,
      userName: map['userName'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      // phone: map['phone'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SinupModel.fromJson(String source) =>
      SinupModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SinupModel(userId: $userId, userName: $userName, email: $email, password: $password)';
  }

  @override
  bool operator ==(covariant SinupModel other) {
    if (identical(this, other)) return true;

    return other.userId == userId &&
        other.userName == userName &&
        other.email == email &&
        other.password == password;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        userName.hashCode ^
        email.hashCode ^
        password.hashCode;
  }
}
