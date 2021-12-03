import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthy_buddy/common/colors_style.dart';
import 'package:healthy_buddy/model/sport_venues_data.dart';
import 'package:healthy_buddy/widget/date_picker_widget.dart';
import 'package:healthy_buddy/widget/time_picker_widget.dart';

class BookingPage extends StatefulWidget {
  static const routeName = '/BookingPage';
  final SportsVenuesData sports;

  BookingPage({required this.sports});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {

  String changePrice = '';

  void fullPay(){
    setState(() {
      changePrice = '${widget.sports.price}';
    });
  }
  void dpPay(){
    setState(() {
      changePrice = '${widget.sports.dpPrice}';
    });
  }

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
                          child: Text('PESAN TEMPAT OLAHRAGA',
                            style: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,),
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
                              contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                              hintText: "Nama",
                              border: InputBorder.none,
                            ),
                            keyboardType: TextInputType.name,
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
                              contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                              hintText: "Alamat",
                              border: InputBorder.none,
                            ),
                            keyboardType: TextInputType.streetAddress,
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
                              contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                              hintText: "No. Telepon",
                              border: InputBorder.none,
                            ),
                            keyboardType: TextInputType.phone,
                          ),
                        ),
                      ],
                    ),
                  ),
                  DatePicker(),
                  TimePicker(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                      child: Text('PEMBAYARAN',
                        style: GoogleFonts.montserrat(
                        fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Container(
                              height: 50,
                              width: 150,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty
                                      .all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25.0)
                                    ),
                                  ),
                                ),
                                child: Text('BAYAR PENUH',
                                  style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onPressed: (){
                                  fullPay();
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Container(
                              height: 50,
                              width: 160,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty
                                      .all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25.0)
                                    ),
                                  ),
                                ),
                                child: Text('BAYAR DIMUKA',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onPressed: (){
                                  dpPay();
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
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
                  changePrice,
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
                      onTap: () {
                      },
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