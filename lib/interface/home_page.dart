import 'package:flutter/material.dart';
import 'package:healthy_life_buddy/common/color_style.dart';
import 'package:healthy_life_buddy/common/text_style.dart';
import 'package:healthy_life_buddy/interface/detail_sports_venue_page.dart';
import 'package:healthy_life_buddy/model/sports_venue_model.dart';
import 'package:healthy_life_buddy/provider/sports_venue_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/HomePage';
  const HomePage({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const UserProfile(),
              const Headline(text: "Promo"),
              const Expanded(
                flex: 1,
                child: Promotion(),
              ),
              const Headline(text: "Discover"),
              Consumer<SportsVenueProvider>(builder: (context, snapshot, _) {
                final sportsVenueData = snapshot.sportsVenue;
                return Expanded(
                  flex: 3,
                  child: ListOfSportsVenues(sportsVenueData: sportsVenueData),
                );
              }),
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
    required this.sportsVenueData,
  }) : super(key: key);

  final List<SportsVeneu> sportsVenueData;

  @override
  Widget build(BuildContext context) {
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
                    sportsVenueData: sportsVenueData[i],
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
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: SizedBox(
                          width: 225,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, bottom: 4.0),
                                child: Text(
                                  "Nama tempat",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: textTheme.subtitle1
                                      ?.apply(color: onSurfaceColor),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(
                                  "Dummy detail promosi, deskripsi deskripsi deskripsi yang sangat panjang bangett sampe gabisa cukup di card karena saking panjangnya",
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: textTheme.caption
                                      ?.apply(color: onSurfaceColor),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: 7,
      ),
    );
  }
}
