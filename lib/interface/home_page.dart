import 'package:flutter/material.dart';
import 'package:healthy_life_buddy/common/color_style.dart';
import 'package:healthy_life_buddy/common/state.dart';
import 'package:healthy_life_buddy/common/text_style.dart';
import 'package:healthy_life_buddy/interface/detail_sports_venue_page.dart';
import 'package:healthy_life_buddy/provider/favorite_sports_venue_provider.dart';
import 'package:healthy_life_buddy/provider/sports_venue_provider.dart';
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
              Headline(text: "Promo"),
              Expanded(
                child: Promotion(),
              ),
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

class Headline extends StatelessWidget {
  const Headline({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0, left: 8.0),
      child: Text(
        text,
        style: textTheme.headline6?.apply(color: onBackgroundColor),
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
                  onTap: () async {
                    await Provider.of<FavoriteSportsVeneuProvider>(context,
                            listen: false)
                        .getFavoriteCurrentStatus(sportsVenueData[i].id);
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
                                      color: onSurfaceColor,
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
                                      color: onSurfaceColor,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8.0,
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.star_rate,
                                        color: primaryColor,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0,
                                        ),
                                        child: Text(
                                          sportsVenueData[i].rate.toString(),
                                          style: textTheme.subtitle1?.apply(
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
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0,
                                          ),
                                          child: Text(
                                            sportsVenueData[i].location,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: textTheme.subtitle1?.apply(
                                              color: onSurfaceColor,
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
            return Text("no data");
          } else {
            return Text("error");
          }
        },
      ),
    );
  }
}

class Promotion extends StatelessWidget {
  const Promotion({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, i) {
          return Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 250,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                          child: Row(
                            children: [
                              const Icon(Icons.attach_money,
                                  color: primaryColor),
                              Text(
                                "Promo Member Gor Mars",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: textTheme.subtitle2
                                    ?.apply(color: onSurfaceColor),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            "Promo diskon 75% untuk daftar member di GOR Mars.",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style:
                                textTheme.caption?.apply(color: onSurfaceColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: 7,
      ),
    );
  }
}
