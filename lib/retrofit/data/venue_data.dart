import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:toptekker/retrofit/services/web_service.dart';
import 'package:toptekker/screens/venue_screen.dart';

import '../Apis.dart';
part 'gdart/venue_data.g.dart';
@JsonSerializable()
class VenueData {
  @JsonKey(name: "id")
  final String id;
  @JsonKey(name: "title")
  final String title;
  @JsonKey(name: "slug")
  final String slug;
  @JsonKey(name: "parent")
  final String parent;
  @JsonKey(name: "leval")
  final String leval;
  @JsonKey(name: "description")
  final String description;
  @JsonKey(name: "image")
  final String image;
  @JsonKey(name: "status")
  final String status;
  @JsonKey(name: "Count")
  final String Count;
  @JsonKey(name: "PCount")
  final String PCount;

  VenueData(this.id, this.title, this.slug, this.parent, this.leval, this.description, this.image, this.status, this.Count, this.PCount);

  factory VenueData.fromJson(Map<String, dynamic> venueData) {
    return VenueData(venueData['id'],
      venueData['title'],
      venueData['slug'],
      venueData['parent'],
      venueData['leval'],
      venueData['description'],
      venueData['image'],
      venueData['status'],
      venueData['Count'],
      venueData['PCount']);
  }

  static Resource<List<VenueData>> get all {

    return Resource(
        url: Apis.get_categories,
        parse: (response) {
          final result = json.decode(response.body);
          Iterable list = result['data'];
          return list.map((model) => VenueData.fromJson(model)).toList();
        }
    );

  }

}
