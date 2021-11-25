import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthy_buddy/model/sport_venues_data.dart';
import 'package:healthy_buddy/ui/detail_page.dart';

class SportsListPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemBuilder: (context, i){
            final SportsVenuesData sports = sportsVenueList[i];
            return InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return DetailPage();
                }));
              },
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(sports.imageAsset),
                    SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Text(
                        sports.name,
                      style: GoogleFonts.montserrat(
                        fontSize: 16, fontWeight: FontWeight.bold,),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Text(
                        sports.price,
                        style: GoogleFonts.montserrat(
                          fontSize: 16,),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.add_location),
                              Text(
                                sports.location,
                                style: GoogleFonts.montserrat(fontSize: 16),
                              ),
                              SizedBox(width: 16),
                              Icon(
                                Icons.star_rounded,
                              ),
                              Text(
                                '${sports.rate}',
                                style: GoogleFonts.montserrat(fontSize: 16),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(Icons.favorite_outline_rounded),
                              SizedBox(width: 20)
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        itemCount: sportsVenueList.length,
      ),
    );
  }
}