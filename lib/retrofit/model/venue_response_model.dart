import 'package:json_annotation/json_annotation.dart';
import 'package:toptekker/retrofit/data/venue_data.dart';

@JsonSerializable()
class VenueResponseModel{
  @JsonKey(name:"responce")
  final bool? responce;

  @JsonKey(name:"data")
  final List<VenueData> data;

  VenueResponseModel(this.responce, this.data);

}