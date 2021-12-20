import 'package:flutter/material.dart';
import 'package:healthy_life_buddy/widget/user_profile_widget.dart';

class BookingAndMembershipPage extends StatelessWidget {
  const BookingAndMembershipPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: const [
              UserProfile(),
            ],
          ),
        ),
      ),
    );
  }
}
