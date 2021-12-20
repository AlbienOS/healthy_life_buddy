import 'package:healthy_life_buddy/api/auth_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthy_life_buddy/model/booking_sports_data.dart';
import 'package:healthy_life_buddy/model/booking_sports_model.dart';

Future<void> addBooking(String sportsVenueId) async {
  final booking = FirebaseFirestore.instance
      .collection('users')
      .doc(auth.currentUser!.uid)
      .collection('booking')
      .doc(sportsVenueId);
  return await booking.set(
    {
      'sportsVenueId': sportsVenueId,
    },
  );
}

Future<List<BookingSportsModel>> getBookingSportsModelById(
    String userId) async {
  final snapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .collection('booking')
      .get();
  List<BookingSportsModel> _bookingSportsModelList = [];
  _bookingSportsModelList =
      snapshot.docs.map((data) => BookingSportsModel.fromObject(data)).toList();
  return _bookingSportsModelList;
}

Future<BookingSportsData> getBookingSportsByData(String sportsVenueId) async {
  final snapshot = await FirebaseFirestore.instance
      .collection('sports_venues')
      .doc(sportsVenueId)
      .get();
  BookingSportsData _sportsData;
  _sportsData = BookingSportsData.fromObject(snapshot);
  return _sportsData;
}
