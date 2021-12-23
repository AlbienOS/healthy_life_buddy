import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthy_life_buddy/api/auth_api.dart';
import 'package:healthy_life_buddy/common/text_style.dart';
import 'package:healthy_life_buddy/helper/navigation_helper.dart';
import 'package:healthy_life_buddy/model/detail_sports_venue_model.dart';
import 'package:healthy_life_buddy/provider/payment_provider.dart';
import 'package:healthy_life_buddy/provider/preference_notif_provider.dart';
import 'package:healthy_life_buddy/widget/back_button.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BookingSportsVenuePage extends StatefulWidget {
  static const routeName = '/BookingSportsRevnuePage';
  const BookingSportsVenuePage({Key? key, required this.sportsVenueData})
      : super(key: key);

  final DetailSportsVeneu sportsVenueData;

  @override
  State<BookingSportsVenuePage> createState() => _BookingSportsVenuePageState();
}

class _BookingSportsVenuePageState extends State<BookingSportsVenuePage> {
  CollectionReference booking = FirebaseFirestore.instance
      .collection('users')
      .doc(auth.currentUser!.uid)
      .collection('booking');

  int changePrice = 0;
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
      return DateFormat('yyyy-MM-dd').format(dateTime!);
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
    return ChangeNotifierProvider<PaymentProvider>(
      create: (BuildContext context) => PaymentProvider(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: CustomBackButton(),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'Pesan Tempat Olahraga',
                          style: textTheme.subtitle1?.apply(
                              color:
                                  Theme.of(context).colorScheme.onBackground),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: textField(
                                context,
                                getDateText(),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  pickedDate(context);
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Icon(Icons.calendar_today),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: textField(
                                context,
                                getTimeText(),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  pickedTime(context);
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Icon(Icons.access_time),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Consumer<PaymentProvider>(
                            builder: (context, snapshot, _) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: snapshot.paymentStatus ==
                                              "Full Payment"
                                          ? Colors.blue
                                          : Colors.grey,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text(
                                        'Bayar Penuh',
                                        style: textTheme.button?.apply(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary),
                                      ),
                                    ),
                                    onPressed: () {
                                      snapshot.setPaymentStatus =
                                          "Full Payment";
                                      snapshot.setPayment =
                                          widget.sportsVenueData.rentalCosts;
                                    },
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: snapshot.paymentStatus ==
                                              "Down Payment"
                                          ? Colors.blue
                                          : Colors.grey,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text(
                                        'Bayar Dimuka',
                                        style: textTheme.button?.apply(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary),
                                      ),
                                    ),
                                    onPressed: () {
                                      snapshot.setPaymentStatus =
                                          "Down Payment";
                                      snapshot.setPayment =
                                          widget.sportsVenueData.downPayment;
                                    },
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total pembayaran :',
                                style: textTheme.headline6?.apply(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground),
                              ),
                              Consumer<PaymentProvider>(
                                  builder: (context, snapshot, _) {
                                return Text(
                                  snapshot.payment.toString(),
                                  style: textTheme.headline6?.apply(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Consumer<PaymentProvider>(
                              builder: (context, snapshot, _) {
                            return ElevatedButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  'Bayar',
                                  style: textTheme.subtitle1?.apply(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary),
                                ),
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    if (snapshot.payment == 0) {
                                      return alertDialogMessage(context);
                                    } else if (dateTime == null) {
                                      return alertDialogMessage(context);
                                    } else if (time == null) {
                                      return alertDialogMessage(context);
                                    } else {
                                      return AlertDialog(
                                        title: Center(
                                          child: Text(
                                            'Konfirmasi',
                                            style: textTheme.headline5?.apply(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSurface),
                                          ),
                                        ),
                                        content: SingleChildScrollView(
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                confirmationDialogMessage(
                                                  Icons.date_range,
                                                  getDateText(),
                                                ),
                                                confirmationDialogMessage(
                                                  Icons.access_time,
                                                  getTimeText(),
                                                ),
                                                confirmationDialogMessage(
                                                  Icons.attach_money,
                                                  snapshot.payment.toString(),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            child: Text(
                                              "Batal",
                                              style: textTheme.button?.apply(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onSurface),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                          TextButton(
                                            child: Text(
                                              "Oke",
                                              style: textTheme.button?.apply(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onSurface),
                                            ),
                                            onPressed: () async {
                                              scheduleSport(DateTime.parse(
                                                  getDateText()));
                                              await booking.add(
                                                {
                                                  'sportsVenueId':
                                                      widget.sportsVenueData.id,
                                                  'sportsVenueName': widget
                                                      .sportsVenueData.name,
                                                  'date': getDateText(),
                                                  'time': getTimeText(),
                                                  'payment': snapshot.payment,
                                                  'paymentStatus':
                                                      snapshot.paymentStatus,
                                                  'userId':
                                                      auth.currentUser!.uid,
                                                },
                                              );
                                              Navigator.pushReplacementNamed(
                                                  context,
                                                  Navigation.routeName);
                                              const snackBar = SnackBar(
                                                content:
                                                    Text('Pemesanan Berhasil!'),
                                              );
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                            },
                                          ),
                                        ],
                                      );
                                    }
                                  },
                                );
                              },
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding confirmationDialogMessage(IconData iconName, String messageText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Icon(iconName, color: Theme.of(context).colorScheme.primary),
          ),
          Expanded(
            flex: 3,
            child: Text(
              messageText,
              style: textTheme.bodyText1?.apply(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }

  AlertDialog alertDialogMessage(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Semua Kolom Harus Terisi',
        style: textTheme.subtitle1
            ?.apply(color: Theme.of(context).colorScheme.onSurface),
      ),
      actions: [
        TextButton(
          child: Text(
            "Oke",
            style: textTheme.subtitle1
                ?.apply(color: Theme.of(context).colorScheme.primary),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  Padding textField(BuildContext context, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              content,
              style: textTheme.headline6
                  ?.apply(color: Theme.of(context).colorScheme.onSurface),
            ),
          ),
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(25),
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
    const selectedTime = TimeOfDay(hour: 8, minute: 0);
    final newTimePicked = await showTimePicker(
      context: context,
      initialTime: time ?? selectedTime,
    );
    if (newTimePicked == null) return;
    setState(() => time = newTimePicked);
  }
}
