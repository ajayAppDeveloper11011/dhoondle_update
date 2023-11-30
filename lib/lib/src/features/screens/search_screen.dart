import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dhoondle/lib/src/features/screens/property_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import '../../api_model/get_property_list_model.dart';
import '../../constants/Api.dart';
import '../../constants/colors.dart';
import '../../constants/helper.dart';
import '../../constants/images.dart';
import '../../constants/text.dart';
import 'package:http/http.dart' as http;

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  GetPropertyList? getPropertyList;
  var isLoading = true.obs;
  bool _isVisible = false;
  bool _hasData = false;

  bool _isSearch = false;
  List<Map<String, dynamic>> _foundUsers = [];
  List<Map<String, dynamic>> results = [];
  List<Map<String, dynamic>> locationList = [];
  final myNumbers = [1, 2, 3, 3, 4, 5, 1, 1];
  int a = 0;
  double value = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Helper.checkInternet(getPropertyListApi());
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
        title: Text(TextScreen.search,
            style: GoogleFonts.lato(
              textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            )),
      ),
      body: Stack(
        children: [
          getPropertyList == null
              ? Container(
                  child: Center(
                    child: Text(
                      "No Data Found",
                      style: GoogleFonts.lato(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 18),
                    ),
                  ),
                )
              : Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: Column(
                    children: [
                      TextField(
                        // controller: MobileController,
                        //obscureText: true,
                        onChanged: (value) => _runFilter(value),
                        decoration: InputDecoration(
                          // fillColor: AppColors.addpropertyfillclr,
                          fillColor: Color(0xffEAEDF2),
                          filled: true,
                          hintText: "Search",
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 22, vertical: 18),
                          hintStyle: GoogleFonts.lato(
                              color: AppColors.txtgreyclr, fontSize: 15),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                                width: 1, color: AppColors.addpropertyfillclr),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                                width: 1, color: AppColors.addpropertyfillclr),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                                width: 1, color: AppColors.addpropertyfillclr),
                          ),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                width: 1,
                              )),
                          errorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  width: 1,
                                  color: AppColors.addpropertyfillclr)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  width: 1,
                                  color: AppColors.addpropertyfillclr)),
                          // border: OutlineInputBorder(
                          //     borderRadius: BorderRadius.circular(20),
                          //     borderSide: new BorderSide(color: Color(0xffBFBFBF))
                          // )
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      _isSearch == true
                          ? results.length == 0
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.23,
                                    ),
                                    Center(
                                      child: Container(
                                        child: Text(
                                          "No Data Found",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : Expanded(
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: results.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return InkWell(
                                          onTap: () => {
                                            /*      Get.to(PropertyDetailsScreen(
                            property_id:getPropertyList!.propertyList[index].propertyId.toString(),))  */

                                            Get.to(PropertyDetailsScreen(
                                              property_id: results[index]
                                                      ['property_id']
                                                  .toString(),
                                            ))

                                            // Get.to(PropertyDetailsScreen())
                                            // Get.toNamed('/propertydetail')
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 0.0, vertical: 0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Stack(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 20.0,
                                                          vertical: 10),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl:
                                                              results[index]
                                                                  ["image"],
                                                          // getPropertyList!.propertyList[index].image.toString(),
                                                          fit: BoxFit.fill,
                                                          height: size.height *
                                                              0.25,
                                                          width: size.width,
                                                          placeholder: (context,
                                                                  url) =>
                                                              LinearProgressIndicator(
                                                            color: Colors.white
                                                                .withOpacity(
                                                                    0.2),
                                                            backgroundColor:
                                                                Colors.white
                                                                    .withOpacity(
                                                                        .5),
                                                          ),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Container(
                                                            height:
                                                                size.height *
                                                                    0.25,
                                                            width: size.width,
                                                            // padding: EdgeInsets.symmetric(horizontal: 20),
                                                            // margin: EdgeInsets.symmetric(horizontal: 20),
                                                            decoration: BoxDecoration(
                                                                image: DecorationImage(
                                                                    image: AssetImage(
                                                                        Images
                                                                            .coming_soon),
                                                                    fit: BoxFit
                                                                        .cover)),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Positioned(
                                                        top: 40,
                                                        right: 20,
                                                        child: Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    20),
                                                            decoration: BoxDecoration(
                                                                image: DecorationImage(
                                                                    image: AssetImage(
                                                                        Images
                                                                            .Frame))),
                                                            child: Text(
                                                                "Rent:${results[index]['price']}"))),
                                                  ],
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 20.0),
                                                  child: Text(
                                                    // results[index]["image"],
                                                    results[index]["category"]
                                                        .toString(),
                                                    // "${getPropertyList!.propertyList[index].category.toString()} available for rent",
                                                    style: GoogleFonts.lato(
                                                        color:
                                                            AppColors.textcolor,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 20.0),
                                                  child: Text(
                                                    results[index]["address"],
                                                    // getPropertyList!.propertyList[index].address.toString(),
                                                    style: GoogleFonts.lato(
                                                        color:
                                                            AppColors.greycolor,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 14),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 20.0),
                                                  child: Text(
                                                    results[index]["city"],
                                                    // getPropertyList!.propertyList[index].city.toString(),
                                                    style: GoogleFonts.lato(
                                                        color:
                                                            AppColors.greycolor,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 14),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 20.0,
                                                      vertical: 10),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      InkWell(
                                                          onTap: () {
                                                            _launchPhoneCall(
                                                                results[index][
                                                                    'mobileNumber']);
                                                            // getPropertyList!.propertyList[index].mobile.toString());
                                                          },
                                                          child: Image.asset(
                                                            Images.Telephone,
                                                            height:
                                                                size.height *
                                                                    0.04,
                                                          )),
                                                      SizedBox(
                                                        width:
                                                            size.width * 0.08,
                                                      ),
                                                      InkWell(
                                                          onTap: () => {
                                                                launchWhatsApp(
                                                                    results[index]
                                                                        [
                                                                        'mobileNumber'])
                                                              },
                                                          child: Image.asset(
                                                            Images.Whatsapp,
                                                            height:
                                                                size.height *
                                                                    0.04,
                                                          ))
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 20.0),
                                                  child: Divider(
                                                    thickness: 6,
                                                    color: AppColors
                                                        .home_divider_color,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                )
                          : Expanded(
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount:
                                      getPropertyList!.propertyList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return InkWell(
                                      onTap: () => {
                                        Get.to(PropertyDetailsScreen(
                                          property_id: getPropertyList!
                                              .propertyList[index].propertyId
                                              .toString(),
                                        ))
                                        // Get.to(PropertyDetailsScreen())
                                        // Get.toNamed('/propertydetail')
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 0.0, vertical: 0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Stack(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 20.0,
                                                      vertical: 10),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    child: CachedNetworkImage(
                                                      imageUrl: getPropertyList!
                                                          .propertyList[index]
                                                          .image
                                                          .toString(),
                                                      fit: BoxFit.fill,
                                                      height:
                                                          size.height * 0.25,
                                                      width: size.width,
                                                      placeholder: (context,
                                                              url) =>
                                                          LinearProgressIndicator(
                                                        color: Colors.white
                                                            .withOpacity(0.2),
                                                        backgroundColor: Colors
                                                            .white
                                                            .withOpacity(.5),
                                                      ),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Container(
                                                        height:
                                                            size.height * 0.25,
                                                        width: size.width,
                                                        // padding: EdgeInsets.symmetric(horizontal: 20),
                                                        // margin: EdgeInsets.symmetric(horizontal: 20),
                                                        decoration: BoxDecoration(
                                                            image: DecorationImage(
                                                                image: AssetImage(
                                                                    Images
                                                                        .coming_soon),
                                                                fit: BoxFit
                                                                    .cover)),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                    top: 40,
                                                    right: 20,
                                                    child: Container(
                                                        padding:
                                                            EdgeInsets.all(20),
                                                        decoration: BoxDecoration(
                                                            image: DecorationImage(
                                                                image: AssetImage(
                                                                    Images
                                                                        .Frame))),
                                                        child: Text(
                                                            "Rent:${getPropertyList!.propertyList[index].price.toString()}"))),
                                              ],
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20.0),
                                              child: Text(
                                                "${getPropertyList!.propertyList[index].category.toString()} available for rent",
                                                style: GoogleFonts.lato(
                                                    color: AppColors.textcolor,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 16),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20.0),
                                              child: Text(
                                                getPropertyList!
                                                    .propertyList[index].address
                                                    .toString(),
                                                style: GoogleFonts.lato(
                                                    color: AppColors.greycolor,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20.0),
                                              child: Text(
                                                getPropertyList!
                                                    .propertyList[index].city
                                                    .toString(),
                                                style: GoogleFonts.lato(
                                                    color: AppColors.greycolor,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20.0,
                                                      vertical: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  InkWell(
                                                      onTap: () {
                                                        _launchPhoneCall(
                                                            getPropertyList!
                                                                .propertyList[
                                                                    index]
                                                                .mobile
                                                                .toString());
                                                      },
                                                      child: Image.asset(
                                                        Images.Telephone,
                                                        height:
                                                            size.height * 0.04,
                                                      )),
                                                  SizedBox(
                                                    width: size.width * 0.08,
                                                  ),
                                                  InkWell(
                                                      onTap: () => {
                                                            launchWhatsApp(
                                                                getPropertyList!
                                                                    .propertyList[
                                                                        index]
                                                                    .mobile
                                                                    .toString())
                                                          },
                                                      child: Image.asset(
                                                        Images.Whatsapp,
                                                        height:
                                                            size.height * 0.04,
                                                      ))
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20.0),
                                              child: Divider(
                                                thickness: 6,
                                                color: AppColors
                                                    .home_divider_color,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                    ],
                  ),
                ),
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

  setProgress(bool show) {
    if (mounted)
      setState(() {
        _isVisible = show;
      });
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

  Future<void> getPropertyListApi() async {
    print("<=============getPropertyListApi =============>");

    final prefs = await SharedPreferences.getInstance();
    var user_id = await prefs.getString('user_id');

    setProgress(true);
    Map data = {'user_id': user_id, 'category': ""};

    print("Request =============>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Api.getPropertyList), body: data);
      print("Response ============>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          GetPropertyList model = GetPropertyList.fromJson(jsonResponse);

          if (model.status == "true") {
            print("Model status true");

            setProgress(false);

            setState(() {
              getPropertyList = model;

              int i = 0;
              locationList.clear();
              for (var i = 0; i < getPropertyList!.propertyList.length; i++) {
                locationList.add({
                  "category": getPropertyList!.propertyList[i].category,
                  "image": getPropertyList!.propertyList[i].image,
                  "price": getPropertyList!.propertyList[i].price,
                  "city": getPropertyList!.propertyList[i].city,
                  "address": getPropertyList!.propertyList[i].address,
                  "mobileNumber": getPropertyList!.propertyList[i].mobile,
                  "property_id": getPropertyList!.propertyList[i].propertyId,
                });
                print("locationList=========${locationList.toString()}");
              }
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

  void _runFilter(String enteredKeyword) {
    print("------------------------_runFilter----------------------");
    if (enteredKeyword.isEmpty) {
      _isSearch = false;
    } else {
      _isSearch = true;
      results = locationList
          .where((user) => user["category"]
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    // Refresh the UI
    setState(() {
      _foundUsers = results;
      a = 250 - 50 * _foundUsers.length;
      value = a + 0.0;
      print(value);
      List re = Set.of(myNumbers).toList();
      print(re);
    });
    print("---------_foundUsers--------------------${_foundUsers}");
    print("---------results--------------------${results}");
  }
}
