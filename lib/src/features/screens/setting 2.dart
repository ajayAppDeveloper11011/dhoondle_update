import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/images.dart';

class Setting2 extends StatefulWidget {
  const Setting2({Key? key}) : super(key: key);

  @override
  State<Setting2> createState() => _Setting2State();
}

class _Setting2State extends State<Setting2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Image.asset(Images.congratulations, height: 200,width: 200,),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Congratulations",
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                              color: Color(0xff4E4E4E),
                              fontWeight: FontWeight.w500,
                              fontSize: 30),
                        )),
                    Image.asset(Images.congratulation2)
                  ],
                ),
                Text("You are now subscribed for a month. ",
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                          color: Color(0xff4C4C4C),
                          fontWeight: FontWeight.w400,
                          fontSize: 18),
                    )),
                SizedBox(
                  height: 300,
                ),

                MaterialButton(
                    onPressed: () {},
                    color: Color(0xffC60909),
                    textColor: Colors.black,
                    minWidth: 350,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: Text("Home",
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 15),
                        ))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
