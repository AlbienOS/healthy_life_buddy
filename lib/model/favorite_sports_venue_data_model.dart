import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteSportsVenueData {
  late String id;
  late String name;
  late String imageUrl;
  late String location;
  late int rentalCosts;
  late double rate;

  FavoriteSportsVenueData.fromObject(
      DocumentSnapshot<Map<String, dynamic>> data) {
    id = data.id;
    name = data['name'];
    imageUrl = data['imageUrl'];
    location = data['location'];
    rentalCosts = data['rentalCosts'];
    rate = data['rate'].toDouble();
  }
}
