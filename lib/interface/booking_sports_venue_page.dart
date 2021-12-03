import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthy_life_buddy/common/color_style.dart';
import 'package:healthy_life_buddy/model/sports_venue_model.dart';
import 'package:healthy_life_buddy/widget/date_picker_widget.dart';
import 'package:healthy_life_buddy/widget/time_picker.dart';

class BookingSportsRevenuePage extends StatefulWidget {
  static const routeName = '/BookingSportsRevnuePage';
  const BookingSportsRevenuePage({Key? key, required this.sportsVenueData})
      : super(key: key);

  final SportsVeneu sportsVenueData;

  @override
  State<BookingSportsRevenuePage> createState() =>
      _BookingSportsRevenuePageState();
}

class _BookingSportsRevenuePageState extends State<BookingSportsRevenuePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey,
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'PESAN TEMPAT OLAHRAGA',
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Container(
                          width: 350,
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 8.0),
                              hintText: "Nama",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Container(
                          width: 350,
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 8.0),
                              hintText: "Alamat",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Container(
                          width: 350,
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 8.0),
                              hintText: "No. Telepon",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  DatePicker(),
                  TimePicker(),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 80,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'HARGA',
                  style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                Text(
                  'RP. dummyPrice',
                  style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    InkWell(
                      child: Container(
                        height: 50,
                        width: 400,
                        decoration: BoxDecoration(
                          color: primaryVariantColor,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Center(
                          child: Text(
                            'BAYAR',
                            style: GoogleFonts.montserrat(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      onTap: () {},
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
