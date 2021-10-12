import 'package:flutter/material.dart';
import 'package:toptekker/retrofit/data/venue_data.dart';

class CategoryModel extends ChangeNotifier{
  VenueData venueData = VenueData("", "", "", "", "", "", "", "", "", "");

  VenueData get getVenueDetails => venueData;

  void setVenueDetails(VenueData venueData) {
    venueData = venueData;
    notifyListeners();
  }
}
