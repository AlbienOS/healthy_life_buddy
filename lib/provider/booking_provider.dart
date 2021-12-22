import 'package:flutter/cupertino.dart';
import 'package:healthy_life_buddy/api/booking_sports_api.dart';
import 'package:healthy_life_buddy/common/state.dart';
import 'package:healthy_life_buddy/model/booking_sports_data.dart';
import 'package:healthy_life_buddy/api/auth_api.dart';
import 'package:healthy_life_buddy/model/booking_sports_model.dart';

class BookingSportsVenueProvider with ChangeNotifier {
  BookingSportsVenueProvider() {
    fetchDataBooking();
  }

  late CurrentState _state;
  List<BookingSportsData> _bookingSportsDataList = [];

  CurrentState get state => _state;
  List<BookingSportsData> get bookingSportsData => _bookingSportsDataList;

  fetchDataBooking() async {
    _state = CurrentState.isLoading;
    notifyListeners();
    try {
      final bookingDataList = await getBookingSportsModel();
      if (bookingDataList.isNotEmpty) {
        _state = CurrentState.hasData;
        _bookingSportsDataList = bookingDataList;
        notifyListeners();
      } else if (bookingDataList.isEmpty) {
        _state = CurrentState.noData;
        notifyListeners();
      }
    } catch (e) {
      print(e);
      _state = CurrentState.isError;


      notifyListeners();
    }
  }
}
