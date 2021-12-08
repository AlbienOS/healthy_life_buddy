import 'package:flutter/cupertino.dart';
import 'package:healthy_life_buddy/api/auth_api.dart';
import 'package:healthy_life_buddy/model/user_model.dart';

class AuthProvider with ChangeNotifier {
  AuthProvider() {
    fetchUserData();
  }

  late int _state;
  late UserData? _userData;

  UserData? get userData => _userData;
  int get state => _state;

  fetchUserData() async {
    _state = 0;
    notifyListeners();
    _userData = await getUserData(auth.currentUser!.uid);
    notifyListeners();
  }
}
