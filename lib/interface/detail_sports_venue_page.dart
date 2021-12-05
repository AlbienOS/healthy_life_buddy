import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthy_life_buddy/common/color_style.dart';
import 'package:healthy_life_buddy/common/text_style.dart';
import 'package:healthy_life_buddy/interface/booking_sports_venue_page.dart';
import 'package:healthy_life_buddy/model/sports_venue_model.dart';

class DetailSportsVenuePage extends StatelessWidget {
  static const routeName = '/DetailSportsVenuePage';
  const DetailSportsVenuePage({Key? key, required this.sportsVenueData})
      : super(key: key);

  final SportsVeneu sportsVenueData;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const BackButton(),
                SportsVenueImage(sportsVenueData: sportsVenueData, size: size),
                Row(
                  children: const [
                    FavoriteButton(),
                    ShareButton(),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: SportsVenueDetail(sportsVenueData: sportsVenueData),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: SportsVenuePromotion(sportsVenueData: sportsVenueData),
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
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                                              sportsVenueData: sportsVenueData);
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
    required this.sportsVenueData,
  }) : super(key: key);

  final SportsVeneu sportsVenueData;

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
              sportsVenueData.discountInfo,
              style: textTheme.subtitle1?.apply(color: onSurfaceColor),
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
                      "Ambil",
                      style: textTheme.button?.apply(
                        color: onPrimaryColor,
                      ),
                    ),
                    onPressed: () {},
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
    required this.sportsVenueData,
  }) : super(key: key);

  final SportsVeneu sportsVenueData;

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
              sportsVenueData.name,
              style: textTheme.headline5?.apply(color: onBackgroundColor),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: RatingBarIndicator(
                rating: sportsVenueData.rate,
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
              sportsVenueData.description,
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
    required this.sportsVenueData,
    required this.size,
  }) : super(key: key);

  final SportsVeneu sportsVenueData;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Image.network(
          sportsVenueData.imageUrl,
          height: 400,
          width: size.width,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class BackButton extends StatelessWidget {
  const BackButton({
    Key? key,
  }) : super(key: key);

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
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: onSurfaceColor,
            ),
            onPressed: () {
              Navigator.pop(context);
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

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    Key? key,
  }) : super(key: key);

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
          child: IconButton(
            icon: const Icon(
              Icons.favorite_outline,
              color: primaryColor,
            ),
            onPressed: () {},
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

class ShareButton extends StatelessWidget {
  const ShareButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
      ),
      child: Container(
        child: SizedBox(
          width: 50,
          height: 50,
          child: IconButton(
            icon: const Icon(
              Icons.share,
              color: primaryColor,
            ),
            onPressed: () {},
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
