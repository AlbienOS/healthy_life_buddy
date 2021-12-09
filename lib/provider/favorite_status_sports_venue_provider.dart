import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:healthy_life_buddy/api/favorite_sports_venue_api.dart';
import 'package:healthy_life_buddy/common/state.dart';

class FavoriteStatusSportsVenueProvider with ChangeNotifier {
  String sportsVenueId;

  FavoriteStatusSportsVenueProvider({required this.sportsVenueId}) {
    getFavoriteCurrentStatus();
  }

  late IconData _iconState;
  IconData get iconState => _iconState;

  late CurrentState _state;
  CurrentState get state => _state;

  getFavoriteCurrentStatus() async {
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

  setFavoriteSportsVenueStatus() async {
    _state = CurrentState.isLoading;
    notifyListeners();
    try {
      final favoriteStatus = await getFavoriteStatus(sportsVenueId);
      if (favoriteStatus == true) {
        deleteFavorite(sportsVenueId);
      } else {
        addFavorite(sportsVenueId);
      }
      getFavoriteCurrentStatus();
      _state = CurrentState.isSuccsess;
      notifyListeners();
    } catch (e) {
      _state = CurrentState.isError;
      print(e.toString());
      notifyListeners();
    }
  }
}

class _state {}
