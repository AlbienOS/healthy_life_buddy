import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthy_life_buddy/common/color_style.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime? dateTime;

  String getDateText() {
    if (dateTime == null) {
      return 'Pilih Tanggal';
    } else {
      return DateFormat('dd/MM/yyyy').format(dateTime!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
}
