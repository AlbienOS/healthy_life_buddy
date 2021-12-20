import 'package:flutter/material.dart';
import 'package:healthy_life_buddy/api/sports_venue_api.dart';
import 'package:healthy_life_buddy/common/state.dart';
import 'package:healthy_life_buddy/model/sports_venue_model.dart';

class SportsVenueProvider with ChangeNotifier {
  SportsVenueProvider() {
    fetchSportsVenueList();
  }

  late CurrentState _state;
  bool _searchState = false;
  List<SportsVeneu> _sportVenueList = [];

  CurrentState get state => _state;
  bool get searhState => _searchState;
  List<SportsVeneu> get sportsVenue => _sportVenueList;

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

  searchSportsVenueData(String name) async {
    _searchState = true;
    _state = CurrentState.isLoading;
    notifyListeners();
    try {
      final sportsVenueList = await getSearchedSportsVeneu(name);
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
