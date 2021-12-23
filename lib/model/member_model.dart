

import 'package:cloud_firestore/cloud_firestore.dart';

class Membership{
  late String id;
  late String place;
  late String startDate;
  late String endDate;
  late int payment;

  Membership.fromObject(DocumentSnapshot<Map<String, dynamic>> data){
    id = data.id;
    startDate = data['startDate'];
    endDate = data['endDate'];
    payment = data['payment'];
  }
}