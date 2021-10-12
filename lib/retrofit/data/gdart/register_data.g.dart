// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../register_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterData _$RegisterDataFromJson(Map<String, dynamic> json) => RegisterData(
      user_id : json['user_id'] as int,
      user_fullname : json['user_fullname'] as String,
      user_email : json['user_email'] as String,
      user_phone : json['user_phone'] as String,
    );

Map<String, dynamic> _$RegisterDataToJson(RegisterData instance) =>
    <String, dynamic>{
      'user_id': instance.user_id,
      'user_fullname': instance.user_fullname,
      'user_email': instance.user_email,
      'user_phone': instance.user_phone,
    };
