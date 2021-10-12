// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../check_validate_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckValidUserResponseModel _$CheckValidUserResponseModelFromJson(
        Map<String, dynamic> json) =>
    CheckValidUserResponseModel(
      json['responce'] as bool?,
      ValidateUserData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CheckValidUserResponseModelToJson(
        CheckValidUserResponseModel instance) =>
    <String, dynamic>{
      'responce': instance.responce,
      'data': instance.data,
    };
