import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthy_life_buddy/common/color_style.dart';
import 'package:healthy_life_buddy/model/detail_sports_venue_model.dart';
import 'package:intl/intl.dart';
import 'package:healthy_life_buddy/api/auth_api.dart';

class MemberPage extends StatefulWidget {
  static const routeName = '/MemberPage';
  const MemberPage({Key? key, required this.sportsVenueData})
      : super(key: key);

  final DetailSportsVeneu sportsVenueData;

  @override
  State<MemberPage> createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage> {
  CollectionReference member = FirebaseFirestore.instance
      .collection('users')
      .doc(auth.currentUser!.uid)
      .collection('member');

  DateTimeRange? dateRange;
  double changePrice = 0;
  String nameResult = '';
  String addressResult = '';
  String telephoneResult = '';
  DateTime? dateTime;
  TimeOfDay? time;

  double fullPay() {
      changePrice = (widget.sportsVenueData.rentalCosts.toDouble() * 15/100) * 30;
      return changePrice;
  }

  String getDateText() {
    if (dateTime == null) {
      return 'Pilih Tanggal';
    } else {
      return DateFormat('dd/MM/yyyy').format(dateTime!);
    }
  }

  String getFrom() {
    if (dateRange == null) {
      return 'Dari Tanggal';
    } else {
      return DateFormat('MM/dd/yyyy').format(dateRange!.start);
    }
  }

  String getUntil() {
    if (dateRange == null) {
      return 'Sampai Tanggal';
    } else {
      return DateFormat('MM/dd/yyyy').format(dateRange!.end);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
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
                          'MEMBER TEMPAT OLAHRAGA',
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 150,
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              height: 50,
                              width: 100,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Center(
                                child: Text(
                                  getFrom(),
                                  style: GoogleFonts.montserrat(
                                      fontSize: 16, color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                          Icon(Icons.arrow_forward, color: Colors.black),

                          Container(
                            width: 150,
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              height: 50,
                              width: 100,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Center(
                                child: Text(
                                  getUntil(),
                                  style: GoogleFonts.montserrat(
                                      fontSize: 16, color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 30),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 60,
                    width: 350,
                    decoration: BoxDecoration(
                      color: primaryVariantColor,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            )),
                        onPressed: () {
                          pickedDateRange(context);
                        },
                        child: Icon(Icons.calendar_today)),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 50,
        child: Column(
          children: [
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
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                          ),
                        ),
                        child: Text(
                          'MEMBER',
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return  AlertDialog(
                                    title: Center(
                                        child: Text('KONFIRMASI MEMBER')),
                                    content: Container(
                                      height: 300,
                                      width: 400,
                                      child: SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Divider(thickness: 2.0),
                                            SizedBox(height: 10.0),
                                            Row(
                                              children: [
                                                Icon(Icons.date_range),
                                                Text('Mulai  : ' +
                                                    getFrom()),
                                              ],
                                            ),
                                            Divider(thickness: 2.0),
                                            SizedBox(height: 10.0),
                                            Row(
                                              children: [
                                                Icon(Icons.date_range),
                                                Text('Berakhir : ' +
                                                    getUntil()),
                                              ],
                                            ),
                                            Divider(thickness: 2.0),
                                            SizedBox(height: 10.0),
                                            Row(
                                              children: [
                                                Icon(Icons.attach_money),
                                                Text('Harga : ' + fullPay().toString()),
                                              ],
                                            ),
                                            Divider(thickness: 2.0),
                                            Row(
                                              children: [
                                                Text('*Notes : harga member sudah termasuk potongan 15%', style: TextStyle(fontSize: 10),),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        child: Text("Batal"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                      TextButton(
                                        child: Text("Oke"),
                                        onPressed: () async {
                                          await member.add({
                                            'place' : widget.sportsVenueData.name,
                                            'startDate' : getFrom(),
                                            'endDate': getUntil(),
                                          }).then((value) =>
                                              print('Membership Success'));
                                          Navigator.pop(context);
                                          final snackBar = SnackBar(
                                            content: Text(
                                                'Pembuatan Member Berhasil!'),
                                            action: SnackBarAction(
                                                label: 'ULANGI',
                                                onPressed: () {}),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        },
                                      ),
                                    ],
                                  );
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

  Future pickedDateRange(BuildContext context) async {
    final initialDateRange = DateTimeRange(
      start: DateTime.now(),
      end: DateTime.now().add(Duration(hours: 24 * 30)),

    );
    final newDateRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDateRange: dateRange ?? initialDateRange,

    );

    if (newDateRange == null) return;

    setState(() => dateRange = newDateRange);
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

}
