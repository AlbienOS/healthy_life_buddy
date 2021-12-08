import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthy_life_buddy/model/detail_sports_venue_model.dart';
import 'package:healthy_life_buddy/model/favorite_sports_venue_data_model.dart';
import 'package:healthy_life_buddy/model/favorite_sports_venue_model.dart';
import 'package:healthy_life_buddy/model/sports_venue_model.dart';
import 'package:healthy_life_buddy/model/user_model.dart';

Future<List<SportsVeneu>> getSportsVenue() async {
  final snapshot =
      await FirebaseFirestore.instance.collection('sports_venues').get();
  List<SportsVeneu> _sportsVenueList = [];
  _sportsVenueList =
      snapshot.docs.map((data) => SportsVeneu.fromObject(data)).toList();
  print('data lenght : ${_sportsVenueList.length}');
  return _sportsVenueList;
}

Future<DetailSportsVeneu> getDetailSportsVenue(String id) async {
  final snapshot = await FirebaseFirestore.instance
      .collection('sports_venues')
      .doc(id)
      .get();
  DetailSportsVeneu _sportsVenue;
  _sportsVenue = DetailSportsVeneu.fromObject(snapshot);
  return _sportsVenue;
}

Future<void> addFavorite(String sportsVenueId) {
  CollectionReference favorite_sports_venues =
      FirebaseFirestore.instance.collection('favorite_sports_venues');
  return favorite_sports_venues
      .add({
        'sportsVenueId': sportsVenueId,
      })
      .then((value) => print("favorite added"))
      .catchError((error) => print("Failed to add favorite : $error"));
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
  print('data lenght : ${_favoriteSportsVenueList.length}');
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

Future<void> deleteFavorite(String sportsVenueId) {
  CollectionReference favorite_sports_venues =
      FirebaseFirestore.instance.collection('favorite_sports_venues');
  return favorite_sports_venues
      .doc(sportsVenueId)
      .delete()
      .then((value) => print("user deleted"))
      .catchError((error) => print("Failed to delete favorite: $error"));
}
