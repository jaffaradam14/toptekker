import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class GetSportsResponseModel {
  @JsonKey(name: "id")
  final String id;
  @JsonKey(name: "bus_id")
  final String bus_id;
  @JsonKey(name: "category_id")
  final String category_id;
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

  GetSportsResponseModel(
      this.id,
      this.bus_id,
      this.category_id,
      this.title,
      this.slug,
      this.parent,
      this.leval,
      this.description,
      this.image,
      this.status);
}
