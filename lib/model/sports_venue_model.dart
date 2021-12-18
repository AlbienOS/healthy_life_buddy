import 'package:cloud_firestore/cloud_firestore.dart';

class SportsVeneu {
  late String id;
  late String name;
  late String imageUrl;
  late String location;
  late int rentalCosts;
  late int downPayment;
  late double rate;

  SportsVeneu({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.location,
    required this.rentalCosts,
    required this.downPayment,
    required this.rate,
});

  SportsVeneu.fromObject(QueryDocumentSnapshot<Map<String, dynamic>> data) {
    id = data.id;
    name = data['name'];
    imageUrl = data['imageUrl'];
    location = data['location'];
    rentalCosts = data['rentalCosts'];
    downPayment = data['downPayment'];
    rate = data['rate'].toDouble();
  }

  factory SportsVeneu.fromMap(Map<String, dynamic> json) => SportsVeneu(
    id : json["id"],
    name : json["name"],
    imageUrl : json["imageUrl"],
    location : json["location"],
    rentalCosts : json["rentalCosts"],
    downPayment : json["downPayment"],
    rate : json["rate"],
  );

  
  Map<String, dynamic> toMap()=> {
    "id" : id,
    "name" : name,
    "imageUrl" : imageUrl,
    "location" : location,
    "rentalCosts" : rentalCosts,
    "downPayment" : downPayment,
    "rate" : rate,
  };
}
