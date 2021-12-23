import 'package:flutter/material.dart';
import 'package:healthy_life_buddy/common/state.dart';
import 'package:healthy_life_buddy/provider/member_provider.dart';
import 'package:healthy_life_buddy/widget/error_state_message.dart';
import 'package:healthy_life_buddy/widget/headline_widget.dart';
import 'package:healthy_life_buddy/widget/no_data_state_message.dart';
import 'package:healthy_life_buddy/widget/user_profile_widget.dart';
import 'package:provider/provider.dart';

class MemberShip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              UserProfile(),
              Headline(text: 'Member Kamu'),
            ],
          ),
        ),
      ),
    );
  }
}

class ListOfMembershipSportsVenues extends StatelessWidget {
  const ListOfMembershipSportsVenues({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<MembershipProvider>(builder: (context, snapshot, _) {
      final membershipSportVenues = snapshot.membershipData;
      var currentState = snapshot.state;
      if (currentState == CurrentState.isLoading) {
        return Center(child: CircularProgressIndicator());
      } else if (currentState == CurrentState.hasData) {
        return ListView.builder(
            itemCount: membershipSportVenues.length,
            itemBuilder: (context, i) {
              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.location_pin),
                          Text(membershipSportVenues[i].place)
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.calendar_today),
                          Text(membershipSportVenues[i].endDate)
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.attach_money),
                          Text(membershipSportVenues[i].payment.toString()),
                        ],
                      )
                    ],
                  ),
                ),
              );
            });
      } else if (currentState == CurrentState.noData) {
        return NoDataStateMessage();
      } else if (currentState == CurrentState.isError) {
        return ErrorStateMessage();
      } else {
        return Container();
      }
    });
  }
}
