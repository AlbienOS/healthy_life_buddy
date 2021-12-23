import 'package:flutter/material.dart';
import 'package:healthy_life_buddy/common/state.dart';
import 'package:healthy_life_buddy/common/text_style.dart';
import 'package:healthy_life_buddy/model/booking_data_model.dart';
import 'package:healthy_life_buddy/provider/booking_provider.dart';
import 'package:healthy_life_buddy/provider/member_provider.dart';
import 'package:healthy_life_buddy/widget/error_state_message.dart';
import 'package:healthy_life_buddy/widget/headline_widget.dart';
import 'package:healthy_life_buddy/widget/no_data_state_message.dart';
import 'package:healthy_life_buddy/widget/user_profile_widget.dart';
import 'package:provider/provider.dart';

class BookingAndMembershipPage extends StatelessWidget {
  const BookingAndMembershipPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BookingSportsVenueProvider>(
      create: (context) => BookingSportsVenueProvider(),
      child: Scaffold(
        body: DefaultTabController(
          length: 2,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  const UserProfile(),
                  TabBar(
                    tabs: const [
                      Tab(
                        text: "Booking",
                      ),
                      Tab(
                        text: "Member",
                      ),
                    ],
                    indicatorColor: Theme.of(context).colorScheme.primary,
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                child: Headline(text: 'Daftar Pemesanan Anda'),
                              ),
                              Expanded(child: ListOfBookingSportsVenues()),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                child: Headline(text: 'Daftar Member Anda'),
                              ),
                              Expanded(child: ListOfBookingSportsVenues()),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
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
          return const Center(child: CircularProgressIndicator());
        } else if (currentState == CurrentState.hasData) {
          return ListView.builder(
              itemCount: bookingSportVenues.length,
              itemBuilder: (context, i) {
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: scheduleTextWithIcon(
                                  context,
                                  bookingSportVenues,
                                  i,
                                  Icons.location_pin,
                                  bookingSportVenues[i].sportsVenueName,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: scheduleTextWithIcon(
                                  context,
                                  bookingSportVenues,
                                  i,
                                  Icons.calendar_today,
                                  bookingSportVenues[i].date,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: scheduleTextWithIcon(
                                  context,
                                  bookingSportVenues,
                                  i,
                                  Icons.attach_money,
                                  bookingSportVenues[i].paymentStatus,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: scheduleTextWithIcon(
                                  context,
                                  bookingSportVenues,
                                  i,
                                  Icons.timer,
                                  bookingSportVenues[i].time,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
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

  Row scheduleTextWithIcon(
      BuildContext context,
      List<BookingData> bookingSportVenues,
      int i,
      IconData iconName,
      String content) {
    return Row(
      children: [
        Icon(
          iconName,
          color: Theme.of(context).colorScheme.primary,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0),
          child: Text(
            content,
            style: textTheme.bodyText1
                ?.apply(color: Theme.of(context).colorScheme.onSurface),
          ),
        ),
      ],
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
