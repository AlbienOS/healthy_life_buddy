import 'package:flutter/cupertino.dart';
import 'package:healthy_life_buddy/api/member_sport_api.dart';
import 'package:healthy_life_buddy/common/state.dart';
import 'package:healthy_life_buddy/model/member_model.dart';

class MembershipProvider with ChangeNotifier{
  MembershipProvider(){
    fetchMembership();
  }

  late CurrentState _state;
  List<Membership> _membershipList = [];

  CurrentState get state => _state;
  List<Membership> get membershipData => _membershipList;

  fetchMembership() async{
    _state = CurrentState.isLoading;
    notifyListeners();
    try{
      final membershipDataList = await getMembership();
      if(membershipDataList.isNotEmpty){
        _state = CurrentState.hasData;
        _membershipList = membershipDataList;
        notifyListeners();
      } else if(membershipDataList.isEmpty){
        _state = CurrentState.noData;
        notifyListeners();
      }
    } catch(e){
      _state = CurrentState.isError;
      notifyListeners();
    }
  }
}