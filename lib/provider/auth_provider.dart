import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:healthy_life_buddy/api/auth_api.dart';
import 'package:healthy_life_buddy/common/state.dart';
import 'package:healthy_life_buddy/model/user_model.dart';

class AuthProvider with ChangeNotifier {
  AuthProvider() {
    fetchUserData();
  }

  late CurrentState _state;
  UserData? _userData;

  UserData? get userData => _userData;
  CurrentState get state => _state;

  fetchUserData() async {
    _state = CurrentState.isLoading;
    notifyListeners();
    try {
      _userData = await getUserData(auth.currentUser!.uid);
      if (_userData != null) {
        _state = CurrentState.isSuccsess;
        notifyListeners();
      }
    } catch (e) {
      _state = CurrentState.isError;
      notifyListeners();
    }
  }

  Future<User?> loginUser(String email, String password) async {
    final result = await login(email, password);
    fetchUserData();
    return result;
  }

  Future<String> registrationUser(String name, int age, String gender,
      String address, String phoneNumber) async {
    final result = await userDataRegistration(
      name,
      age,
      gender,
      address,
      phoneNumber,
    );
    fetchUserData();
    return result;
  }
}
