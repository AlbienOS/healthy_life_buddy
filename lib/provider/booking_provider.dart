import 'package:flutter/material.dart';
import 'package:healthy_life_buddy/api/booking_sports_api.dart';
import 'package:healthy_life_buddy/common/state.dart';
import 'package:healthy_life_buddy/model/booking_data_model.dart';

class BookingSportsVenueProvider with ChangeNotifier {
  BookingSportsVenueProvider() {
    fetchDataBooking();
  }

  late CurrentState _state;
  List<BookingData> _bookingSportsDataList = [];

  CurrentState get state => _state;
  List<BookingData> get bookingSportsData => _bookingSportsDataList;

  fetchDataBooking() async {
    _state = CurrentState.isLoading;
    notifyListeners();
    try {
      final bookingDataList = await getBookingData();
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
