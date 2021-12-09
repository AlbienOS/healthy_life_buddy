import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthy_life_buddy/api/auth_api.dart';
import 'package:healthy_life_buddy/api/favorite_sports_venue_api.dart';
import 'package:healthy_life_buddy/api/sports_venue_api.dart';
import 'package:healthy_life_buddy/common/state.dart';
import 'package:healthy_life_buddy/model/favorite_sports_venue_data_model.dart';

class FavoriteSportsVeneuProvider with ChangeNotifier {
  FavoriteSportsVeneuProvider() {
    fetchFavoriteSportsVenueList();
  }

  late CurrentState _state;
  List<FavoriteSportsVenueData> _favoriteSportsVenueList = [];

  CurrentState get state => _state;
  List<FavoriteSportsVenueData> get favoriteSportsVenue =>
      _favoriteSportsVenueList;

  fetchFavoriteSportsVenueList() async {
    print("loading data");
    _state = CurrentState.isLoading;
    notifyListeners();
    try {
      final favoriteSportsVenueList =
          await getFavoriteSportsVenueId(auth.currentUser!.uid);

      if (favoriteSportsVenueList.isNotEmpty) {
        print("ada data");
        _state = CurrentState.hasData;
        _favoriteSportsVenueList = [];
        for (var element in favoriteSportsVenueList) {
          final data = await getFavoriteSportsVenueData(element.sportsVenueId);
          _favoriteSportsVenueList.add(data);
        }
        notifyListeners();
      } else if (favoriteSportsVenueList.isEmpty) {
        print("ga ada data");
        _state = CurrentState.noData;
        notifyListeners();
      }
    } catch (e) {
      print("error");
      _state = CurrentState.isError;
      print(e.toString());
      notifyListeners();
    }
  }
}
