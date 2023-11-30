import 'package:dhoondle/lib/src/features/screens/setting%202%20(1).dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/widgets.dart';

import 'package:google_fonts/google_fonts.dart';

import '../../constants/colors.dart';
import '../../constants/helper.dart';
import '../../constants/images.dart';

class Setting3 extends StatefulWidget {
  const Setting3({Key? key}) : super(key: key);

  @override
  State<Setting3> createState() => _Setting3State();
}

class _Setting3State extends State<Setting3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        toolbarHeight: 80,
        leading: InkWell(
          onTap: () {
            Helper.popScreen(context);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        centerTitle: true,
        elevation: 0,
        title: Text("Settings",
            style: GoogleFonts.lato(
              textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            )),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(Images.percent, alignment: Alignment.center),
              ),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Color(
                    0xffC7C6C6,
                  ))),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text("49 Rs/Month",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            color: Color(0xff4E4E4E),
                            fontWeight: FontWeight.w500,
                            fontSize: 30,
                          ),
                        )),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                    "Get unlimited browsing of rooms and service for a month.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                          color: Color(0xff4C4C4C),
                          fontWeight: FontWeight.w500,
                          fontSize: 15),
                    )),
              ),
              // Text("service for a month",textAlign: TextAlign.center,
              //     style: GoogleFonts.lato(
              //       textStyle: TextStyle(
              //           color: Color(0xff4C4C4C),
              //           fontWeight: FontWeight.w500,
              //           fontSize: 15),
              //     )),
              SizedBox(
                height: 20,
              ),
              Text(
                "Benfits:",
                textAlign: TextAlign.right,
                style: GoogleFonts.lato(
                    textStyle: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Color(0xff4E4E4E),
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.circle,
                    color: Color(0xff4C4C4C),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Get ultimated browsing of rooms and",
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                color: Color(0xff4C4C4C),
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                          )),
                      Text("service for a month.",
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                color: Color(0xff4C4C4C),
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                          )),
                    ],
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.circle,
                    color: Color(0xff4C4C4C),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Get ultimated browsing of rooms and",
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                color: Color(0xff4C4C4C),
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                          )),
                      Text("service for a month.",
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                color: Color(0xff4C4C4C),
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                          )),
                    ],
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.circle,
                    color: Color(0xff4C4C4C),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Get ultimated browsing of rooms and",
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                color: Color(0xff4C4C4C),
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                          )),
                      Text("service for a month.",
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                color: Color(0xff4C4C4C),
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                          )),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 50,
              ),
              MaterialButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Setting2()));
                  },
                  color: Color(0xffC60909),
                  textColor: Colors.black,
                  minWidth: 350,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Text("Subscribe",
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
