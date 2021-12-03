import 'package:cloud_firestore/cloud_firestore.dart';
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
