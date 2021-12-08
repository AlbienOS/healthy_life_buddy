import 'package:flutter/cupertino.dart';
import 'package:healthy_life_buddy/api/auth_api.dart';
import 'package:healthy_life_buddy/common/state.dart';
import 'package:healthy_life_buddy/common/state.dart';
import 'package:healthy_life_buddy/model/user_model.dart';

class AuthProvider with ChangeNotifier {
  AuthProvider() {
    fetchUserData();
  }

  late CurrentState _state;
  late UserData? _userData;

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
}
