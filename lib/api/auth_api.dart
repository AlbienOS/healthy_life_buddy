import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:healthy_life_buddy/model/user_model.dart';

FirebaseAuth auth = FirebaseAuth.instance;

Future<User?> login(String email, String password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return userCredential.user;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      return null;
    } else if (e.code == 'wrong-password') {
      return null;
    }
  } catch (e) {
    return null;
  }
}

Future<User?> registration(String email, String password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return userCredential.user;
  } catch (e) {
    rethrow;
  }
}

Future<String> userDataRegistration(String name, int age, String gender,
    String address, String phoneNumber) async {
  final users = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid);
  await users.set(
    {
      'name': name,
      'age': age,
      'gender': gender,
      'address': address,
      'phoneNumber': phoneNumber
    },
  );
  return "success";
}

Future<UserData?> getUserData(String userId) async {
  try {
    final userData =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    return UserData.fromObject(userData);
  } catch (e) {
    return null;
  }
}

Future<User?> logout() async {
  await FirebaseAuth.instance.signOut();
}
