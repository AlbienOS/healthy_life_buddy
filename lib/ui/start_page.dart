import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthy_buddy/common/colors_style.dart';
import 'package:healthy_buddy/ui/sports_list_page.dart';

class StartPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Container(
                  height: 50,
                  margin: EdgeInsets.symmetric(vertical: 30),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'HealthyBuddy',
                        style: GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                Container(
                  height: 250,
                  width: 250,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Images/Logo',
                        style: GoogleFonts.montserrat(fontSize: 18,),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        'Cari & Pesan Tempat \nOlahraga', textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 20.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(''
                        'Kamu bisa mencari dan memesan\n tempat olahraga sesuai\n keinginanmu', textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(fontSize: 18,),
                    ),
                  ],
                ),
                SizedBox(height: 20.0,),
                InkWell(
                  child: Container(
                    height: 100,
                    width: 250,
                    decoration: BoxDecoration(
                        color: buttonColor1,
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Telusuri',
                          style: GoogleFonts.montserrat(
                              fontSize: 18,
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return SportsListPage();
                    }));
                  },
                ),
                SizedBox(height: 20.0,),
                InkWell(
                  child: Container(
                    height: 100,
                    width: 250,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 2),
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Keluar',
                          style: GoogleFonts.montserrat(
                              fontSize: 18,
                              fontWeight: FontWeight.bold, color: buttonColor1),
                        ),
                      ],
                    ),
                  ),
                  onTap: (){
                    SystemNavigator.pop();
                  },
                ),
              ],
            ),
          ),
      ),
    );
  }

}