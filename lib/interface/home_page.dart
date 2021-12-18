import 'package:flutter/material.dart';
import 'package:healthy_life_buddy/common/state.dart';
import 'package:healthy_life_buddy/common/text_style.dart';
import 'package:healthy_life_buddy/interface/detail_sports_venue_page.dart';
import 'package:healthy_life_buddy/provider/sports_venue_provider.dart';
import 'package:healthy_life_buddy/widget/error_state_message.dart';
import 'package:healthy_life_buddy/widget/headline_widget.dart';
import 'package:healthy_life_buddy/widget/no_data_state_message.dart';
import 'package:healthy_life_buddy/widget/user_profile_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/HomePage';
  const HomePage({Key? key}) : super(key: key);

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
              Headline(text: "Discover"),
              Expanded(
                flex: 3,
                child: ListOfSportsVenues(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ListOfSportsVenues extends StatelessWidget {
  const ListOfSportsVenues({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SportsVenueProvider(),
      child: Consumer<SportsVenueProvider>(
        builder: (context, snapshot, _) {
          final sportsVenueData = snapshot.sportsVenue;
          var currentState = snapshot.state;
          if (currentState == CurrentState.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (currentState == CurrentState.hasData) {
            return ListView.builder(
              itemCount: sportsVenueData.length,
              itemBuilder: (context, i) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return DetailSportsVenuePage(
                            sportsVenueId: sportsVenueData[i].id,
                          );
                        },
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Image.network(
                                sportsVenueData[i].imageUrl,
                                fit: BoxFit.cover,
                                width: 100,
                                height: 100,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                    vertical: 8.0,
                                  ),
                                  child: Text(
                                    sportsVenueData[i].name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: textTheme.headline6?.apply(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                  ),
                                  child: Text(
                                    "Rp. ${sportsVenueData[i].rentalCosts}",
                                    style: textTheme.subtitle1?.apply(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8.0,
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.star_rate,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0,
                                        ),
                                        child: Text(
                                          sportsVenueData[i].rate.toString(),
                                          style: textTheme.subtitle1?.apply(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface,
                                          ),
                                        ),
                                      ),
                                      Icon(
                                        Icons.location_pin,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0,
                                          ),
                                          child: Text(
                                            sportsVenueData[i].location,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: textTheme.subtitle1?.apply(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSurface,
                                            ),
                                          ),
                                        ),
                                      ),
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
                );
              },
            );
          } else if (currentState == CurrentState.noData) {
            return const Expanded(
              child: NoDataStateMessage(),
            );
          } else {
            return const Expanded(
              child: ErrorStateMessage(),
            );
          }
        },
      ),
    );
  }
}
