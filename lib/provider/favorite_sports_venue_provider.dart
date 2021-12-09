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

  late IconData _iconState;
  late CurrentState _state;
  List<FavoriteSportsVenueData> _favoriteSportsVenueList = [];

  IconData get iconState => _iconState;
  CurrentState get state => _state;
  List<FavoriteSportsVenueData> get favoriteSportsVenue =>
      _favoriteSportsVenueList;

  fetchFavoriteSportsVenueList() async {
    _state = CurrentState.isLoading;
    notifyListeners();
    try {
      final favoriteSportsVenueList =
          await getFavoriteSportsVenueId(auth.currentUser!.uid);
      if (favoriteSportsVenueList.isNotEmpty) {
        _state = CurrentState.hasData;
        _favoriteSportsVenueList = [];
        for (var element in favoriteSportsVenueList) {
          final data = await getFavoriteSportsVenueData(element.sportsVenueId);
          _favoriteSportsVenueList.add(data);
        }
        notifyListeners();
      } else if (favoriteSportsVenueList.isEmpty) {
        _state = CurrentState.noData;
        notifyListeners();
      }
    } catch (e) {
      _state = CurrentState.isError;
      print(e.toString());
      notifyListeners();
    }
  }

  getFavoriteCurrentStatus(String sportsVenueId) async {
    _state = CurrentState.isLoading;
    notifyListeners();
    try {
      final favoriteStatus = await getFavoriteStatus(sportsVenueId);
      if (favoriteStatus == true) {
        _iconState = Icons.favorite;
      } else {
        _iconState = Icons.favorite_border_outlined;
      }
      _state = CurrentState.isSuccsess;
      notifyListeners();
    } catch (e) {
      _state = CurrentState.isError;
      print(e.toString());
    }
  }

  setFavoriteSportsVenueStatus(String sportsVenueId) async {
    _state = CurrentState.isLoading;
    notifyListeners();
    try {
      final favoriteStatus = await getFavoriteStatus(sportsVenueId);
      if (favoriteStatus == true) {
        deleteFavorite(sportsVenueId);
      } else {
        addFavorite(sportsVenueId);
      }
      getFavoriteCurrentStatus(sportsVenueId);
      _state = CurrentState.isSuccsess;
      fetchFavoriteSportsVenueList();
      notifyListeners();
    } catch (e) {
      _state = CurrentState.isError;
      print(e.toString());
      notifyListeners();
    }
  }
}
