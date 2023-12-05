import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import '../../../../constants/images.dart';
import '../../../controllers/service_detail_controller.dart';

class ServiceDetailDesign extends StatelessWidget {
  ServiceDetailDesign({
    Key? key,
  }) : super(key: key);
  final servicedetailController = Get.put(ServiceDetailsController());

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Obx(
          () => servicedetailController.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount:
                      servicedetailController.serviceDetailModel!.data!.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 10),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.2,
                              decoration: BoxDecoration(
                                  // color: Colors.blue,
                                  border: Border.all(color: Colors.black12),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      // color: Colors.red,
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(10),
                                                  ),
                                                  border: Border.all(
                                                      color: Colors.grey)
                                                  // color: Color(0xFFD9D9D9),
                                                  ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    servicedetailController
                                                        .serviceDetailModel!
                                                        .data![index]
                                                        .userDetails!
                                                        .image
                                                        .toString(),
                                                fit: BoxFit.cover,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.28,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.145,
                                                placeholder: (context, url) =>
                                                    LinearProgressIndicator(
                                                  color: Colors.white
                                                      .withOpacity(0.2),
                                                  backgroundColor: Colors.white
                                                      .withOpacity(.5),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.2,
                                                  height: 100,
                                                  // decoration:  BoxDecoration(
                                                  //   borderRadius: BorderRadius.all(
                                                  //     Radius.circular(10),
                                                  //   ),
                                                  //   border: Border.all(color: Colors.grey)
                                                  //   // color: Color(0xFFD9D9D9),
                                                  // ),
                                                  child: Center(
                                                      child: ClipOval(
                                                    child: Image.asset(
                                                      Images.man,
                                                      height: 80,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.2,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  )),
                                                ),
                                              ),
                                            ),
                                          ),

                                          // Image.asset(ProjectImage.profile,height: 102,width: 120,),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      // color: Colors.black,
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.4,
                                            child: Text(
                                                servicedetailController
                                                    .serviceDetailModel!
                                                    .data![index]
                                                    .userDetails!
                                                    .name
                                                    .toString(),
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.lato(
                                                  textStyle: TextStyle(
                                                      color: Color(0xff4C4C4C),
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                          Row(
                                            children: [
                                              Text("Experience:",
                                                  style: GoogleFonts.lato(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color:
                                                          Color(0xff4C4C4C))),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.15,
                                                child: Text(
                                                    " ${servicedetailController.serviceDetailModel!.data![index].yearsOfExperience.toString()} years",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.lato(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.black)),
                                              ),
                                            ],
                                          ),
                                          // SizedBox(
                                          //   height: 0,
                                          // ),
                                          Text(
                                              servicedetailController
                                                  .serviceDetailModel!
                                                  .data![index]
                                                  .service
                                                  .toString(),
                                              style: GoogleFonts.lato(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0xff4C4C4C))),

                                          Container(
                                            width: 120,
                                            child: Text(
                                                servicedetailController
                                                    .serviceDetailModel!
                                                    .data![index]
                                                    .description
                                                    .toString(),
                                                overflow: TextOverflow.clip,
                                                maxLines: 3,
                                                style: GoogleFonts.lato(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w300,
                                                    color: Color(0xff4C4C4C))),
                                          ),

                                          // Row(
                                          //   children: [
                                          //     FlutterRating(
                                          //       rating: double.parse(servicedetailController.serviceDetailModel!.data![index].rating.toString()??"0"),
                                          //       starCount: 5,
                                          //       borderColor: Colors.yellow,
                                          //       color: Color(0xffFFC121),
                                          //       allowHalfRating: true,
                                          //       size: 20,
                                          //       mainAxisAlignment:
                                          //       MainAxisAlignment.center,
                                          //       onRatingChanged: (rating) {
                                          //         print(rating);
                                          //       },
                                          //     ),
                                          //     SizedBox(width: 5,),
                                          //
                                          //     // RatingBar.builder(
                                          //     //   unratedColor: ,
                                          //     //   initialRating: 4,
                                          //     //   minRating: 1,
                                          //     //   direction: Axis.horizontal,
                                          //     //   allowHalfRating: true,
                                          //     //   itemCount: 5, itemSize: MediaQuery.of(context).size.height*0.03,
                                          //     //   itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                                          //     //   itemBuilder: (context, _) => Icon(
                                          //     //     Icons.star,
                                          //     //     size: 10,
                                          //     //     color: Color(0xffFFC121),
                                          //     //   ),
                                          //     //   onRatingUpdate: (rating) {
                                          //     //     print(rating);
                                          //     //   },
                                          //     // ),
                                          //     //  Image.asset(ProjectImage.star),
                                          //     Text(
                                          //       servicedetailController.serviceDetailModel!.data![index].rating.toString(),
                                          //       style: GoogleFonts.lato(
                                          //           color: Color(0xff4E4E4E),
                                          //           fontWeight: FontWeight.w700,
                                          //           fontSize: 13),
                                          //     )
                                          //   ],
                                          // ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15.0, horizontal: 0),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.15,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                _launchPhoneCall(
                                                    servicedetailController
                                                        .serviceDetailModel!
                                                        .data![index]
                                                        .number
                                                        .toString());
                                              },
                                              child: Image.asset(
                                                Images.Telephone,
                                                height: 32,
                                                width: 32,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            InkWell(
                                              onTap: () => {
                                                launchWhatsApp(
                                                    servicedetailController
                                                        .serviceDetailModel!
                                                        .data![index]
                                                        .number
                                                        .toString())
                                              },
                                              child: Image.asset(
                                                Images.Whatsapp,
                                                height: 32,
                                                width: 32,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
        ));
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
}
