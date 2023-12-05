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
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/images.dart';
import '../controllers/become_provider_controller.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  final becomeBroviderController = Get.put(BecomeProviderController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () =>
                        {becomeBroviderController.becomeProviderApi("0")},
                    child: Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black26, width: 2),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            Images.house,
                            height: 200,
                            fit: BoxFit.fill,
                          ),
                          SizedBox(
                            width: 60,
                          ),
                          Text(
                            "Property",
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  color: Color(0xff4E4E4E),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  InkWell(
                    onTap: () =>
                        {becomeBroviderController.becomeProviderApi("1")},
                    child: Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black26, width: 2),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            Images.setting,
                            height: 200,
                            width: 200,
                            fit: BoxFit.fill,
                          ),
                          SizedBox(
                            width: 60,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Other",
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                      color: Color(0xff4E4E4E),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15),
                                ),
                              ),
                              Text(
                                "Services",
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                      color: Color(0xff4E4E4E),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
