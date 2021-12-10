import 'package:cloud_firestore/cloud_firestore.dart';

class BookingSportsModel {
  late String sportsVenueId;

  BookingSportsModel.fromObject(
      QueryDocumentSnapshot<Map<String, dynamic>> bookingSportsVenue) {
    sportsVenueId = bookingSportsVenue['sportsVenueId'];
  }
}
