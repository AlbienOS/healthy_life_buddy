import 'package:cloud_firestore/cloud_firestore.dart';

class BookingSportsData{
  late String id;
  late String name;
  late String address;
  late String telephone;
  late String date;
  late String time;
  late int rentalCosts;
  late int downPayment;

  BookingSportsData.fromObject(DocumentSnapshot<Map<String, dynamic>> data){
    id = data.id;
    name = data['name'];
    address = data['address'];
    telephone = data['telephone'];
    date = data['date'];
    time = data['time'];
    rentalCosts = data['rentalCosts'];
    downPayment = data['downPayment'];
  }

}