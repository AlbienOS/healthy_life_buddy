import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:healthy_life_buddy/model/user_model.dart';

FirebaseAuth auth = FirebaseAuth.instance;

Future<User?> login(String email, String password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return userCredential.user;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print("No user found for that email");
      return null;
    } else if (e.code == 'wrong-password') {
      print("Wrong password provided for that user");
      return null;
    }
  } catch (e) {
    print(
      e.toString(),
    );
    return null;
  }
}

Future<User?> registration(String email, String password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return userCredential.user;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak');
      return null;
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
      return null;
    }
  } catch (e) {
    print(e);
    return null;
  }
}

Future<void> userDataRegistration(String name, int age, String gender,
    String address, String phoneNumber) async {
  try {
    final users = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid);
    return users
        .set({
          'name': name,
          'age': age,
          'gender': gender,
          'address': address,
          'phoneNumber': phoneNumber
        })
        .then((value) => print("user data added"))
        .catchError((error) => print("failed to add user data: $error"));
  } catch (e) {
    print(e.toString());
  }
}

Future<UserData?> getUserData(String userId) async {
  try {
    final userData =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    return UserData.fromObject(userData);
  } catch (e) {
    print(e.toString());
    return null;
  }
}
