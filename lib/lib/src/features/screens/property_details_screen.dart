import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import '../../api_model/get_property_details_model.dart';
import '../../constants/Api.dart';
import '../../constants/colors.dart';
import '../../constants/helper.dart';
import '../../constants/images.dart';
import '../../constants/text.dart';
import 'package:http/http.dart' as http;

class PropertyDetailsScreen extends StatefulWidget {
  String property_id = "";
  PropertyDetailsScreen({required this.property_id});

  @override
  State<PropertyDetailsScreen> createState() => _PropertyDetailsScreenState();
}

class _PropertyDetailsScreenState extends State<PropertyDetailsScreen> {
  List imgURL = [
    Images.flat,
    Images.flat,
    Images.flat,
  ];
  int currentIndex = 0;
  List<String> images = <String>[
    "https://images.unsplash.com/photo-1458071103673-6a6e4c4a3413?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80",
    "https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=400&q=80",
    "https://images.unsplash.com/photo-1470406852800-b97e5d92e2aa?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80",
    "https://images.unsplash.com/photo-1473700216830-7e08d47f858e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80"
  ];
  CarouselController carouselController = CarouselController();
  bool _isVisible = false;
  bool _hasData = true;
  String isSelect = "";
  GetPropertyDetailModel? getPropertyDetailModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Helper.checkInternet(propertydetail());
  }

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
        title: Text(TextScreen.Home,
            style: GoogleFonts.lato(
              textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            )),
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.all(25),
        //     child: Image.asset(Images.search,),
        //   ),
        // ],
      ),
      // appBar:AppBar(
      //   backgroundColor: AppColors.primaryColor,
      //   leading: Padding(
      //     padding: const EdgeInsets.all(10.0),
      //     child: Image.asset(Images.logo),
      //   ),
      //   centerTitle: true,
      //   elevation: 0,
      //   title: Text(TextScreen.Home),
      //   actions: [
      //     Padding(
      //       padding: const EdgeInsets.all(15.0),
      //       child: Image.asset(Images.search,height:size.height*0.1 ,),
      //     ),
      //   ],
      // ) ,
      body: Stack(
        children: [
          getPropertyDetailModel != null
              // getPropertyDetailModel == null
              ? Container(
                  height: size.height,
                  width: size.width,
                  child: Center(child: Text("No data found")),
                )
              : Container(
                  height: size.height,
                  width: size.width,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        // getPropertyDetailModel!.propertyImage!.isEmpty
                        //     ? Container(
                        //         height: size.height * 0.25,
                        //         width: size.width,
                        //         // padding: EdgeInsets.symmetric(horizontal: 20),
                        //         // margin: EdgeInsets.symmetric(horizontal: 20),
                        //         decoration: BoxDecoration(
                        //             image: DecorationImage(
                        //                 image: AssetImage(Images.coming_soon),
                        //                 fit: BoxFit.cover)),
                        //       )
                        //     :
                        CarouselSlider.builder(
                          carouselController: carouselController,
                          itemCount: 3,
                          // itemCount: getPropertyDetailModel!
                          //     .propertyImage!.length,
                          itemBuilder:
                              (BuildContext context, int index, int itemIndex) {
                            return Center(
                                child: Stack(
                              children: [
                                Container(
                                  height: size.height * 0.28,
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    // boxShadow: [
                                    //   BoxShadow(
                                    //     color: Colors.grey.withOpacity(0.2),
                                    //     spreadRadius: 2,
                                    //     blurRadius: 2,
                                    //     offset: Offset(0, 1), // changes position of shadow
                                    //   ),
                                    // ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    // child: CachedNetworkImage(
                                    //   imageUrl: getPropertyDetailModel!
                                    //       .propertyImage![index].image
                                    //       .toString(),
                                    //   fit: BoxFit.fill,
                                    //   height: size.height * 0.25,
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
                                    child: Container(
                                      height: size.height * 0.25,
                                      width: size.width,
                                      // padding: EdgeInsets.symmetric(horizontal: 20),
                                      // margin: EdgeInsets.symmetric(horizontal: 20),
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  Images.coming_soon),
                                              fit: BoxFit.cover)),
                                    ),
                                  ),
                                ),
                                Positioned(
                                    top: 40,
                                    right: 10,
                                    child: Container(
                                        padding: EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image:
                                                    AssetImage(Images.Frame))),
                                        child: Text("Rent: 9,999"))),
                                // "Rent:${getPropertyDetailModel!.propertyDetails!.price.toString()}"))),
                              ],
                            ));
                          },
                          options: CarouselOptions(
                              height: 250,
                              autoPlay: false,
                              viewportFraction: 1,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  currentIndex = index;
                                  // projectId = _homeModel!.projectData![index].projectId.toString();
                                  // print("projectId========================${projectId.toString()}");
                                });
                              }),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        // getPropertyDetailModel!.propertyImage!.isEmpty
                        //     ? Container()
                        //     :
                        AnimatedSmoothIndicator(
                          activeIndex: currentIndex,
                          count: 3,
                          // count: getPropertyDetailModel!
                          //     .propertyImage!.length,
                          effect: SlideEffect(
                              dotWidth: 12,
                              dotHeight: 12,
                              activeDotColor: AppColors.textcolor,
                              dotColor: AppColors.greycolor),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text(
                                "Room available for rent",
                                // "${getPropertyDetailModel!.propertyDetails!.category.toString()} available for rent",
                                style: GoogleFonts.lato(
                                    color: AppColors.textcolor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 20),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      // _launchPhoneCall(getPropertyDetailModel!
                                      //     .propertyDetails!.mobile
                                      //     .toString());
                                    },
                                    child: Image.asset(
                                      Images.Telephone,
                                      height: size.height * 0.03,
                                    ),
                                  ),
                                  SizedBox(
                                    width: size.width * 0.05,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      // launchWhatsApp(getPropertyDetailModel!
                                      //     .propertyDetails!.mobile
                                      //     .toString());
                                    },
                                    child: Image.asset(
                                      Images.Whatsapp,
                                      height: size.height * 0.03,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10),
                              child: Text(
                                TextScreen.Description,
                                style: GoogleFonts.lato(
                                    color: AppColors.textcolor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text(
                                // getPropertyDetailModel!
                                //     .propertyDetails!.description
                                //     .toString(),
                                "Good Location Near Bus Stop",
                                style: GoogleFonts.lato(
                                    color: AppColors.greycolor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10),
                              child: Divider(
                                thickness: 1,
                                color: AppColors.greycolordark,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10),
                              child: Text(
                                TextScreen.rent,
                                style: GoogleFonts.lato(
                                    color: AppColors.textcolor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text(
                                "/9999 Rs/Month",
                                // "${getPropertyDetailModel!.propertyDetails!.price.toString()}Rs/Month",
                                style: GoogleFonts.lato(
                                    color: AppColors.greycolor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10),
                              child: Text(
                                TextScreen.Address,
                                style: GoogleFonts.lato(
                                    color: AppColors.textcolor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text(
                                // getPropertyDetailModel!.propertyDetails!.address
                                //     .toString(),
                                "123, Jail Road , Indore",
                                style: GoogleFonts.lato(
                                    color: AppColors.greycolor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10),
                              child: Text(
                                TextScreen.city,
                                style: GoogleFonts.lato(
                                    color: AppColors.textcolor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text(
                                // getPropertyDetailModel!.propertyDetails!.city
                                //     .toString(),
                                'Indore',
                                style: GoogleFonts.lato(
                                    color: AppColors.greycolor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10),
                              child: Text(
                                TextScreen.room,
                                style: GoogleFonts.lato(
                                    color: AppColors.textcolor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text(
                                // getPropertyDetailModel!
                                //     .propertyDetails!.roomtype
                                //     .toString(),
                                'Student',
                                style: GoogleFonts.lato(
                                    color: AppColors.greycolor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10),
                              child: Text(
                                TextScreen.owner_name,
                                style: GoogleFonts.lato(
                                    color: AppColors.textcolor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text(
                                // getPropertyDetailModel!
                                //     .propertyDetails!.postedBy
                                //     .toString(),
                                'Jo Jogender',
                                style: GoogleFonts.lato(
                                    color: AppColors.greycolor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14),
                              ),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.symmetric(
                            //       horizontal: 20.0, vertical: 10),
                            //   child: Text(
                            //     getPropertyDetailModel!.propertyDetails!.postedBy.toString(),
                            //     style: GoogleFonts.lato(
                            //         color: AppColors.textcolor,
                            //         fontWeight: FontWeight.w500,
                            //         fontSize: 16),
                            //   ),
                            // ),

                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10),
                              child: Text(
                                TextScreen.facilities,
                                style: GoogleFonts.lato(
                                    color: AppColors.textcolor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 5),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 58,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: 2,
                                    // itemCount: getPropertyDetailModel!
                                    //     .propertyFacility!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Stack(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(right: 10),
                                            // width: MediaQuery.of(context).size.width/2.5,
                                            width: 220,
                                            height: 58,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 22, vertical: 18),
                                            decoration: BoxDecoration(
                                              color: AppColors.primaryColor,
                                              border: Border.all(
                                                  color: AppColors
                                                      .addpropertyfillclr,
                                                  width: 1),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Center(
                                              child: Text(
                                                  // getPropertyDetailModel!
                                                  //     .propertyFacility![index]
                                                  //     .facility
                                                  //     .toString(),
                                                  'Water',
                                                  style: GoogleFonts.lato(
                                                    textStyle: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                    ),
                                                  )),
                                            ),
                                          ),
                                          // Positioned(
                                          //     top: 0,
                                          //     right: 0,
                                          //     child: InkWell(
                                          //         onTap: (){
                                          //           setState(() {
                                          //             print(getPropertyDetailModel!.propertyFacility![index].length);
                                          //             facilitiesList.removeAt(index);
                                          //             print(facilitiesList.length);
                                          //           });
                                          //         },
                                          //         child: Image.asset(Images.cross,height: 24,width: 24,))),
                                        ],
                                      );
                                    }),
                              ),
                            ),

                            // Padding(
                            //   padding: const EdgeInsets.symmetric(
                            //       horizontal: 20.0, vertical: 5),
                            //   child: Container(
                            //     // height: 500,
                            //     width: size.width,
                            //     child: GridView.builder(
                            //       shrinkWrap: true,
                            //         physics: NeverScrollableScrollPhysics(),
                            //         gridDelegate:  SliverGridDelegateWithMaxCrossAxisExtent(
                            //             maxCrossAxisExtent: 200,
                            //             childAspectRatio: 2 / 1,
                            //             crossAxisSpacing: 20,
                            //             mainAxisSpacing: 20),
                            //         itemCount: getPropertyDetailModel!.propertyFacility!.length,
                            //         itemBuilder: (BuildContext ctx, index) {
                            //           return Container(
                            //             height: 20,
                            //             width: 120,
                            //             alignment: Alignment.center,
                            //             decoration: BoxDecoration(
                            //                 color: Colors.amber,
                            //                 borderRadius: BorderRadius.circular(15)),
                            //             child:    Container(
                            //               decoration: BoxDecoration(
                            //                   color: Color(0xffF46060),
                            //                   borderRadius: BorderRadius.circular(15)
                            //               ),
                            //               child:  Center(
                            //                 child: Text(
                            //                   getPropertyDetailModel!.propertyFacility![index].facility.toString(),
                            //                   style: GoogleFonts.lato(
                            //                       color: Colors.white,
                            //                       fontWeight: FontWeight.w500,
                            //                       fontSize: 16),
                            //                 ),
                            //               ),
                            //             ),
                            //           );
                            //         }),
                            //   ),
                            // ),
                            SizedBox(
                              height: size.height * 0.1,
                            )
                          ],
                        )

                        // Stack(
                        //   children: [
                        //     Container(
                        //       height: size.height*0.3,
                        //       padding: EdgeInsets.symmetric(horizontal: 20),
                        //       margin: EdgeInsets.symmetric(horizontal: 20),
                        //       decoration: BoxDecoration(
                        //           image: DecorationImage(
                        //               image: AssetImage(Images.flat)
                        //           )
                        //       ),
                        //
                        //     ),
                        //     Positioned(
                        //         top: 40,
                        //         right: 20,
                        //         child: Image.asset(Images.Frame)),
                        //
                        //
                        //
                        //   ],
                        // ),

                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        //   child: Divider(
                        //     thickness: 6,
                        //     color:AppColors.home_divider_color,
                        //   ),
                        // )
                      ],
                    ),
                  )),
          Positioned(
            child: Align(
              alignment: Alignment.center,
              child: HelperClass.getProgressBar(context, _isVisible),
            ),
          )
        ],
      ),
    );
  }

  _launchPhoneCall(String phoneNumber) async {
    final url = 'tel:+91 $phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  launchWhatsApp(String phoneNumber) async {
    final link = WhatsAppUnilink(
      phoneNumber: '+91 ${phoneNumber}',
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

  Future<void> propertydetail() async {
    print("<=============propertydetail =============>");

    final prefs = await SharedPreferences.getInstance();
    var user_id = await prefs.getString('user_id');

    setProgress(true);
    Map data = {
      'user_id': user_id.toString(),
      'property_id': widget.property_id
    };

    print("Request =============>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Api.getPropertyDetails), body: data);
      print("Response ============>" + res.body);

      if (res.statusCode == 200) {
        print("urvashi ============>");
        try {
          final jsonResponse = jsonDecode(res.body);
          GetPropertyDetailModel model =
              GetPropertyDetailModel.fromJson(jsonResponse);

          if (model.status == "true") {
            print("Model status true");

            setProgress(false);

            setState(() {
              getPropertyDetailModel = model;
            });

            // ToastMessage.msg(model.message.toString());
          } else {
            setState(() {
              _hasData = false;
            });
            setProgress(false);
            print("false ### ============>");
            ToastMessage.msg(model.message.toString());
          }
        } catch (e) {
          _hasData = false;
          print("false ============>");
          ToastMessage.msg(StaticMessages.API_ERROR);
          print('exception ==> ' + e.toString());
        }
      } else {
        print("status code ==> " + res.statusCode.toString());
        ToastMessage.msg(StaticMessages.API_ERROR);
      }
    } catch (e) {
      _hasData = false;
      ToastMessage.msg(StaticMessages.API_ERROR);
      print('Exception ======> ' + e.toString());
    }
    setProgress(false);
  }
}
