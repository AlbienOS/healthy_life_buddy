import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthy_life_buddy/common/color_style.dart';
import 'package:healthy_life_buddy/common/state.dart';
import 'package:healthy_life_buddy/common/text_style.dart';
import 'package:healthy_life_buddy/interface/booking_sports_venue_page.dart';
import 'package:healthy_life_buddy/interface/member_sports_page.dart';
import 'package:healthy_life_buddy/model/detail_sports_venue_model.dart';
import 'package:healthy_life_buddy/model/sports_venue_model.dart';
import 'package:healthy_life_buddy/provider/detail_sports_venue_provider.dart';
import 'package:healthy_life_buddy/provider/favorite_sports_venue_provider.dart';
import 'package:healthy_life_buddy/provider/favorite_status_sports_venue_provider.dart';
import 'package:healthy_life_buddy/widget/back_button.dart';
import 'package:healthy_life_buddy/widget/share_button.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class DetailSportsVenuePage extends StatelessWidget {
  static const routeName = '/DetailSportsVenuePage';
  const DetailSportsVenuePage({Key? key, required this.sportsVenueId})
      : super(key: key);

  final String sportsVenueId;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DetailSportsVeneueProvider>(
          create: (context) =>
              DetailSportsVeneueProvider(sportsVenueId: sportsVenueId),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              FavoriteStatusSportsVenueProvider(sportsVenueId: sportsVenueId),
        )
      ],
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Consumer<DetailSportsVeneueProvider>(
              builder: (BuildContext context, value, Widget? child) {
                if (value.state == 1) {
                  final sportsVenueData = value.detailSportsVenue;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        child: CustomBackButton(),
                      ),
                      SportsVenueImage(
                          imageUrl: sportsVenueData.imageUrl, size: size),
                      Row(
                        children: [
                          FavoriteButton(sportsVenueId: sportsVenueData.id),
                          ShareButton(
                            text:
                                'Ayo berolahraga bersama di ${sportsVenueData.name} yang berlokasi di ${sportsVenueData.location}',
                            subjectText:
                                "Undangan berolahraga di {$sportsVenueData.name}",
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        child: SportsVenueDetail(
                            detailSportsVenueData: sportsVenueData),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: SportsVenuePromotion(
                            detailSportsVenueData: sportsVenueData),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Costs Detail",
                                  style: textTheme.headline6?.apply(
                                    color: onSurfaceColor,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          "Rental Costs",
                                          style: textTheme.bodyText2?.apply(
                                            color: onSurfaceColor,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          ': ${sportsVenueData.rentalCosts}',
                                          style: textTheme.bodyText2?.apply(
                                            color: onSurfaceColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        "Discount",
                                        style: textTheme.bodyText2?.apply(
                                          color: onSurfaceColor,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        ': Dummy_Discount',
                                        style: textTheme.bodyText2?.apply(
                                          color: onSurfaceColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          "Total",
                                          style: textTheme.bodyText2?.apply(
                                            color: onSurfaceColor,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          ': Dummy_Total',
                                          style: textTheme.bodyText2?.apply(
                                            color: onSurfaceColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextButton(
                                        child: Text(
                                          "Pesan",
                                          style: textTheme.button?.apply(
                                            color: onPrimaryColor,
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return BookingSportsVenuePage(
                                                    sportsVenueData:
                                                        sportsVenueData);
                                              },
                                            ),
                                          );
                                        },
                                        style: TextButton.styleFrom(
                                          backgroundColor: primaryColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class SportsVenuePromotion extends StatelessWidget {
  const SportsVenuePromotion({
    Key? key,
    required this.detailSportsVenueData,
  }) : super(key: key);

  final DetailSportsVeneu detailSportsVenueData;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
            child: Center(
              child: Text(
                'BUAT MEMBER',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, right: 16.0, bottom: 16.0, top: 8),
                  child: TextButton(
                    child: Text(
                      "BUAT",
                      style: textTheme.button?.apply(
                        color: onPrimaryColor,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return MemberPage();
                      }));
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: primaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SportsVenueDetail extends StatelessWidget {
  const SportsVenueDetail({
    Key? key,
    required this.detailSportsVenueData,
  }) : super(key: key);

  final DetailSportsVeneu detailSportsVenueData;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              detailSportsVenueData.name,
              style: textTheme.headline5?.apply(color: onBackgroundColor),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: RatingBarIndicator(
                rating: detailSportsVenueData.rate,
                itemBuilder: (context, index) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                itemCount: 5,
                itemSize: 20.0,
                direction: Axis.horizontal,
              ),
            ),
            Text(
              detailSportsVenueData.description,
              style: textTheme.bodyText2?.apply(color: onBackgroundColor),
            ),
          ],
        ),
      ),
    );
  }
}

class SportsVenueImage extends StatelessWidget {
  const SportsVenueImage({
    Key? key,
    required this.imageUrl,
    required this.size,
  }) : super(key: key);

  final String imageUrl;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Image.network(
          imageUrl,
          height: 400,
          width: size.width,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    Key? key,
    required this.sportsVenueId,
  }) : super(key: key);

  final String sportsVenueId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      child: Container(
        child: SizedBox(
          width: 50,
          height: 50,
          child: Consumer<FavoriteStatusSportsVenueProvider>(
            builder: (BuildContext context, value, Widget? child) {
              if (value.state == CurrentState.isLoading) {
                return IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.favorite_border_outlined,
                    color: primaryColor,
                  ),
                );
              } else if (value.state == CurrentState.isSuccsess) {
                final iconState = value.iconState;
                return IconButton(
                  icon: Icon(
                    iconState,
                    color: primaryColor,
                  ),
                  onPressed: () async {
                    await value.setFavoriteSportsVenueStatus();
                    Provider.of<FavoriteSportsVeneuProvider>(context,
                            listen: false)
                        .fetchFavoriteSportsVenueList();
                  },
                );
              } else {
                return const Text("error");
              }
            },
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: surfaceColor,
        ),
      ),
    );
  }
}
