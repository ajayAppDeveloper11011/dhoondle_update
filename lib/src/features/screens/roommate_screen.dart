import 'dart:convert';

import 'package:dhoondle/src/Models/get_roommates_response.dart';
import 'package:dhoondle/src/features/screens/property_details_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import '../../api_model/get_property_list_model.dart';
import '../../constants/colors.dart';
import '../../constants/helper.dart';
import '../../constants/images.dart';
import 'package:http/http.dart' as http;

class RoomMateScreen extends StatefulWidget {
  String category = "";
  RoomMateScreen();

  @override
  State<RoomMateScreen> createState() => _RoomMateScreenState();
}

class _RoomMateScreenState extends State<RoomMateScreen> {
  final dio = Dio();
  GetPropertyList? getPropertyList;
  var isLoading = true.obs;
  bool _isVisible = false;
  bool _hasData = true;
  var searchBar = false;
  String? phoneNumber;
  var searchController = TextEditingController();
  // ApiController controller = Get.put(ApiController());
  // HomePropertyController homePropertyController = Get.put(HomePropertyController());
  void initState() {
    // TODO: implement initState
    getRoommates();
    super.initState();
    // Helper.checkInternet(homeApi(widget.category)); // Main
    // // controller.getpropertyapi();
    // // homePropertyController.homeApi(widget.category);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
            backgroundColor: AppColors.primaryColor,
            centerTitle: true,
            elevation: 0,
            title: searchBar == true
                ? Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    height: 40,
                    width: Get.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border:
                            Border.all(color: AppColors.greycolor, width: 1),
                        borderRadius: BorderRadius.circular(12.0)),
                    child: TextField(
                      controller: searchController,
                      autofocus: true,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: 'Search Here'),
                    ),
                  )
                : Text('Find Roommate',
                    style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    )),
            actions: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      if (searchBar == true) {
                        searchBar = false;
                      } else {
                        searchBar = true;
                      }
                    });
                  },
                  icon: Icon(
                    searchBar == true ? Icons.clear : Icons.search,
                    color: Colors.white,
                  ))
            ]
            // title: Text('Find Roommate'),
            // actions: [
            //   Padding(
            //     padding: const EdgeInsets.all(15.0),
            //     child: Image.asset(
            //       Images.search,
            //       height: size.height * 0.1,
            //     ),
            //   ),
            // ],
            ),
        // floatingActionButton: MultiFab(),
        floatingActionButton: FloatingActionButton.extended(
            backgroundColor: AppColors.primaryColor,
            onPressed: () {
              Get.toNamed('/findroommate');
            },
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            label: Text('Add New')),
        body: Stack(
          children: [
            // getPropertyList == null
            getPropertyList != null
                ? Container(
                    height: 400,
                    child: Center(child: Text("No property found")),
                  )
                : Container(
                    height: size.height,
                    width: size.width,
                    // child: getPropertyList!.propertyList.isEmpty
                    child: getPropertyList != null
                        ? Container(
                            height: 400,
                            child: Center(child: Text("No property found")),
                          )
                        : ListView.builder(
                            // itemCount: getPropertyList!.propertyList.length,
                            itemCount: roommatesData?.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () => {
                                  Get.to(PropertyDetailsScreen(
                                      // property_id: getPropertyList!
                                      //     .propertyList[index]!.propertyId
                                      //     .toString(),
                                      property_id: '12345'))
                                  // Get.to(PropertyDetailsScreen())
                                  // Get.toNamed('/propertydetail')
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 0.0, vertical: 0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Stack(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20.0, vertical: 20),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              // child: CachedNetworkImage(
                                              //   // imageUrl: getPropertyList!
                                              //   //     .propertyList[index]!.image
                                              //   //     .toString(),
                                              //        imageUrl: getPropertyList!
                                              //       .propertyList[index]!.image
                                              //       .toString(),
                                              //   fit: BoxFit.fill,
                                              //   height: size.height * 0.25,
                                              //   width: size.width,
                                              //   placeholder: (context, url) =>
                                              //       LinearProgressIndicator(
                                              //     color:
                                              //         Colors.white.withOpacity(0.2),
                                              //     backgroundColor:
                                              //         Colors.white.withOpacity(.5),
                                              //   ),
                                              //   errorWidget:
                                              //       (context, url, error) =>
                                              //           Container(
                                              //     height: size.height * 0.25,
                                              //     width: size.width,
                                              //     // padding: EdgeInsets.symmetric(horizontal: 20),
                                              //     // margin: EdgeInsets.symmetric(horizontal: 20),
                                              //     decoration: BoxDecoration(
                                              //         image: DecorationImage(
                                              //             image: AssetImage(
                                              //                 Images.coming_soon),
                                              //             fit: BoxFit.cover)),
                                              //   ),
                                              // ),
                                              child: roommatesData?[index].photos==null?Container(
                                                height:
                                                Get.height *
                                                    .25,
                                                width:MediaQuery.of(context).size.width/1,
                                                child:
                                                Image.asset(
                                                  'assets/images/room_img.png',
                                                  fit:
                                                  BoxFit.fill,
                                                ),
                                              )
                                                  : Container(
                                                     height:
                                                     Get.height * .25,
                                                     width:Get.width,
                                                    child: Image.network(
                                                      'https://dhoondle.com/Dhoondle/${roommatesData![index].photos}',
                                                       fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                              top: 10,
                                              right: 20,
                                              child: Container(
                                                  padding: EdgeInsets.all(20),
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: AssetImage(
                                                              Images.Frame))),
                                                  // child: Text(
                                                  //     "Rent:${getPropertyList!.propertyList[index]!.price.toString()}"))),
                                                  child: Text("Rent: 9,999"))),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0, vertical: 2.0),
                                        child: Text(
                                          "${roommatesData?[index].name}",
                                          style: GoogleFonts.lato(
                                              color: AppColors.textcolor,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0, vertical: 2.0),
                                        child: Text(
                                          // getPropertyList!
                                          //     .propertyList[index]!.address
                                          //     .toString(),
                                          '${roommatesData?[index].address}',
                                          style: GoogleFonts.lato(
                                              color: AppColors.greycolor,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0, vertical: 2.0),
                                        child: Text(
                                          // getPropertyList!.propertyList[index]!.city
                                          //     .toString(),
                                          '${roommatesData?[index].city}',
                                          style: GoogleFonts.lato(
                                              color: AppColors.greycolor,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0, vertical: 2.0),
                                        child: Text(
                                          // getPropertyList!
                                          //     .propertyList[index]!.description
                                          //     .toString(),
                                          '${roommatesData?[index].localAddress}',
                                          style: GoogleFonts.lato(
                                              color: AppColors.greycolor,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0, vertical: 10),
                                        child: Row(
                                          // mainAxisAlignment:
                                          //     MainAxisAlignment.end,
                                          children: [
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: () => _launchPhoneCall(
                                                    getPropertyList!
                                                        .propertyList[index]
                                                        .mobile
                                                        .toString()),
                                                child: Container(
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                      border: Border.all(
                                                          color: AppColors
                                                              .primaryColor,
                                                          width: 1.0)),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Image.asset(
                                                        Images.Telephone,
                                                        height: 20,
                                                      ),
                                                      SizedBox(
                                                        width: 12.0,
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          _launchPhoneCall(phoneNumber);
                                                        },
                                                        child: Text('Call',
                                                            style: GoogleFonts.lato(
                                                                color: AppColors
                                                                    .primaryColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: 16)),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: Get.width * .05,
                                            ),
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: () => launchWhatsApp(
                                                    getPropertyList!
                                                        .propertyList[index]!
                                                        .mobile
                                                        .toString()),
                                                child: Container(
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                      border: Border.all(
                                                          color: AppColors
                                                              .primaryColor,
                                                          width: 1.0)),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Image.asset(
                                                        Images.Whatsapp,
                                                        height: 20,
                                                      ),
                                                      SizedBox(
                                                        width: 12.0,
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          launchWhatsApp(phoneNumber);
                                                        },
                                                        child: Text('WhatsApp',
                                                            style: GoogleFonts.lato(
                                                                color: AppColors
                                                                    .primaryColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: 16)),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            // InkWell(
                                            //     onTap: () {
                                            //       _launchPhoneCall(
                                            //           getPropertyList!
                                            //               .propertyList[index]!
                                            //               .mobile
                                            //               .toString());
                                            //     },
                                            //     child: Image.asset(
                                            //       Images.Telephone,
                                            //       height: size.height * 0.04,
                                            //     )),
                                            // SizedBox(
                                            //   width: size.width * 0.08,
                                            // ),
                                            // InkWell(
                                            //     onTap: () => {
                                            //           launchWhatsApp(
                                            //               getPropertyList!
                                            //                   .propertyList[
                                            //                       index]!
                                            //                   .mobile
                                            //                   .toString())
                                            //         },
                                            //     child: Image.asset(
                                            //       Images.Whatsapp,
                                            //       height: size.height * 0.04,
                                            //     ))
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                        child: Divider(
                                          thickness: 6,
                                          color: AppColors.home_divider_color,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                  ),
            Positioned(
              child: Align(
                alignment: Alignment.center,
                child: HelperClass.getProgressBar(context, _isVisible),
              ),
            )
          ],
        ));
  }

  _launchPhoneCall(phoneNumber) async {
    // final url = 'tel:$phoneNumber';
    final url = 'tel: 91838232983';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  launchWhatsApp(phoneNumber) async {
    final link = WhatsAppUnilink(
      phoneNumber: '+91 9034459823',
      // phoneNumber: '+91 ${phoneNumber}',
      text: "Hey! I'm inquiring about the apartment listing",
    );
    // Convert the WhatsAppUnilink instance to a string.
    // Use either Dart's string interpolation or the toString() method.
    // The "launch" method is part of "url_launcher".
    await launch('$link');
  }

  setProgress(bool show) {
    if (mounted)
      setState(() {
        _isVisible = show;
      });
  }

  List<RoommatesData>? roommatesData = [];
  Future<void> getRoommates() async {
    print("<=============Roommates=============>");

      final prefs = await SharedPreferences.getInstance();
      var user_id = await prefs.getString('user_id');
      setProgress(true);

    var headers = {
      'Cookie': 'ci_session=k82572jhkqgu80jvlk01685lnb5c1065'
    };
    var request = http.Request('GET', Uri.parse('https://dhoondle.com/Dhoondle/api/roommate/index'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
     var Result  = await response.stream.bytesToString();
     final finalResult = GetRoommatesModel.fromJson(json.decode(Result));
     setState(() {
       roommatesData = finalResult.data;
     });
     setProgress(false);
    }
    else {
      print(response.reasonPhrase);
    }






  }
}

class MultiFab extends StatelessWidget {
  const MultiFab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: const Alignment(-0.75, 1.0),
          child: FloatingActionButton.extended(
            foregroundColor: Colors.white,
            backgroundColor: AppColors.primaryColor,
            icon: const Padding(
              padding: EdgeInsets.only(left: 4.0),
              child: Icon(Icons.update),
            ),
            label: const Padding(
              padding: EdgeInsets.only(right: 4.0),
              child: Text("Update"),
            ),
            onPressed: () => Get.toNamed('/updateroommatesdetail'),
          ),
        ),
        Align(
          alignment: const Alignment(1.0, 1.0),
          child: FloatingActionButton.extended(
              foregroundColor: Colors.white,
              backgroundColor: AppColors.primaryColor,
              icon: const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Icon(
                  Icons.add,
                  size: 22,
                ),
              ),
              label: const Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Text(" Add "),
              ),
              onPressed: () => Get.toNamed('/findroommate')),
        ),
      ],
    );
  }
}
