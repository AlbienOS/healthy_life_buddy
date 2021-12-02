import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthy_buddy/common/colors_style.dart';

class TimePicker extends StatefulWidget{
  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  TimeOfDay? time;

  String getTimeText(){
    if(time == null){
      return 'Pilih Waktu';
    }else{
      final hours = time!.hour.toString().padLeft(2, '0');
      final minutes = time!.minute.toString().padLeft(2, '0');

      return '$hours:$minutes';
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
                  getTimeText(),
                  style: GoogleFonts.montserrat(
                      fontSize: 16,
                      color: Colors.black),
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
                    shape: MaterialStateProperty
                        .all<RoundedRectangleBorder>
                      (RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    )
                ),
                onPressed: (){
                  pickedTime(context);
                },
                child: Icon(Icons.access_time)),
          ),
        ],
      ),
    );
  }
  Future pickedTime(BuildContext context) async{
    final selectedTime = TimeOfDay(hour: 11, minute: 0);
    final newTimePicked = await showTimePicker(
      context: context,
      initialTime: time ?? selectedTime,
    );
    if(newTimePicked == null) return;
    setState(() => time = newTimePicked);
  }
}