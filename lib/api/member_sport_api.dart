import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:healthy_life_buddy/model/member_model.dart';

import 'auth_api.dart';

Future<List<Membership>> getMembership() async {
  final snapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(auth.currentUser!.uid)
      .collection('member')
      .get();
  List<Membership> _membership = [];
  _membership =
      snapshot.docs.map((data) => Membership.fromObject(data)).toList();
  return _membership;
}
