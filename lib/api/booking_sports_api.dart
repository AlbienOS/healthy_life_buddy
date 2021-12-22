import 'package:healthy_life_buddy/api/auth_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthy_life_buddy/model/booking_sports_data.dart';
import 'package:healthy_life_buddy/model/booking_sports_model.dart';

// Future<void> addBooking(String sportsVenueId) async {
//   final booking = FirebaseFirestore.instance
//       .collection('users')
//       .doc(auth.currentUser!.uid)
//       .collection('booking')
//       .doc(sportsVenueId);
//   return await booking.set(
//     {
//       'sportsVenueId': sportsVenueId,
//     },
//   );
// }

Future<List<BookingSportsData>> getBookingSportsModel() async {
  final snapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(auth.currentUser!.uid)
      .collection('booking')
      .get();
  List<BookingSportsData> _bookingSportsModelList = [];
  _bookingSportsModelList =
      snapshot.docs.map((data) => BookingSportsData.fromObject(data)).toList();
  return _bookingSportsModelList;
}

// Future<BookingSportsData> getBookingSportsByData(String sportsVenueId) async {
//   final snapshot = await FirebaseFirestore.instance
//       .collection('sports_venues')
//       .doc(sportsVenueId)
//       .get();
//   BookingSportsData _sportsData;
//   _sportsData = BookingSportsData.fromObject(snapshot);
//   return _sportsData;
// }

// Future<bool> getBookingStatus(String sportsVenueId) async{
//   final snapshot = await FirebaseFirestore.instance
//       .collection('users')
//       .doc(auth.currentUser!.uid)
//       .collection('booking')
//       .doc(sportsVenueId)
//       .get();
//
//   return snapshot.exists;
// }
