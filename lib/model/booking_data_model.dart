import 'package:cloud_firestore/cloud_firestore.dart';

class BookingData {
  late String id;
  late String sportsVenueId;
  late String sportsVenueName;
  late String date;
  late String time;
  late int payment;
  late String paymentStatus;
  late String userId;

  BookingData.fromObject(DocumentSnapshot<Map<String, dynamic>> data) {
    id = data.id;
    sportsVenueId = data['sportsVenueId'];
    sportsVenueName = data['sportsVenueName'];
    date = data['date'];
    time = data['time'];
    payment = data['payment'];
    paymentStatus = data['paymentStatus'];
    userId = data['userId'];
  }
}
