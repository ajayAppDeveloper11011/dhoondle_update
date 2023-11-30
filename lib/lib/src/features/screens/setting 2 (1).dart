import 'package:dhoondle/lib/src/features/screens/services_tabbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/colors.dart';
import '../../constants/helper.dart';
import '../../constants/images.dart';

class Setting2 extends StatefulWidget {
  const Setting2({Key? key}) : super(key: key);

  @override
  State<Setting2> createState() => _Setting2State();
}

class _Setting2State extends State<Setting2> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
        height: size.height,
        width: size.width,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  Images.congratulationsnew,
                  height: size.height * 0.2,
                  width: size.width * 0.5,
                ),
                // SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Congratulations",
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                              color: Color(0xff4E4E4E),
                              fontWeight: FontWeight.w500,
                              fontSize: 25),
                        )),
                    Image.asset(
                      Images.congratulation2,
                      height: size.height * 0.1,
                      width: size.width * 0.1,
                    )
                  ],
                ),
                Text("You are now subscribed for a month. ",
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                          color: Color(0xff4C4C4C),
                          fontWeight: FontWeight.w400,
                          fontSize: 15),
                    )),
              ],
            ),
            Positioned(
              bottom: 20,
              right: 0,
              left: 0,
              child: MaterialButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ServicesTabbar()));
                  },
                  color: Color(0xffC60909),
                  textColor: Colors.black,
                  minWidth: 350,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Text("Ok",
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                      ))),
            )
          ],
        ),
      ),
    );
  }
}
