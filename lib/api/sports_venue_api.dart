import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthy_life_buddy/model/detail_sports_venue_model.dart';
import 'package:healthy_life_buddy/model/sports_venue_model.dart';

Future<List<SportsVeneu>> getSportsVenue() async {
  final snapshot =
      await FirebaseFirestore.instance.collection('sports_venues').get();
  List<SportsVeneu> _sportsVenueList = [];
  _sportsVenueList =
      snapshot.docs.map((data) => SportsVeneu.fromObject(data)).toList();
  return _sportsVenueList;
}

Future<List<SportsVeneu>> getSearchedSportsVeneu(String name) async {
  final snapshot =
      await FirebaseFirestore.instance.collection('sports_venues').get();
  final resultSearch = snapshot.docs.map((e) {
    if (e.data()['name'].toString().toLowerCase().contains(
          name.toLowerCase(),
        )) {
      return e;
    }
  }).toList();
  final List<SportsVeneu> listSearchedSportsVenue = [];
  for (var e in resultSearch) {
    if (e != null) {
      listSearchedSportsVenue.add(SportsVeneu.fromObject(e));
    }
  }
  return listSearchedSportsVenue;
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
