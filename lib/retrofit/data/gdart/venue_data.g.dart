// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../venue_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VenueData _$VenueDataFromJson(Map<String, dynamic> json) => VenueData(
      json['id'] as String,
      json['title'] as String,
      json['slug'] as String,
      json['parent'] as String,
      json['leval'] as String,
      json['description'] as String,
      json['image'] as String,
      json['status'] as String,
      json['Count'] as String,
      json['PCount'] as String,
    );

Map<String, dynamic> _$VenueDataToJson(VenueData instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'slug': instance.slug,
      'parent': instance.parent,
      'leval': instance.leval,
      'description': instance.description,
      'image': instance.image,
      'status': instance.status,
      'Count': instance.Count,
      'PCount': instance.PCount,
    };
