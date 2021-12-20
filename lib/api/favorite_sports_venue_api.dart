import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthy_life_buddy/api/auth_api.dart';
import 'package:healthy_life_buddy/model/favorite_sports_venue_data_model.dart';
import 'package:healthy_life_buddy/model/favorite_sports_venue_model.dart';

Future<void> addFavorite(String sportsVenueId) async {
  final favoriteSportsVenues = FirebaseFirestore.instance
      .collection('users')
      .doc(auth.currentUser!.uid)
      .collection('favorite_sports_venues')
      .doc(sportsVenueId);
  return await favoriteSportsVenues.set({
    'sportsVenueId': sportsVenueId,
  });
}

Future<List<FavoriteSportsVenue>> getFavoriteSportsVenueId(
    String userId) async {
  final snapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .collection('favorite_sports_venues')
      .get();
  List<FavoriteSportsVenue> _favoriteSportsVenueList = [];
  _favoriteSportsVenueList = snapshot.docs
      .map((data) => FavoriteSportsVenue.fromObject(data))
      .toList();
  return _favoriteSportsVenueList;
}

Future<FavoriteSportsVenueData> getFavoriteSportsVenueData(
    String sportsVenueId) async {
  final snapshot = await FirebaseFirestore.instance
      .collection('sports_venues')
      .doc(sportsVenueId)
      .get();
  FavoriteSportsVenueData _sportsVenue;
  _sportsVenue = FavoriteSportsVenueData.fromObject(snapshot);
  return _sportsVenue;
}

Future<bool> getFavoriteStatus(String sportsVenueId) async {
  final snapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(auth.currentUser!.uid)
      .collection('favorite_sports_venues')
      .doc(sportsVenueId)
      .get();

  return snapshot.exists;
}

Future<void> deleteFavorite(String sportsVenueId) async {
  CollectionReference favoriteSportsVenues = FirebaseFirestore.instance
      .collection('users')
      .doc(auth.currentUser!.uid)
      .collection('favorite_sports_venues');
  return await favoriteSportsVenues.doc(sportsVenueId).delete();
}
