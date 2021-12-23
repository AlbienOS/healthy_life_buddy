import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:healthy_life_buddy/common/state.dart';
import 'package:healthy_life_buddy/common/text_style.dart';
import 'package:healthy_life_buddy/interface/booking_sports_venue_page.dart';
import 'package:healthy_life_buddy/interface/member_sports_page.dart';
import 'package:healthy_life_buddy/model/detail_sports_venue_model.dart';
import 'package:healthy_life_buddy/provider/detail_sports_venue_provider.dart';
import 'package:healthy_life_buddy/provider/favorite_sports_venue_provider.dart';
import 'package:healthy_life_buddy/provider/favorite_status_sports_venue_provider.dart';
import 'package:healthy_life_buddy/widget/back_button.dart';
import 'package:healthy_life_buddy/widget/share_button.dart';
import 'package:provider/provider.dart';

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
                        child: SportsVenueMembership(
                            detailSportsVenueData: sportsVenueData),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: SportsVenueBooking(
                            sportsVenueData: sportsVenueData),
                      ),
                    ],
                  );
                } else {
                  return SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: const Center(child: CircularProgressIndicator()));
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class SportsVenueBooking extends StatelessWidget {
  const SportsVenueBooking({
    Key? key,
    required this.sportsVenueData,
  }) : super(key: key);

  final DetailSportsVeneu sportsVenueData;

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
              "Booking",
              style: textTheme.headline6
                  ?.apply(color: Theme.of(context).colorScheme.onSurface),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Pesan",
                          style: textTheme.button?.apply(
                              color: Theme.of(context).colorScheme.onPrimary),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return BookingSportsVenuePage(
                                  sportsVenueData: sportsVenueData);
                            },
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SportsVenueMembership extends StatelessWidget {
  const SportsVenueMembership({
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
            child: Text(
              'Membership',
              style: textTheme.headline6
                  ?.apply(color: Theme.of(context).colorScheme.onSurface),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextButton(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Buat",
                        style: textTheme.button?.apply(
                            color: Theme.of(context).colorScheme.onPrimary),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return MemberPage(
                            sportsVenueData: detailSportsVenueData);
                      }));
                    },
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      backgroundColor: Theme.of(context).colorScheme.primary,
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
              style: textTheme.headline5
                  ?.apply(color: Theme.of(context).colorScheme.onSurface),
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
              style: textTheme.bodyText2
                  ?.apply(color: Theme.of(context).colorScheme.onSurface),
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
        width: 50,
        height: 50,
        child: Consumer<FavoriteStatusSportsVenueProvider>(
          builder: (BuildContext context, value, Widget? child) {
            if (value.state == CurrentState.isLoading) {
              return IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.favorite_border_outlined,
                  color: Theme.of(context).colorScheme.primary,
                ),
              );
            } else if (value.state == CurrentState.isSuccsess) {
              final iconState = value.iconState;
              return IconButton(
                icon: Icon(
                  iconState,
                  color: Theme.of(context).colorScheme.primary,
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
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Theme.of(context).colorScheme.surface,
        ),
      ),
    );
  }
}
