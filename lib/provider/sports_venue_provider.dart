import 'package:flutter/material.dart';
import 'package:healthy_life_buddy/api/sports_venue_api.dart';
import 'package:healthy_life_buddy/model/sports_venue_model.dart';

class SportsVenueProvider with ChangeNotifier {
  SportsVenueProvider() {
    fetchSportsVenueList();
  }

  List<SportsVeneu> _sportVenueList = [];
  late int _state;

  List<SportsVeneu> get sportsVenue => _sportVenueList;
  int get state => _state;

  fetchSportsVenueList() async {
    _state = 0;
    notifyListeners();
    final sportsVenueList = await getSportsVenue();
    if (sportsVenueList.isNotEmpty) {
      _state = 1;
      _sportVenueList = sportsVenueList;
      notifyListeners();
    } else {
      _state = 2;
      notifyListeners();
    }
  }

  refreshData() {
    fetchSportsVenueList();
  }
}
