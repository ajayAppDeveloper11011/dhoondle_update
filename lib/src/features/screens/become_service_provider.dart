import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dhoondle/src/features/screens/services_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants/colors.dart';
import '../../constants/images.dart';
import '../../constants/text.dart';
import '../controllers/become_provider_controller.dart';

class BecomeServiceProvider extends StatefulWidget {
  const BecomeServiceProvider({super.key});

  @override
  State<BecomeServiceProvider> createState() => _BecomeServiceProviderState();
}

class _BecomeServiceProviderState extends State<BecomeServiceProvider> {
  final becomeBroviderController = Get.put(BecomeProviderController());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        toolbarHeight: 80,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: ClipRect(
            child: Image.asset(
              Images.logo,
              height: 200,
            ),
          ),
        ),
        centerTitle: true,
        elevation: 0,
        title: Text(TextScreen.settings,
            style: GoogleFonts.lato(
              textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            )),
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.all(25),
        //     child: Image.asset(Images.search,),
        //   ),
        // ],
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.05,
              ),
              InkWell(
                onTap: () => {
                  becomeBroviderController.becomeProviderApi("0")

                  // Get.to(ServicesTabbar())
                },
                child: Container(
                  height: 160,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xff969696), width: 0.5),
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 160,
                        width: size.width / 2.3,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              Images.house,
                              fit: BoxFit.fill,
                            )),
                      ),
                      Container(
                        height: 160,
                        width: size.width / 2.3,
                        child: Center(
                          child: Text(
                            TextScreen.Property,
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  color: Color(0xff4E4E4E),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () => {becomeBroviderController.becomeProviderApi("1")},
                child: Container(
                  height: 160,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xff969696), width: 0.5),
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 160,
                        width: size.width / 2.3,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              Images.setting,
                              fit: BoxFit.fill,
                            )),
                      ),
                      Container(
                        height: 160,
                        width: size.width / 2.3,
                        child: Center(
                          child: Text(
                            TextScreen.other_service,
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  color: Color(0xff4E4E4E),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
