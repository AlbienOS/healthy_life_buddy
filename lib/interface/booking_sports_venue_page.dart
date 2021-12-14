import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthy_life_buddy/api/auth_api.dart';
import 'package:healthy_life_buddy/common/color_style.dart';
import 'package:healthy_life_buddy/interface/home_page.dart';
import 'package:healthy_life_buddy/model/detail_sports_venue_model.dart';
import 'package:intl/intl.dart';


class BookingSportsVenuePage extends StatefulWidget {
  static const routeName = '/BookingSportsRevnuePage';
  const BookingSportsVenuePage({Key? key, required this.sportsVenueData})
      : super(key: key);

  final DetailSportsVeneu sportsVenueData;


  @override
  State<BookingSportsVenuePage> createState() => _BookingSportsVenuePageState();
}

class _BookingSportsVenuePageState extends State<BookingSportsVenuePage> {
  CollectionReference booking = FirebaseFirestore
      .instance
      .collection('users')
      .doc(auth.currentUser!.uid)
      .collection('booking');

  int changePrice = 0;
  String nameResult = '';
  String addressResult = '';
  String telephoneResult = '';
  DateTime? dateTime;
  TimeOfDay? time;

  void fullPay() {
    setState(() {
      changePrice = widget.sportsVenueData.rentalCosts;
    });
  }

  void dpPay() {
    setState(() {
      changePrice = widget.sportsVenueData.downPayment;
    });
  }

  String getDateText() {
    if (dateTime == null) {
      return 'Pilih Tanggal';
    } else {
      return DateFormat('dd/MM/yyyy').format(dateTime!);
    }
  }

  String getTimeText() {
    if (time == null) {
      return 'Pilih Waktu';
    } else {
      final hours = time!.hour.toString().padLeft(2, '0');
      final minutes = time!.minute.toString().padLeft(2, '0');

      return '$hours.$minutes';
    }
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
                              onChanged: (value){
                                nameResult = value;
                              },
                              decoration: InputDecoration(
                                contentPadding:
                                EdgeInsets.symmetric(horizontal: 8.0),
                                hintText: "Nama",
                                border: InputBorder.none,
                              ),
                              keyboardType: TextInputType.name,
                              onSubmitted: (String res) async {
                                // await booking.add({
                                //   'address' : addressResult}).then((value) => print('Address Added'));
                                setState(() {
                                  nameResult = res;
                                });
                              },
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
                              onChanged: (value){
                                addressResult = value;
                              },
                              decoration: InputDecoration(
                                contentPadding:
                                EdgeInsets.symmetric(horizontal: 8.0),
                                hintText: "Alamat",
                                border: InputBorder.none,
                              ),
                              keyboardType: TextInputType.streetAddress,
                              onSubmitted: (String res) async {
                                // await booking.add({
                                //   'address' : addressResult}).then((value) => print('Address Added'));
                                setState(() {
                                  addressResult = res;
                                });
                              },
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
                              onChanged: (value){
                                telephoneResult = value;
                              },
                              decoration: InputDecoration(
                                contentPadding:
                                EdgeInsets.symmetric(horizontal: 8.0),
                                hintText: "No. Telepon",
                                border: InputBorder.none,
                              ),
                              keyboardType: TextInputType.phone,
                              onSubmitted: (String res) async {
                                // await booking.add({
                                //   'telephone' : telephoneResult}).then((value) => print('Telephone Added'));
                                setState(() {
                                  telephoneResult = res;
                                });
                              },
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
                            width: 250,
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              height: 60,
                              width: 250,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Center(
                                child: Text(
                                  getDateText(),
                                  style:
                                  GoogleFonts.montserrat(fontSize: 16, color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 30),
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: primaryVariantColor,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                    )),
                                onPressed: () {
                                  pickedDate(context);
                                },
                                child: Icon(Icons.calendar_today)),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Container(
                            width: 250,
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              height: 60,
                              width: 250,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Center(
                                child: Text(
                                  getTimeText(),
                                  style:
                                  GoogleFonts.montserrat(fontSize: 16, color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 30),
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: primaryVariantColor,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                    )),
                                onPressed: () {
                                  pickedTime(context);
                                },
                                child: Icon(Icons.access_time)),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 10.0),
                          child: Text(
                            'PEMBAYARAN',
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
                              padding:
                              const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Container(
                                height: 50,
                                width: 150,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(25.0)),
                                    ),
                                  ),
                                  child: Text(
                                    'BAYAR PENUH',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      changePrice = widget.sportsVenueData.rentalCosts;

                                    });
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Container(
                                height: 50,
                                width: 160,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(25.0)),
                                    ),
                                  ),
                                  child: Text(
                                    'BAYAR DIMUKA',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      changePrice = widget.sportsVenueData.downPayment;
                                    });

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
                    '${changePrice}',
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
                      Container(
                        height: 50,
                        width: 400,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(20.0)),
                            ),
                          ),
                          child: Text(
                            'BAYAR',
                            style: GoogleFonts.montserrat(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            showDialog(context: context, builder: (context){
                              if(nameResult.isEmpty){
                                return AlertDialog(
                                  title: Text('Semua Kolom Harus Terisi'),
                                  actions: [
                                    TextButton(
                                      child: Text("Cancel"),
                                      onPressed:  () {},
                                    ),
                                    TextButton(
                                      child: Text("Oke"),
                                      onPressed:  () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              } else if(addressResult.isEmpty){
                                return AlertDialog(
                                  title: Text('Semua Kolom Harus Terisi'),
                                  actions: [
                                    TextButton(
                                      child: Text("Cancel"),
                                      onPressed:  () {},
                                    ),
                                    TextButton(
                                      child: Text("Oke"),
                                      onPressed:  () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              } else if(telephoneResult.isEmpty){
                                return AlertDialog(
                                  title: Text('Semua Kolom Harus Terisi'),
                                  actions: [
                                    TextButton(
                                      child: Text("Cancel"),
                                      onPressed:  () {},
                                    ),
                                    TextButton(
                                      child: Text("Oke"),
                                      onPressed:  () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              }else{
                                return AlertDialog(
                                  title: Center(
                                      child: Text('KONFIRMASI')
                                  ),
                                  content: Container(
                                    height: 300,
                                    width: 400,
                                    child:  SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.person),
                                              Text('        : ${nameResult}'),
                                            ],
                                          ),
                                          Divider(thickness: 2.0),
                                          SizedBox(height: 10.0),
                                          Row(
                                            children: [
                                              Icon(Icons.add_location),
                                              Text('        : ${addressResult}'),
                                            ],
                                          ),
                                          Divider(thickness: 2.0),
                                          SizedBox(height: 10.0),
                                          Row(
                                            children: [
                                              Icon(Icons.contact_phone),
                                              Text('        : ${telephoneResult}'),
                                            ],
                                          ),
                                          Divider(thickness: 2.0),
                                          SizedBox(height: 10.0),
                                          Row(
                                            children: [
                                              Icon(Icons.date_range),
                                              Text('        : ' + getDateText()),
                                            ],
                                          ),
                                          Divider(thickness: 2.0),
                                          SizedBox(height: 10.0),
                                          Row(
                                            children: [
                                              Icon(Icons.access_time),
                                              Text('        : ' + getTimeText()),
                                            ],
                                          ),
                                          Divider(thickness: 2.0),
                                          SizedBox(height: 10.0),
                                          Row(
                                            children: [
                                              Icon(Icons.attach_money),
                                              Text('        : ${changePrice}'),
                                            ],
                                          ),
                                          Divider(thickness: 2.0),
                                        ],
                                      ),
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      child: Text("Cancel"),
                                      onPressed:  () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    TextButton(
                                      child: Text("Oke"),
                                      onPressed:  () async {
                                        await booking.add({
                                          'name' : nameResult,
                                          'address' : addressResult,
                                          'telephone' : telephoneResult,
                                          'date' : getDateText(),
                                          'time' : getTimeText(),
                                          'cost' : changePrice,
                                        }).then((value) => print('Booking Added'));
                                        Navigator.push(context, MaterialPageRoute(builder: (context){
                                          return HomePage();  

                                        }));
                                        final snackBar = SnackBar(
                                          content: Text('Pemesanan Berhasil!'),
                                          action: SnackBarAction(label: 'ULANGI',
                                              onPressed: (){
                                              }
                                          ),
                                        );
                                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                      },
                                    ),
                                  ],

                                );
                              }
                            });
                          },
                        ),
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

  Future pickedDate(BuildContext context) async {
    final selectedDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: dateTime ?? selectedDate,
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (newDate == null) return;

    setState(() => dateTime = newDate);
  }

  Future pickedTime(BuildContext context) async {
    final selectedTime = TimeOfDay(hour: 11, minute: 0);
    final newTimePicked = await showTimePicker(
      context: context,
      initialTime: time ?? selectedTime,
    );
    if (newTimePicked == null) return;
    setState(() => time = newTimePicked);
  }
}


