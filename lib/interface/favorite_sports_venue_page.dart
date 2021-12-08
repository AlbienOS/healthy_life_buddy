import 'package:flutter/material.dart';
import 'package:healthy_life_buddy/common/color_style.dart';
import 'package:healthy_life_buddy/common/text_style.dart';
import 'package:healthy_life_buddy/model/user_model.dart';
import 'package:healthy_life_buddy/provider/favorite_sports_venue_provider.dart';
import 'package:healthy_life_buddy/provider/sports_venue_provider.dart';
import 'package:provider/provider.dart';

import 'detail_sports_venue_page.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FavoriteSportsVeneuProvider>(
      create: (context) => FavoriteSportsVeneuProvider(userId: 'users-1'),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const UserProfile(),
              Consumer<FavoriteSportsVeneuProvider>(
                builder: (context, snapshot, _) {
                  if (snapshot.state == 1) {
                    final favoriteSportsVenueData =
                        snapshot.favoriteSportsVenue;
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
                                          sportsVenueId:
                                              favoriteSportsVenueData[i].id,
                                        );
                                      },
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            child: Image.network(
                                              favoriteSportsVenueData[i]
                                                  .imageUrl,
                                              fit: BoxFit.cover,
                                              width: 100,
                                              height: 100,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 8.0,
                                                  vertical: 8.0,
                                                ),
                                                child: Text(
                                                  favoriteSportsVenueData[i]
                                                      .name,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: textTheme.headline6
                                                      ?.apply(
                                                    color: onSurfaceColor,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 8.0,
                                                ),
                                                child: Text(
                                                  "Rp. ${favoriteSportsVenueData[i].rentalCosts}",
                                                  style: textTheme.subtitle1
                                                      ?.apply(
                                                    color: onSurfaceColor,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 8.0,
                                                ),
                                                child: Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.star_rate,
                                                      color: primaryColor,
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        horizontal: 8.0,
                                                      ),
                                                      child: Text(
                                                        favoriteSportsVenueData[
                                                                i]
                                                            .rate
                                                            .toString(),
                                                        style: textTheme
                                                            .subtitle1
                                                            ?.apply(
                                                          color: onSurfaceColor,
                                                        ),
                                                      ),
                                                    ),
                                                    const Icon(
                                                      Icons.location_pin,
                                                      color: primaryColor,
                                                    ),
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 8.0,
                                                        ),
                                                        child: Text(
                                                          favoriteSportsVenueData[
                                                                  i]
                                                              .location,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: textTheme
                                                              .subtitle1
                                                              ?.apply(
                                                            color:
                                                                onSurfaceColor,
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
                            }));
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserProfile extends StatelessWidget {
  const UserProfile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.network(
              'https://images.unsplash.com/photo-1519052537078-e6302a4968d4?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80',
              width: 45,
              height: 45,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              "Hello, Jimmy",
              style: textTheme.headline6?.apply(color: onBackgroundColor),
            ),
          ),
        ],
      ),
    );
  }
}
