import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthy_life_buddy/common/color_style.dart';
import 'package:healthy_life_buddy/common/text_style.dart';
import 'package:healthy_life_buddy/interface/detail_sports_venue_page.dart';
import 'package:healthy_life_buddy/model/sports_venue_model.dart';

class SearchSportsVenue extends StatefulWidget {
  const SearchSportsVenue({Key? key}) : super(key: key);

  @override
  State<SearchSportsVenue> createState() => _SearchSportsVenueState();

}

class _SearchSportsVenueState extends State<SearchSportsVenue> {
  CollectionReference _firestore = FirebaseFirestore.instance.collection("sports_venues");
  final tagList = <String>['Semua', 'Populer',];
  var selected = 0;
  String result ="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(20.0),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                height: 300,
                width: 400,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Cari Tempat Olahraga Kesukaanmu',
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      height: 60,
                      width: 400,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30.0)
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search",
                          icon: Icon(Icons.search),
                          border: InputBorder.none,
                        ),
                        onSubmitted: (value){
                          setState(() {
                            result = value;
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
              if(result.isEmpty)
                Container(
                  child: Column(
                    children: [
                        Align(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              SizedBox(height: 100.0,),
                              Icon(Icons.search, size: 100, color: primaryColor,),
                              Text('Cari Tempat Olahraga',
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                )
              else
                listSearch()
            ],
          ),
        ),
      ),
    );
  }
  Widget listSearch(){
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.snapshots().asBroadcastStream(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
        if(!snapshot.hasData){
          return LinearProgressIndicator();
        } else if(snapshot.data!.docs.where((QueryDocumentSnapshot<Object?> element) => element['name']
            .toString()
            .toLowerCase()
            .contains(result.toLowerCase())).isEmpty){
          return Center(
            child: Column(
              children: [
                SizedBox(height: 100.0,),
                Icon(Icons.error_outline,
                size: 100
                ),
                Text('Tidak bisa menemukan yang anda cari!')
              ],
            ),
          );

        }
        else{
          print(snapshot.data);
          return ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: [
              ...snapshot.data!.docs.where((QueryDocumentSnapshot<Object?> element) => element['name']
                  .toString()
                  .toLowerCase()
                  .contains(result.toLowerCase())).map((QueryDocumentSnapshot<Object?> data){

                    final String name = data.get('name');
                    final String image = data['imageUrl'];
                    final String location = data['location'];
                    final int cost = data['rentalCosts'];
                    final double rate = data['rate'];

                    return InkWell(
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
                                  image,
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
                                      name,
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
                                      "Rp. ${cost}",
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
                                            rate.toString(),
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
                                              location,
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
                      onTap: (){
                        var query = data as QueryDocumentSnapshot<Map<String, dynamic>>;
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return DetailSportsVenuePage(sportsVenueData: SportsVeneu.fromObject(query));
                        }));
                      },
                    );
              })
            ],
          );
        }
      }
    );
  }
}
