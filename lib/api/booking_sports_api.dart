import 'package:healthy_life_buddy/api/auth_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthy_life_buddy/model/booking_data_model.dart';

Future<List<BookingData>> getBookingData() async {
  final snapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(auth.currentUser!.uid)
      .collection('booking')
      .orderBy("date", descending: true)
      .get();
  List<BookingData> _bookingList = [];
  _bookingList =
      snapshot.docs.map((data) => BookingData.fromObject(data)).toList();
  return _bookingList;
}
