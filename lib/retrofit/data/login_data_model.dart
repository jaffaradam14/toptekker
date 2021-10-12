import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class LoginData {
  @JsonKey(name: "user_id")
  final String user_id;
  @JsonKey(name: "user_fullname")
  final String user_fullname;
  @JsonKey(name: "user_email")
  final String user_email;
  @JsonKey(name: "user_phone")
  final String user_phone;
  @JsonKey(name: "user_type_id")
  final String user_type_id;
  @JsonKey(name: "is_phone_verified")
  final String is_phone_verified;

  late BuildContext context;

  LoginData(
      this.user_id,
      this.user_fullname,
      this.user_email,
      this.user_phone,
      this.user_type_id,
      this.is_phone_verified);

  factory LoginData.fromJson(Map<String, dynamic> json){
    return LoginData(
      json['user_id'] as String,
      json['user_fullname'] as String,
       json['user_email'] as String,
       json['user_phone'] as String,
       json['user_type_id'] as String,
       json['is_phone_verified'] as String,
    );
  }
}
