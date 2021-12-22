import 'package:flutter/material.dart';
import 'package:healthy_life_buddy/common/state.dart';
import 'package:healthy_life_buddy/provider/booking_provider.dart';
import 'package:healthy_life_buddy/widget/error_state_message.dart';
import 'package:healthy_life_buddy/widget/headline_widget.dart';
import 'package:healthy_life_buddy/widget/no_data_state_message.dart';
import 'package:healthy_life_buddy/widget/user_profile_widget.dart';
import 'package:provider/provider.dart';

class BookingAndMembershipPage extends StatelessWidget {
  const BookingAndMembershipPage({Key? key}) : super(key: key);

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
              Headline(text: 'Pesanan Tempat Kamu'),
              Expanded(child: ListOfBookingSportsVenues()),
            ],
          ),
        ),
      ),
    );
  }
}

class ListOfBookingSportsVenues extends StatelessWidget {
  const ListOfBookingSportsVenues({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<BookingSportsVenueProvider>(
      builder: (context, snapshot, _) {
        final bookingSportVenues = snapshot.bookingSportsData;
        var currentState = snapshot.state;
        if (currentState == CurrentState.isLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (currentState == CurrentState.hasData) {
          return ListView.builder(
              itemCount: bookingSportVenues.length,
              itemBuilder: (context, i) {
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.location_pin),
                            Text(bookingSportVenues[i].sportsVenueName),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.calendar_today),
                            Text(bookingSportVenues[i].date),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.timer),
                            Text(bookingSportVenues[i].time),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.attach_money),
                            Text(bookingSportVenues[i].paymentStatus),
                            Text("${bookingSportVenues[i].payment}"),
                          ],
                        ),
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
      },
    );
  }
}
