import 'dart:io';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dhoondle/src/constants/helper/session.dart';
import 'package:dhoondle/src/features/screens/profile_screen.dart';
import 'package:dhoondle/src/features/screens/service_screen.dart';
import 'package:dhoondle/src/features/screens/tabbar_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/colors.dart';

class BottomNaigation extends StatefulWidget {
  const BottomNaigation({Key? key}) : super(key: key);

  @override
  State<BottomNaigation> createState() => _BottomNaigationState();
}

class _BottomNaigationState extends State<BottomNaigation> {
  int _totalNotifications = 10;
  final GlobalKey<FormState> _changeUserDetailsKey = GlobalKey<FormState>();

  int selectedIndex = 0;
  PageController? _pageController;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    _pageController = PageController();


  }




  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showDialog(
            context: context,
            builder: (context) {
              return _exitPopup();
            });
        return false;
      },
      child: Scaffold(
        // bottomNavigationBar: CurvedNavigationBar(
        //   key: _bottomNavigationKey,
        //   index: 2,
        //   height: 75.0,
        //   items: <Widget>[
        //     Icon(
        //       Icons.add,
        //       size: 30,
        //       color: Colors.white,
        //     ),
        //     Icon(Icons.list, size: 30, color: Colors.white),
        //     Icon(Icons.compare_arrows, size: 30, color: Colors.white),
        //     Icon(Icons.call_split, size: 30, color: Colors.white),
        //     Icon(Icons.perm_identity, size: 30, color: Colors.white),
        //   ],
        //   color: AppColors.primaryColor,
        //   buttonBackgroundColor: AppColors.primaryColor,
        //   backgroundColor: Colors.white,
        //   animationCurve: Curves.easeInOut,
        //   animationDuration: Duration(milliseconds: 300),
        //   onTap: (index) {
        //     setState(() {
        //       _page = index;
        //     });
        //   },
        //   letIndexChange: (index) => true,
        // ),
        // )
        // key: _scaffoldKey,
        //   resizeToAvoidBottomInset: false,
        //   body: PageView(
        //       physics: NeverScrollableScrollPhysics(),
        //       controller: _pageController,
        //       onPageChanged: (index) {
        //         setState(() => selectedIndex = index);
        //       },
        //       children: <Widget>[
        //         TabbarScreen(),
        //         ServiceScreen(),
        //         ProfileScreen()
        //       ]),
        //   bottomNavigationBar: Padding(
        //     padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        //     child: Container(
        //       padding: EdgeInsets.symmetric(horizontal: 20),
        //       height: 70,
        //       decoration: BoxDecoration(
        //           // borderRadius: BorderRadius.only(
        //           //     topLeft: Radius.circular(30),
        //           //     topRight: Radius.circular(30)
        //           // ),
        //           color: AppColors.primaryColor),
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceAround,
        //         children: <Widget>[
        //           InkWell(
        //               onTap: () {
        //                 setState(() {
        //                   onItemTapped(0);
        //                 });
        //                 // Get.toNamed('/home');
        //               },
        //               child: selectedIndex == 0
        //                   ? Column(
        //                       mainAxisAlignment: MainAxisAlignment.center,
        //                       crossAxisAlignment: CrossAxisAlignment.center,
        //                       children: [
        //                         SizedBox(
        //                           height: 0,
        //                         ),
        //                         Container(
        //                             height: 0,
        //                             width: 40,
        //                             child: Divider(
        //                               color: Colors.white,
        //                               thickness: 3,
        //                             )),
        //                         SizedBox(
        //                           height: 10,
        //                         ),
        //                         Column(
        //                           children: [
        //                             Image.asset(
        //                               Images.home,
        //                               height: 25,
        //                               width: 25,
        //                               fit: BoxFit.fill,
        //                             ),
        //                             SizedBox(
        //                               height: 2,
        //                             ),
        //                             Text(
        //                               "Home",
        //                               style: GoogleFonts.lato(
        //                                   color: Colors.white,
        //                                   fontWeight: FontWeight.w300,
        //                                   fontSize: 14),
        //                             )
        //                           ],
        //                         ),
        //                       ],
        //                     )
        //                   : Column(
        //                       mainAxisAlignment: MainAxisAlignment.center,
        //                       crossAxisAlignment: CrossAxisAlignment.center,
        //                       children: [
        //                         Container(
        //                           height: 45,
        //                           width: 45,
        //                           child: Padding(
        //                             padding: EdgeInsets.all(8.0),
        //                             child: Image.asset(
        //                               Images.home,
        //                               height: 25,
        //                               width: 25,
        //                               fit: BoxFit.fill,
        //                             ),
        //                           ),
        //                         ),
        //                       ],
        //                     )),
        //           InkWell(
        //               onTap: () {
        //                 setState(() {
        //                   onItemTapped(1);
        //                 });
        //                 // Get.toNamed('/ServiceScreen');
        //               },
        //               child: selectedIndex == 1
        //                   ? Column(
        //                       mainAxisAlignment: MainAxisAlignment.center,
        //                       crossAxisAlignment: CrossAxisAlignment.center,
        //                       children: [
        //                         SizedBox(
        //                           height: 0,
        //                         ),
        //                         Container(
        //                             height: 0,
        //                             width: 40,
        //                             child: Divider(
        //                               color: Colors.white,
        //                               thickness: 3,
        //                             )),
        //                         SizedBox(
        //                           height: 10,
        //                         ),
        //                         Column(
        //                           children: [
        //                             Image.asset(
        //                               Images.services,
        //                               height: 25,
        //                               width: 25,
        //                               fit: BoxFit.fill,
        //                             ),
        //                             SizedBox(
        //                               height: 2,
        //                             ),
        //                             Text(
        //                               TextScreen.Services,
        //                               style: GoogleFonts.lato(
        //                                   color: Colors.white,
        //                                   fontWeight: FontWeight.w300,
        //                                   fontSize: 14),
        //                             )
        //                           ],
        //                         ),
        //                       ],
        //                     )
        //                   : Column(
        //                       mainAxisAlignment: MainAxisAlignment.center,
        //                       crossAxisAlignment: CrossAxisAlignment.center,
        //                       children: [
        //                         Container(
        //                           height: 45,
        //                           width: 45,
        //                           child: Padding(
        //                             padding: EdgeInsets.all(8.0),
        //                             child: Image.asset(
        //                               Images.unselected_services,
        //                               height: 25,
        //                               width: 25,
        //                               fit: BoxFit.cover,
        //                             ),
        //                           ),
        //                         ),
        //                       ],
        //                     )),
        //           InkWell(
        //               onTap: () {
        //                 setState(() {
        //                   onItemTapped(2);
        //                 });
        //                 // Get.toNamed('/profile');
        //               },
        //               child: selectedIndex == 2
        //                   ? Column(
        //                       mainAxisAlignment: MainAxisAlignment.center,
        //                       crossAxisAlignment: CrossAxisAlignment.center,
        //                       children: [
        //                         SizedBox(
        //                           height: 0,
        //                         ),
        //                         Container(
        //                             height: 0,
        //                             width: 40,
        //                             child: Divider(
        //                               color: Colors.white,
        //                               thickness: 3,
        //                             )),
        //                         SizedBox(
        //                           height: 10,
        //                         ),
        //                         Column(
        //                           children: [
        //                             Image.asset(
        //                               Images.profile,
        //                               height: 25,
        //                               width: 25,
        //                               fit: BoxFit.fill,
        //                             ),
        //                             SizedBox(
        //                               height: 2,
        //                             ),
        //                             Text(
        //                               TextScreen.Profile,
        //                               style: GoogleFonts.lato(
        //                                   color: Colors.white,
        //                                   fontWeight: FontWeight.w300,
        //                                   fontSize: 14),
        //                             )
        //                           ],
        //                         ),
        //                       ],
        //                     )
        //                   : Column(
        //                       mainAxisAlignment: MainAxisAlignment.center,
        //                       crossAxisAlignment: CrossAxisAlignment.center,
        //                       children: [
        //                         Container(
        //                           height: 45,
        //                           width: 45,
        //                           child: Padding(
        //                             padding: EdgeInsets.all(8.0),
        //                             child: Image.asset(
        //                               Images.unselected_profile,
        //                               height: 25,
        //                               width: 25,
        //                               fit: BoxFit.cover,
        //                             ),
        //                           ),
        //                         ),
        //                       ],
        //                     )),
        //         ],
        //       ),
        //     ),
        //   ),
        key: _scaffoldKey,
        // resizeToAvoidBottomInset: false,
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => selectedIndex = index);
          },
          children: <Widget>[
            TabbarScreen(),
            // ServiceScreen(),
            TabbarScreen(),
            TabbarScreen(),
            ProfileScreen(),
          ],
        ),
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: selectedIndex,
          height: 75.0,
          items: <Widget>[
            Column(
              children: [
                selectedIndex == 0
                    ? const SizedBox(
                        height: 6,
                      )
                    : const SizedBox(
                        height: 18,
                      ),
                SvgPicture.asset(
                  'assets/logo/home.svg', // Replace with your SVG file path
                  width: 22,
                  height: 22,
                ),
                const SizedBox(
                  height: 8,
                ),
                selectedIndex == 0
                    ? SizedBox.shrink()
                    : Text(
                        getTranslated(context, 'Home'),
                        style: GoogleFonts.lato(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.w400),
                      )
              ],
            ),
            Column(
              children: [
                selectedIndex == 1
                    ? const SizedBox(
                        height: 6,
                      )
                    : const SizedBox(
                        height: 18,
                      ),
                SvgPicture.asset(
                  'assets/logo/history.svg', // Replace with your SVG file path
                  width: 22,
                  height: 22,
                ),
                const SizedBox(
                  height: 8,
                ),
                selectedIndex == 1
                    ? const SizedBox.shrink()
                    : Text(getTranslated(context, 'History'),
                        style: GoogleFonts.lato(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.w400))
              ],
            ),
            Column(
              children: [
                selectedIndex == 2
                    ? SizedBox(
                        height: 6,
                      )
                    : const SizedBox(
                        height: 18,
                      ),
                Container(
                  decoration: BoxDecoration(
                      color: selectedIndex == 2
                          ? AppColors.primaryColor
                          : Colors.white,
                      borderRadius: BorderRadius.circular(50)),
                  child: Icon(
                    Icons.add,
                    size: 30,
                    color: selectedIndex == 2
                        ? Colors.white
                        : AppColors.primaryColor,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                selectedIndex == 2
                    ? SizedBox.shrink()
                    : InkWell(
                        onTap: () {
                          openChangeUserDetailsBottomSheet(context);
                        },
                        child: Text(getTranslated(context, 'Add'),
                            style: GoogleFonts.lato(
                                fontSize: 10,
                                color: Colors.white,
                                fontWeight: FontWeight.w400)))
              ],
            ),
            Column(
              children: [
                selectedIndex == 3
                    ? SizedBox(
                        height: 6,
                      )
                    : const SizedBox(
                        height: 18,
                      ),
                SvgPicture.asset(
                  'assets/logo/notification.svg', // Replace with your SVG file path
                  width: 22,
                  height: 22,
                ),
                const SizedBox(
                  height: 8,
                ),
                selectedIndex == 3
                    ? const SizedBox.shrink()
                    : Text(
                        getTranslated(context, 'Notification'),
                        style: GoogleFonts.lato(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.w400),
                      )
              ],
            ),
            Column(
              children: [
                selectedIndex == 4
                    ? SizedBox(
                        height: 6,
                      )
                    : const SizedBox(
                        height: 18,
                      ),
                Image.asset(
                  'assets/images/profile.png', // Replace with your SVG file path
                  width: 22,
                  height: 22,
                ),
                const SizedBox(
                  height: 8,
                ),
                selectedIndex == 4
                    ? const SizedBox.shrink()
                    : Text(
                        getTranslated(context, 'Settings'),
                        style: GoogleFonts.lato(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.w400),
                      )
              ],
            ),
            // Icon(Icons.list, size: 30, color: Colors.white),
            // Icon(Icons.compare_arrows, size: 30, color: Colors.white),
            // Icon(
            //   Icons.add,
            //   size: 30,
            //   color: Colors.white,
            // ),
            // Icon(Icons.call_split, size: 30, color: Colors.white),
            // Icon(Icons.perm_identity, size: 30, color: Colors.white),
          ],
          color: AppColors.primaryColor, // Change this to your desired color
          buttonBackgroundColor:
              AppColors.primaryColor, // Change this to your desired color
          backgroundColor: Colors.white,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 300),
          // onTap: (index) {
          //   setState(() {
          //     selectedIndex = index;
          //     _pageController!.animateToPage(index,
          //         duration: Duration(milliseconds: 300), curve: Curves.ease);
          //   });
          // },
          onTap: (index) {
            setState(() {
              selectedIndex = index;
              _pageController!.animateToPage(index,
                  duration: Duration(milliseconds: 300), curve: Curves.ease);
            });

            // Check if the tapped item is the add button (index 2)
            if (index == 2) {
              openChangeUserDetailsBottomSheet(context);
            }
          },

          letIndexChange: (index) => true,
        ),
      ),
    );
  }

  Widget _exitPopup() {
    return AlertDialog(
      title: const Text("Are You Sure"),
      content: const Text("You Want To Exit The App"),
      actions: <Widget>[
        MaterialButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(
            "No",
            style: TextStyle(color: AppColors.primaryColor),
          ),
        ),
        MaterialButton(
          onPressed: () {
            exit(0);
            // Helper.checkInternet(apiOfflineStatus("0"));
          },
          // Navigator.of(context).pop(true),
          child: Text(
            "Yes",
            style: TextStyle(color: AppColors.primaryColor),
          ),
        ),
      ],
    );
  }

  void onItemTapped(int value) {
    setState(() {
      selectedIndex = value;

      // _pageController!.animateToPage(value,
      //     duration: Duration(milliseconds: 300), curve: Curves.easeOut);

      _pageController!.jumpToPage(value);
    });
  }

  void openChangeUserDetailsBottomSheet(context) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0))),
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height / 2.4,
          child: Wrap(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Form(
                  key: _changeUserDetailsKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      bottomSheetHandle(context),
                      const SizedBox(
                        height: 40,
                      ),
                      // const Text(
                      //   'Services',
                      //   style: TextStyle(
                      //     fontSize: 20,
                      //     fontWeight: FontWeight.w500,
                      //   ),
                      // ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: Get.height * .35,
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                  child: GestureDetector(
                                onTap: () => Get.toNamed('/servicescreen'),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                                color: const Color.fromRGBO(
                                                    168, 242, 243, 1),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        40.0)),
                                            child: Image.asset(
                                              'assets/logo/support.png',
                                              scale: 2,
                                              color: Colors.orange,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 80,
                                          ),
                                          SizedBox(
                                            child: Text(
                                                getTranslated(context,
                                                    'service_provider'),
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.lato(
                                                    fontSize: 15,
                                                    color: AppColors.textcolor,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                        ],
                                      ),
                                      Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              color: const Color.fromRGBO(
                                                  168, 242, 243, 1),
                                              borderRadius:
                                                  BorderRadius.circular(40.0)),
                                          child: const Icon(
                                            Icons.arrow_forward,
                                            color: Colors.black,
                                          )),
                                    ],
                                  ),
                                ),
                              )),
                              const SizedBox(
                                height: 30,
                              ),
                              Expanded(
                                  child: GestureDetector(
                                onTap: () => Get.toNamed('/servicescreen'),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                                color: const Color.fromRGBO(
                                                    168, 242, 243, 1),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        40.0)),
                                            child: Image.asset(
                                              'assets/logo/house.png',
                                              scale: 1.5,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 80,
                                          ),
                                          SizedBox(
                                            child: Text(
                                                getTranslated(
                                                    context, 'Room_for_Rent'),
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.lato(
                                                    fontSize: 15,
                                                    color: AppColors.textcolor,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                        ],
                                      ),
                                      Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              color: const Color.fromRGBO(
                                                  168, 242, 243, 1),
                                              borderRadius:
                                                  BorderRadius.circular(40.0)),
                                          child: const Icon(
                                            Icons.arrow_forward,
                                            color: Colors.black,
                                          )),
                                    ],
                                  ),
                                ),
                              )),
                              const SizedBox(
                                height: 30.0,
                              ),
                              Expanded(
                                  child: GestureDetector(
                                onTap: () => Get.toNamed('/allproperty'),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                                color: const Color.fromRGBO(
                                                    168, 242, 243, 1),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        40.0)),
                                            child: Image.asset(
                                              'assets/logo/for-sale.png',
                                              scale: 1.5,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 80,
                                          ),
                                          SizedBox(
                                            child: Text(
                                                getTranslated(context,
                                                    'Selling Property'),
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.lato(
                                                    fontSize: 15,
                                                    color: AppColors.textcolor,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          )
                                        ],
                                      ),
                                      Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              color: const Color.fromRGBO(
                                                  168, 242, 243, 1),
                                              borderRadius:
                                                  BorderRadius.circular(40.0)),
                                          child: const Icon(
                                            Icons.arrow_forward,
                                            color: Colors.black,
                                          )),
                                    ],
                                  ),
                                ),
                              )),
                              const SizedBox(
                                height: 30.0,
                              ),
                              Expanded(
                                  child: GestureDetector(
                                onTap: () => Get.toNamed('/roomscreen'),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                                color: const Color.fromRGBO(
                                                    168, 242, 243, 1),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        40.0)),
                                            child: Image.asset(
                                              'assets/logo/room-mate.png',
                                              scale: 1.5,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 80,
                                          ),
                                          SizedBox(
                                            child: Text(getTranslated(context, 'Find_Roommate'),
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.lato(
                                                    fontSize: 15,
                                                    color: AppColors.textcolor,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          )
                                        ],
                                      ),
                                      Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              color: const Color.fromRGBO(
                                                  168, 242, 243, 1),
                                              borderRadius:
                                                  BorderRadius.circular(40.0)),
                                          child: const Icon(
                                            Icons.arrow_forward,
                                            color: Colors.black,
                                          )),
                                    ],
                                  ),
                                ),
                              )),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget bottomSheetHandle(context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.black.withOpacity(0.2)),
        height: 3,
        width: MediaQuery.of(context).size.width * 0.27,
      ),
    );
  }
}
