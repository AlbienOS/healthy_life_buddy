import 'package:flutter/material.dart';
import 'package:healthy_life_buddy/api/sports_venue_api.dart';
import 'package:healthy_life_buddy/common/state.dart';
import 'package:healthy_life_buddy/model/sports_venue_model.dart';

class SportsVenueProvider with ChangeNotifier {
  SportsVenueProvider() {
    fetchSportsVenueList();
  }

  late CurrentState _state;
  List<SportsVeneu> _sportVenueList = [];

  List<SportsVeneu> get sportsVenue => _sportVenueList;
  CurrentState get state => _state;

  fetchSportsVenueList() async {
    _state = CurrentState.isLoading;
    notifyListeners();
    try {
      final sportsVenueList = await getSportsVenue();
      if (sportsVenueList.isNotEmpty) {
        _state = CurrentState.hasData;
        _sportVenueList = sportsVenueList;
        notifyListeners();
      } else if (sportsVenueList.isEmpty) {
        _state = CurrentState.noData;
        notifyListeners();
      }
    } catch (e) {
      _state = CurrentState.isError;
      notifyListeners();
    }
  }
}
