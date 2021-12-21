import 'package:cloud_firestore/cloud_firestore.dart';

class SportsVeneu {
  late String id;
  late String name;
  late String imageUrl;
  late String location;
  late int rentalCosts;
  late int downPayment;
  late double rate;

  SportsVeneu.fromObject(QueryDocumentSnapshot<Map<String, dynamic>> data) {
    id = data.id;
    name = data['name'];
    imageUrl = data['imageUrl'];
    location = data['location'];
    rentalCosts = data['rentalCosts'];
    downPayment = data['downPayment'];
    rate = data['rate'].toDouble();
  }

  SportsVeneu.fromJson(Map<String, dynamic> map){
    id = map['id'];
    name = map['name'];
    imageUrl = map['imageUrl'];
    location = map['location'];
    rentalCosts = map['rentalCosts'];
    downPayment = map['downPayment'];
    rate = map['rate'].toDouble();
  }

  Map<String, dynamic> toJson() => {
    "id" : id,
    "name" : name,
    "imageUrl" : imageUrl,
    "location" : location,
    "rentalCosts" : rentalCosts,
    "downPayment" : downPayment,
    "rate" : rate,
  };
}
