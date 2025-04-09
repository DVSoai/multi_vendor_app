
class RegisterModel {
final  String username;
final  String email;
final String password;


  RegisterModel({
    required this.username,
    required this.email,
    required this.password,

  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      username: json['username'],
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'password': password,
    };
  }
}