import 'package:flutter/material.dart';
import 'package:healthy_life_buddy/common/state.dart';
import 'package:healthy_life_buddy/common/text_style.dart';
import 'package:healthy_life_buddy/provider/favorite_sports_venue_provider.dart';
import 'package:healthy_life_buddy/widget/error_state_message.dart';
import 'package:healthy_life_buddy/widget/headline_widget.dart';
import 'package:healthy_life_buddy/widget/no_data_state_message.dart';
import 'package:healthy_life_buddy/widget/user_profile_widget.dart';
import 'package:provider/provider.dart';
import 'detail_sports_venue_page.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

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
              Headline(text: "Tempat Olahraga Favoritmu"),
              ListOfFavoriteSportsVenues(),
            ],
          ),
        ),
      ),
    );
  }
}

class ListOfFavoriteSportsVenues extends StatelessWidget {
  const ListOfFavoriteSportsVenues({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteSportsVeneuProvider>(
      builder: (context, snapshot, _) {
        final favoriteSportsVenueData = snapshot.favoriteSportsVenue;
        var currentState = snapshot.state;
        if (currentState == CurrentState.isLoading) {
          return const Expanded(
              child: Center(child: CircularProgressIndicator()));
        } else if (currentState == CurrentState.hasData) {
          return Expanded(
            flex: 3,
            child: ListView.builder(
              itemCount: favoriteSportsVenueData.length,
              itemBuilder: (context, i) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return DetailSportsVenuePage(
                            sportsVenueId: favoriteSportsVenueData[i].id,
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
                                favoriteSportsVenueData[i].imageUrl,
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
                                    favoriteSportsVenueData[i].name,
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
                                    "Rp. ${favoriteSportsVenueData[i].rentalCosts}",
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
                                          favoriteSportsVenueData[i]
                                              .rate
                                              .toString(),
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
                                            favoriteSportsVenueData[i].location,
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
            ),
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
    );
  }
}
