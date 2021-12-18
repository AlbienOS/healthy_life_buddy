import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthy_life_buddy/model/detail_sports_venue_model.dart';
import 'package:healthy_life_buddy/model/sports_venue_model.dart';


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
