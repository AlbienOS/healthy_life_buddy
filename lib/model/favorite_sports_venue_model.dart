import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteSportsVenue {
  late String sportsVenueId;

  FavoriteSportsVenue.fromObject(
      QueryDocumentSnapshot<Map<String, dynamic>> favoriteSportsVenue) {
    sportsVenueId = favoriteSportsVenue['sportsVenueId'];
  }
}
