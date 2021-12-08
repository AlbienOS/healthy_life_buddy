import 'package:flutter/cupertino.dart';
import 'package:healthy_life_buddy/api/sports_venue_api.dart';
import 'package:healthy_life_buddy/model/detail_sports_venue_model.dart';
import 'package:healthy_life_buddy/model/favorite_sports_venue_data_model.dart';
import 'package:healthy_life_buddy/model/favorite_sports_venue_model.dart';
import 'package:healthy_life_buddy/model/sports_venue_model.dart';

class FavoriteSportsVeneuProvider with ChangeNotifier {
  final String userId;

  FavoriteSportsVeneuProvider({required this.userId}) {
    fetchFavoriteSportsVenueList();
  }

  List<FavoriteSportsVenueData> _favoriteSportsVenueList = [];
  late int _state;

  List<FavoriteSportsVenueData> get favoriteSportsVenue =>
      _favoriteSportsVenueList;
  int get state => _state;

  fetchFavoriteSportsVenueList() async {
    _state = 0;
    notifyListeners();
    final favoriteSportsVenueList = await getFavoriteSportsVenueId(userId);
    if (favoriteSportsVenueList.isNotEmpty) {
      _state = 1;

      for (var element in favoriteSportsVenueList) {
        final data = await getFavoriteSportsVenueData(element.sportsVenueId)
            .then((value) => _favoriteSportsVenueList.add(value));
      }
      notifyListeners();
    } else {
      _state = 2;
      notifyListeners();
    }
  }

  addFavoriteSportsVenueList() async {
    _state = 0;
    try {
      addFavorite(userId);
    } catch (e) {}
  }
}
