import 'package:flutter/cupertino.dart';
import 'package:healthy_life_buddy/api/sports_venue_api.dart';
import 'package:healthy_life_buddy/model/detail_sports_venue_model.dart';

class DetailSportsVeneueProvider with ChangeNotifier {
  final String sportsVenueId;

  DetailSportsVeneueProvider({required this.sportsVenueId}) {
    fetchDetailSportsVenue();
  }

  late DetailSportsVeneu _detailSportsVenue;
  late int _state;

  DetailSportsVeneu get detailSportsVenue => _detailSportsVenue;
  int get state => _state;

  fetchDetailSportsVenue() async {
    _state = 0;
    notifyListeners();
    final detailSportsVenue = await getDetailSportsVenue(sportsVenueId);
    try {
      _state = 1;
      _detailSportsVenue = detailSportsVenue;
      notifyListeners();
    } catch (e) {
      notifyListeners();
    }
  }
}
