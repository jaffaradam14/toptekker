// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../validate_user_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ValidateUserData _$ValidateUserDataFromJson(Map<String, dynamic> json) =>
    ValidateUserData(
      json['user_id'] as String,
      json['user_fullname'] as String,
      json['user_phone'] as String,
      json['user_image'] as String,
    );

Map<String, dynamic> _$ValidateUserDataToJson(ValidateUserData instance) =>
    <String, dynamic>{
      'user_id': instance.user_id,
      'user_fullname': instance.user_fullname,
      'user_phone': instance.user_phone,
      'user_image': instance.user_image,
    };
