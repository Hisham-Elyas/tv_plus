// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final String? userId;
  final String? userName;
  final String email;
  final String? phone;
  final String? password;

  UserModel({
    this.phone,
    this.userId,
    this.userName,
    required this.email,
    this.password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'User_Name': userName,
      'User_Id': userId,
      'User_Email': email,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['User_Id'] != null ? map['User_Id'] as String : null,
      userName: map['User_Name'] != null ? map['User_Name'] as String : null,
      email: map['User_Email'] as String,
    );
  }

  @override
  bool operator ==(covariant UserModel other) {
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

  @override
  String toString() {
    return 'UserModel(userId: $userId, userName: $userName, email: $email, password: $password)';
  }
}
