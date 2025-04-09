import 'package:freezed_annotation/freezed_annotation.dart';
@JsonSerializable()
class UserModel {
  @JsonKey(name: '_id')
  final String? id;
  final String? username;
  final String? email;
  final String? fcm;
  final bool? verification;
  final String? phone;
  final bool? phoneVerification;
  final String? userType;
  final String? profile;
  final String? userToken;

  UserModel({
    this.id,
    this.username,
    this.email,
    this.fcm,
    this.verification,
    this.phone,
    this.phoneVerification,
    this.userType,
    this.profile,
    this.userToken,
  });

  factory UserModel.fromJson(dynamic json) {

    return UserModel(
      id: json['_id'],
      username: json['username'],
      email: json['email'],
      fcm: json['fcm'],
      verification: json['verification'],
      phone: json['phone'],
      phoneVerification: json['phoneVerification'],
      userType: json['userType'],
      profile: json['profile'],
      userToken: json['userToken'],
    );
  }
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['username'] = username;
    map['email'] = email;
    map['fcm'] = fcm;
    map['verification'] = verification;
    map['phone'] = phone;
    map['phoneVerification'] = phoneVerification;
    map['userType'] = userType;
    map['profile'] = profile;
    map['userToken'] = userToken;
    return map;
    // return {
    //   '_id': id,
    //   'username': username,
    //   'email': email,
    //   'fcm': fcm,
    //   'verification': verification,
    //   'phone': phone,
    //   'phoneVerification': phoneVerification,
    //   'userType': userType,
    //   'profile': profile,
    //   'userToken': userToken,
    // };
  }
}