import 'package:cloud_firestore/cloud_firestore.dart';

class SportsVeneu {
  late String name;
  late String imageUrl;
  late String location;
  late String description;
  late String openDays;
  late String openTime;
  late int rentalCosts;
  late int downPayment;
  late String discountInfo;
  late double rate;

  SportsVeneu.fromObject(QueryDocumentSnapshot<Map<String, dynamic>> data) {
    name = data['name'];
    imageUrl = data['imageUrl'];
    location = data['location'];
    description = data['description'];
    openDays = data['openDays'];
    openTime = data['openTime'];
    rentalCosts = data['rentalCosts'];
    downPayment = data['downPayment'];
    discountInfo = data['discountInfo'];
    rate = data['rate'].toDouble();
  }
}
