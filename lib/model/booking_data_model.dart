import 'package:cloud_firestore/cloud_firestore.dart';

class BookingData {
  late String id;
  late String place;
  late String time;
  late String payment;

  BookingData.fromObject(DocumentSnapshot<Map<String, dynamic>> data) {
    id = data.id;
    place = data['place'];
    time = data['time'];
    payment = data['payment'];
  }
}
