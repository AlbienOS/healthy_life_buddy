import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthy_life_buddy/common/text_style.dart';
import 'package:healthy_life_buddy/helper/navigation_helper.dart';
import 'package:healthy_life_buddy/model/detail_sports_venue_model.dart';
import 'package:healthy_life_buddy/widget/back_button.dart';
import 'package:intl/intl.dart';
import 'package:healthy_life_buddy/api/auth_api.dart';

class MemberPage extends StatefulWidget {
  static const routeName = '/MemberPage';
  const MemberPage({Key? key, required this.sportsVenueData}) : super(key: key);

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
  DateTime? dateTime;
  TimeOfDay? time;

  double fullPay() {
    changePrice =
        (widget.sportsVenueData.rentalCosts.toDouble() * 15 / 100) * 30;
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
      return DateFormat('dd/MM/yyyy').format(dateRange!.start);
    }
  }

  String getUntil() {
    if (dateRange == null) {
      return 'Sampai Tanggal';
    } else {
      return DateFormat('dd/MM/yyyy').format(dateRange!.end);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CustomBackButton(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Membership Tempat Olahraga',
                        style: textTheme.subtitle1?.apply(
                            color: Theme.of(context).colorScheme.onBackground),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 5,
                            child: textField(
                              context,
                              getFrom(),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Icon(Icons.arrow_forward,
                                color:
                                    Theme.of(context).colorScheme.onBackground),
                          ),
                          Expanded(
                            flex: 5,
                            child: textField(
                              context,
                              getUntil(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                              )),
                              onPressed: () {
                                pickedDateRange(context);
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Icon(Icons.calendar_today),
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0)),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              'Bayar',
                              style: GoogleFonts.montserrat(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                if (dateRange == null) {
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
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          confirmationDialogMessage(
                                            Icons.date_range,
                                            getFrom(),
                                          ),
                                          confirmationDialogMessage(
                                            Icons.date_range,
                                            getUntil(),
                                          ),
                                          confirmationDialogMessage(
                                            Icons.attach_money,
                                            fullPay().toInt().toString(),
                                          ),
                                          Center(
                                            child: Text(
                                              '*Notes : harga member sudah termasuk potongan 15%',
                                              style: textTheme.caption?.apply(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSurface,
                                              ),
                                            ),
                                          ),
                                        ],
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
                                          await member
                                              .doc(widget.sportsVenueData.id)
                                              .set(
                                            {
                                              'place':
                                                  widget.sportsVenueData.name,
                                              'startDate': getFrom(),
                                              'endDate': getUntil(),
                                              'payment': fullPay().toInt(),
                                            },
                                          );
                                          Navigator.pushReplacementNamed(
                                              context, Navigation.routeName);
                                          const snackBar = SnackBar(
                                            content: Text(
                                                'Pembuatan Member Berhasil!'),
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
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
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

  Row confirmationDialogMessage(IconData iconName, String content) {
    return Row(
      children: [
        Expanded(
            child:
                Icon(iconName, color: Theme.of(context).colorScheme.primary)),
        Expanded(
          flex: 3,
          child: Text(
            content,
            style: textTheme.bodyText1?.apply(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
      ],
    );
  }

  Container textField(BuildContext context, String content) {
    return Container(
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
    );
  }

  Future pickedDateRange(BuildContext context) async {
    final initialDateRange = DateTimeRange(
      start: DateTime.now(),
      end: DateTime.now().add(const Duration(hours: 24 * 30)),
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
