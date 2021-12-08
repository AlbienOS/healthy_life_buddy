import 'package:cloud_firestore/cloud_firestore.dart';

class SportsVeneu {
  late String id;
  late String name;
  late String imageUrl;
  late String location;
  late int rentalCosts;
  late double rate;

  SportsVeneu.fromObject(QueryDocumentSnapshot<Map<String, dynamic>> data) {
    id = data.id;
    name = data['name'];
    imageUrl = data['imageUrl'];
    location = data['location'];
    rentalCosts = data['rentalCosts'];
    rate = data['rate'].toDouble();
  }
}
