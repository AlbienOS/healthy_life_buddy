import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthy_life_buddy/model/favorite_sports_venue_model.dart';

class UserData {
  late String id;
  late String name;
  late int age;
  late String gender;
  late String address;
  late String phoneNumber;
  late List<FavoriteSportsVenue> favoriteSportsVenue;

  UserData.fromObject(DocumentSnapshot<Map<String, dynamic>> userData) {
    id = userData.id;
    name = userData['name'];
    age = userData['age'];
    gender = userData['gender'];
    address = userData['address'];
    phoneNumber = userData['phoneNumber'];
  }
}
