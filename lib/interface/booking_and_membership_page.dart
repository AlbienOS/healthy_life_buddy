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
  static const routeName = '/BookingMember';
  const BookingAndMembershipPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BookingSportsVenueProvider>(
          create: (context) => BookingSportsVenueProvider(),
        ),
        ChangeNotifierProvider<MembershipProvider>(
          create: (context) => MembershipProvider(),
        ),
      ],
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
                    tabs: [
                      Tab(
                        child: Text(
                          "Booking",
                          style: textTheme.subtitle1?.apply(
                              color:
                                  Theme.of(context).colorScheme.onBackground),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Member",
                          style: textTheme.subtitle1?.apply(
                              color:
                                  Theme.of(context).colorScheme.onBackground),
                        ),
                      ),
                    ],
                    indicatorColor: Theme.of(context).colorScheme.primary,
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.0),
                              child: Headline(text: 'Daftar Pemesanan Anda'),
                            ),
                            Expanded(child: ListOfBookingSportsVenues()),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.0),
                              child: Headline(text: 'Daftar Member Anda'),
                            ),
                            Expanded(child: ListOfMembershipSportsVenues()),
                          ],
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
          return const NoDataStateMessage();
        } else if (currentState == CurrentState.isError) {
          return const ErrorStateMessage();
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
            overflow: TextOverflow.ellipsis,
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
        return const Center(child: CircularProgressIndicator());
      } else if (currentState == CurrentState.hasData) {
        return ListView.builder(
            itemCount: membershipSportVenues.length,
            itemBuilder: (context, i) {
              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_pin,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  membershipSportVenues[i].place,
                                  overflow: TextOverflow.ellipsis,
                                  style: textTheme.bodyText1?.apply(
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                membershipSportVenues[i].startDate,
                                overflow: TextOverflow.ellipsis,
                                style: textTheme.bodyText1?.apply(
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                            ),
                            Text(
                              "-",
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.bodyText1?.apply(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                membershipSportVenues[i].endDate,
                                overflow: TextOverflow.ellipsis,
                                style: textTheme.bodyText1?.apply(
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
      } else if (currentState == CurrentState.noData) {
        return const NoDataStateMessage();
      } else if (currentState == CurrentState.isError) {
        return const ErrorStateMessage();
      } else {
        return Container();
      }
    });
  }
}
