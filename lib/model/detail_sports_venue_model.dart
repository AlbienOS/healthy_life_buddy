import 'package:cloud_firestore/cloud_firestore.dart';

class DetailSportsVeneu {
  late String id;
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

  DetailSportsVeneu.fromObject(DocumentSnapshot<Map<String, dynamic>> data) {
    id = data.id;
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
