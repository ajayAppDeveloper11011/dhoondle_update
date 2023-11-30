import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
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
import '../../api_model/get_property_model.dart';
import '../../constants/Api.dart';
import '../../constants/colors.dart';
import '../../constants/helper.dart';
import '../../constants/images.dart';
import '../../constants/text.dart';
import '../controllers/api_controller.dart';
import '../controllers/home_controller_property_list.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  String category = "";
  HomeScreen({required this.category});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final dio = Dio();
  GetPropertyList? getPropertyList;
  var isLoading = true.obs;
  bool _isVisible = false;
  bool _hasData = true;
  // ApiController controller = Get.put(ApiController());
  // HomePropertyController homePropertyController = Get.put(HomePropertyController());
  void initState() {
    // TODO: implement initState
    super.initState();
    Helper.checkInternet(homeApi(widget.category));
    // controller.getpropertyapi();
    // homePropertyController.homeApi(widget.category);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
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
        getPropertyList == null
            ? Container(
                height: 400,
                child: Center(child: Text("No property found")),
              )
            : Container(
                height: size.height,
                width: size.width,
                child: getPropertyList!.propertyList.isEmpty
                    ? Container(
                        height: 400,
                        child: Center(child: Text("No property found")),
                      )
                    : ListView.builder(
                        itemCount: getPropertyList!.propertyList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () => {
                              Get.to(PropertyDetailsScreen(
                                property_id: getPropertyList!
                                    .propertyList[index]!.propertyId
                                    .toString(),
                              ))
                              // Get.to(PropertyDetailsScreen())
                              // Get.toNamed('/propertydetail')
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0.0, vertical: 0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0, vertical: 10),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: CachedNetworkImage(
                                            imageUrl: getPropertyList!
                                                .propertyList[index]!.image
                                                .toString(),
                                            fit: BoxFit.fill,
                                            height: size.height * 0.25,
                                            width: size.width,
                                            placeholder: (context, url) =>
                                                LinearProgressIndicator(
                                              color:
                                                  Colors.white.withOpacity(0.2),
                                              backgroundColor:
                                                  Colors.white.withOpacity(.5),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Container(
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
                                      ),
                                      Positioned(
                                          top: 40,
                                          right: 20,
                                          child: Container(
                                              padding: EdgeInsets.all(20),
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          Images.Frame))),
                                              child: Text(
                                                  "Rent:${getPropertyList!.propertyList[index]!.price.toString()}"))),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Text(
                                      "${getPropertyList!.propertyList![index].category.toString()} available for rent",
                                      style: GoogleFonts.lato(
                                          color: AppColors.textcolor,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Text(
                                      getPropertyList!
                                          .propertyList[index]!.address
                                          .toString(),
                                      style: GoogleFonts.lato(
                                          color: AppColors.greycolor,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Text(
                                      getPropertyList!.propertyList[index]!.city
                                          .toString(),
                                      style: GoogleFonts.lato(
                                          color: AppColors.greycolor,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Text(
                                      getPropertyList!
                                          .propertyList[index]!.description
                                          .toString(),
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
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              _launchPhoneCall(getPropertyList!
                                                  .propertyList[index]!.mobile
                                                  .toString());
                                            },
                                            child: Image.asset(
                                              Images.Telephone,
                                              height: size.height * 0.04,
                                            )),
                                        SizedBox(
                                          width: size.width * 0.08,
                                        ),
                                        InkWell(
                                            onTap: () => {
                                                  launchWhatsApp(
                                                      getPropertyList!
                                                          .propertyList[index]!
                                                          .mobile
                                                          .toString())
                                                },
                                            child: Image.asset(
                                              Images.Whatsapp,
                                              height: size.height * 0.04,
                                            ))
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

  _launchPhoneCall(String phoneNumber) async {
    final url = 'tel:$phoneNumber';
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

  Future<void> homeApi(String category) async {
    print("<=============homeApi =============>");

    final prefs = await SharedPreferences.getInstance();
    var user_id = await prefs.getString('user_id');

    setProgress(true);
    Map data = {'user_id': user_id.toString(), 'category': category.toString()};

    print("Request =============>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Api.getPropertyList), body: data);
      print("Response ============>" + res.body);

      if (res.statusCode == 200) {
        print("jaydeep ============>");
        try {
          final jsonResponse = jsonDecode(res.body);
          GetPropertyList model = GetPropertyList.fromJson(jsonResponse);

          if (model.status == "true") {
            print("Model status true");

            setProgress(false);

            setState(() {
              getPropertyList = model;
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
