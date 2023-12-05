
import 'package:dhoondle/src/constants/helper/session.dart';
import 'package:dhoondle/src/features/screens/property_screen.dart';
import 'package:dhoondle/src/features/screens/service_property_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/colors.dart';
import '../../constants/images.dart';
import '../../constants/text.dart';


class ServicesTabbar extends StatefulWidget {
  const ServicesTabbar({Key? key}) : super(key: key);

  @override
  State<ServicesTabbar> createState() => _ServicesTabbarState();
}

class _ServicesTabbarState extends State<ServicesTabbar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.primaryColor,
            toolbarHeight: 80,
            leading: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Image.asset(
                Images.logo,
                height: 200,
              ),
            ),
            centerTitle: true,
            elevation: 0,
            title: Text(TextScreen.service_provider,
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
          body: SafeArea(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: DefaultTabController(
                  length: 2,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: TabBar(
                                  automaticIndicatorColorAdjustment: true,
                                  isScrollable: false,
                                  labelStyle: GoogleFonts.openSans(
                                      textStyle: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  )),
                                  unselectedLabelColor: AppColors.greycolor,
                                  labelColor: Colors.grey,
                                  controller: _tabController,
                                  indicatorSize: TabBarIndicatorSize.tab,
                                  indicatorWeight: 2,
                                  indicatorColor: AppColors.textcolor,
                                  tabs: [
                                    Tab(
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            _tabController.index = 0;
                                          });
                                        },
                                        child: Center(
                                            child: _tabController.index == 0
                                                ? Container(
                                                    // padding: EdgeInsets.symmetric(horizontal: 0,vertical: 0),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    child: MaterialButton(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 0,
                                                                vertical: 0),
                                                        // textColor: Colors.white,
                                                        child: Text(
                                                            getTranslated(context, TextScreen.Property),
                                                            style: GoogleFonts
                                                                .lato(
                                                              textStyle: TextStyle(
                                                                  color: AppColors
                                                                      .textcolor,
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            )),
                                                        onPressed: () {}),
                                                  )
                                                : Text(getTranslated(context, TextScreen.Property),
                                                    style: GoogleFonts.lato(
                                                      textStyle: TextStyle(
                                                          color: AppColors
                                                              .greycolor,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ))),
                                      ),
                                    ),
                                    Tab(
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            _tabController.index = 1;
                                          });
                                        },
                                        child: Center(
                                            child: _tabController.index == 01
                                                ? Container(
                                                    // padding: EdgeInsets.symmetric(horizontal: 0,vertical: 0),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    child: MaterialButton(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 0,
                                                                vertical: 0),
                                                        // textColor: Colors.white,
                                                        child: Text(
                                                            getTranslated(context, TextScreen.Services),
                                                            style: GoogleFonts
                                                                .lato(
                                                              textStyle: TextStyle(
                                                                  color: AppColors
                                                                      .textcolor,
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            )),
                                                        onPressed: () {}),
                                                  )
                                                : Text(getTranslated(context, TextScreen.Services),
                                                    style: GoogleFonts.lato(
                                                      textStyle: TextStyle(
                                                          color: AppColors
                                                              .greycolor,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ))),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Image.asset(ProjectImage.search,height: 40,),
                              // SizedBox(width: 10,),
                              // Image.asset(ProjectImage.home,height: 40,)                      ],
                            ]),
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          // physics: NeverScrollableScrollPhysics(),
                          children: const [
                            PropertyScreen(),
                            ServiceScreenTabbar(),
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
          )),
    );
  }
}
