import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dhoondle/src/features/screens/property_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../api_model/get_service_list_model.dart';
import '../../api_model/mark_active_inactive_model.dart';
import '../../constants/Api.dart';
import '../../constants/colors.dart';
import '../../constants/helper.dart';
import '../../constants/images.dart';
import '../../constants/text.dart';
import '../controllers/common_model.dart';
import '../controllers/get_servicelist_controller.dart';
import 'add_services.dart';
import 'package:http/http.dart' as http;

import 'edit_screen_service.dart';

class ServiceScreenTabbar extends StatefulWidget {
  const ServiceScreenTabbar({Key? key}) : super(key: key);

  @override
  State<ServiceScreenTabbar> createState() => _ServiceScreenTabbarState();
}

class _ServiceScreenTabbarState extends State<ServiceScreenTabbar> {
  GetMyServiceList? getServiceListApi;
  // final deleteController=Get.put(GetServiceListController());
  String service_id = "";
  bool isSwitchOn = false;
  bool _isVisible = false;
  bool _hasData = true;
  CommonModel? commonmodel;
  MarkActiveInactiveModel? markActiveInactiveModel;
  String number = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Helper.checkInternet(getmyservicelist());
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
          getServiceListApi == null
              ? Container(
                  height: 400,
                  child: Center(child: Text("No property found")),
                )
              : Container(
                  height: size.height,
                  width: size.width,
                  child: getServiceListApi!.serviceList!.isEmpty
                      ? Container(
                          height: 400,
                          child: Center(child: Text("No property found")),
                        )
                      : ListView.builder(
                          itemCount: getServiceListApi!.serviceList!.length,
                          itemBuilder: (BuildContext context, int index) {
                            service_id = getServiceListApi!
                                .serviceList![index].id
                                .toString();
                            number = getServiceListApi!
                                .serviceList![index].number
                                .toString();
                            return InkWell(
                              onTap: () => {
                                // Get.to(PropertyDetailsScreen(property_id: serviceController.getServiceListApi!.serviceList!.length.toString(),))
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Color(0xffDADADA)),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle),
                                                child: ClipOval(
                                                    child: CachedNetworkImage(
                                                  imageUrl: getServiceListApi!
                                                      .serviceList![index].image
                                                      .toString(),
                                                  fit: BoxFit.fill,
                                                  width: 90,
                                                  height: 90,
                                                  placeholder: (context, url) =>
                                                      LinearProgressIndicator(
                                                    color: Colors.white
                                                        .withOpacity(0.2),
                                                    backgroundColor: Colors
                                                        .white
                                                        .withOpacity(.5),
                                                  ),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Container(
                                                    width: 80,
                                                    height: 80,
                                                    decoration:
                                                        const BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(20),
                                                      ),
                                                      color: Color(0xFFD9D9D9),
                                                    ),
                                                    child: Center(
                                                        child: Image.asset(
                                                      Images.man,
                                                      height: 100,
                                                      width: 100,
                                                      fit: BoxFit.cover,
                                                    )),
                                                  ),
                                                ))),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Container(
                                              height: size.width * 0.4,
                                              width: size.width * 0.55,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  // Text("John Doe", style: GoogleFonts.lato(
                                                  //     color: Color(0xff4C4C4C),
                                                  //     fontWeight: FontWeight.w500,
                                                  //     fontSize: 18
                                                  // ),),
                                                  Text(
                                                    getServiceListApi!
                                                        .serviceList![index]
                                                        .service
                                                        .toString(),
                                                    style: GoogleFonts.lato(
                                                        color:
                                                            Color(0xff4C4C4C),
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 14),
                                                  ),

                                                  Container(
                                                    child: Text(
                                                      getServiceListApi!
                                                          .serviceList![index]
                                                          .description
                                                          .toString(),
                                                      style: GoogleFonts.lato(
                                                        color:
                                                            Color(0xffA7A7A7),
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 14,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 4,
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Experience:",
                                                        style: GoogleFonts.lato(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 14,
                                                        ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 4,
                                                      ),
                                                      Container(
                                                        child: Text(
                                                          " ${getServiceListApi!.serviceList![index].yearsOfExperience.toString()} years",
                                                          style:
                                                              GoogleFonts.lato(
                                                            color: Color(
                                                                0xffA7A7A7),
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 14,
                                                          ),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 4,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 0.0, vertical: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  // service_id=getServiceListApi!.serviceList![index].id.toString();
                                                  // print("======service-id==========${service_id}");
                                                  // Helper.checkInternet(activeInactive(service_id));
                                                },
                                                child: Container(
                                                  width: 80,
                                                  height: 30,
                                                  child: FlutterSwitch(
                                                    activeTextColor:
                                                        Colors.white,
                                                    activeColor:
                                                        AppColors.primaryColor,
                                                    showOnOff: true,
                                                    activeText: "ON",
                                                    inactiveText: "OFF",
                                                    // activeToggleColor:AppColor.primaryColor ,
                                                    value: (getServiceListApi!
                                                                .serviceList[
                                                                    index]
                                                                .isActive ==
                                                            "1")
                                                        ? false
                                                        : true,
                                                    // value:
                                                    // (getServiceListApi!.serviceList[index].isActive.toString() == 1)?((markActiveInactiveModel!.isActive.toString() == 1)?false:true):true,
                                                    onToggle: (value) {
                                                      // isSwitchOn = value;
                                                      print(
                                                          "index=====${index.toString()}");
                                                      print(
                                                          "service=====${service_id}");
                                                      Helper.checkInternet(
                                                          activeInactive(
                                                              getServiceListApi!
                                                                  .serviceList![
                                                                      index]
                                                                  .id
                                                                  .toString()));

                                                      setState(() {
                                                        // isSwitchOn=(getServiceListApi!.serviceList[index].isActive == "1")?false:true;
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 25,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  Helper.moveToScreenwithPush(
                                                      context,
                                                      EditServiceScreen(
                                                        serviceImage:
                                                            getServiceListApi!
                                                                .serviceList![
                                                                    index]
                                                                .image
                                                                .toString(),
                                                        service_id:
                                                            getServiceListApi!
                                                                .serviceList![
                                                                    index]
                                                                .serviceId
                                                                .toString(),
                                                        service_name:
                                                            getServiceListApi!
                                                                .serviceList![
                                                                    index]
                                                                .service
                                                                .toString(),
                                                        service_des:
                                                            getServiceListApi!
                                                                .serviceList![
                                                                    index]
                                                                .description
                                                                .toString(),
                                                        address:
                                                            getServiceListApi!
                                                                .serviceList![
                                                                    index]
                                                                .address
                                                                .toString(),
                                                        number:
                                                            getServiceListApi!
                                                                .serviceList![
                                                                    index]
                                                                .number
                                                                .toString(),
                                                        serviceCategory:
                                                            getServiceListApi!
                                                                .serviceList![
                                                                    index]
                                                                .id
                                                                .toString(),
                                                        experience:
                                                            getServiceListApi!
                                                                .serviceList![
                                                                    index]
                                                                .yearsOfExperience
                                                                .toString(),
                                                        whichscreen:
                                                            'Edit service',
                                                      ));
                                                },
                                                child: Image.asset(
                                                  Images.pencil,
                                                  height: size.height * 0.03,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 25,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  service_id =
                                                      getServiceListApi!
                                                          .serviceList![index]
                                                          .id
                                                          .toString();
                                                  print(
                                                      "======service-id==========${service_id}");
                                                  showAlertDailog();
                                                },
                                                child: Image.asset(
                                                  Images.bin,
                                                  height: size.height * 0.03,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
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
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: AppColors.primaryColor,
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => AddServiceScreen(
                        service_id: '',
                        service_name: '',
                        service_des: '',
                        number: number,
                        address: '',
                        serviceImage: '',
                        serviceCategory: '',
                        experience: '',
                        whichscreen: 'Add Service',
                      )));
          // Add your action here
          // For example, you can navigate to another screen or perform some action.
          // Navigator.push(context, MaterialPageRoute(builder: (context) => NextScreen()));
        },
        child: Icon(Icons.add), // Add your FAB icon here
      ),
    );
  }

  showAlertDailog() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(),
            content: Container(
              height: 230,
              width: 200,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              //width: MediaQuery.of(context).size.width,
              // decoration: BoxDecoration(
              //    color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: new BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(Images.delete),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Off for sometime ?",
                      style: GoogleFonts.lato(
                          color: Color(0xff4C4C4C),
                          fontWeight: FontWeight.w500,
                          fontSize: 15),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            deleteApi(service_id);
                          },
                          child: Container(
                            height: 40,
                            width: 110,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.PopButtonColor),
                            child: Center(
                                child: Text(
                              "Yes",
                              style: GoogleFonts.lato(
                                  color: AppColors.ButtonTextColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17),

                              // TextStyle(color: Color(0xffFFFFFF)),
                            )),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.PopButtonColor,
                            ),
                            child: Center(
                                child: Text(
                              "No",
                              style: GoogleFonts.lato(
                                  color: AppColors.ButtonTextColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15),

                              //TextStyle(color: Color(0xffFFFFFF)),
                            )),
                            height: 40,
                            width: 110,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  setProgress(bool show) {
    if (mounted)
      setState(() {
        _isVisible = show;
      });
  }

  Future<void> getmyservicelist() async {
    print("<=============getmyservicelist =============>");

    final prefs = await SharedPreferences.getInstance();
    var user_id = await prefs.getString('user_id');

    setProgress(true);
    Map data = {
      'user_id': user_id.toString(),
    };

    print("Request =============>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Api.getMyServiceList), body: data);
      print("Response ============>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          GetMyServiceList model = GetMyServiceList.fromJson(jsonResponse);

          if (model.status == "true") {
            print("Model status true");

            setProgress(false);

            setState(() {
              getServiceListApi = model;
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

  Future<void> deleteApi(String service_id) async {
    print("<=============deleteApi =============>");

    final prefs = await SharedPreferences.getInstance();
    var user_id = await prefs.getString('user_id');

    setProgress(true);
    Map data = {
      'user_id': user_id.toString(),
      'service_id': service_id.toString(),
    };

    print("Request =============>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Api.deleteService), body: data);
      print("Response ============>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          CommonModel model = CommonModel.fromJson(jsonResponse);

          if (model.status == "true") {
            print("Model status true");

            setProgress(false);

            setState(() {
              commonmodel = model;
              Helper.popScreen(context);
              Helper.checkInternet(getmyservicelist());
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

  Future<void> activeInactive(String service_id) async {
    print("<=============activeInactive =============>");

    final prefs = await SharedPreferences.getInstance();
    var user_id = await prefs.getString('user_id');

    setProgress(true);
    Map data = {
      'user_id': user_id.toString(),
      'id': service_id.toString(),
    };

    print("Request =============>" + data.toString());
    try {
      var res =
          await http.post(Uri.parse(Api.markMyserviceInactive), body: data);
      print("Response ============>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          MarkActiveInactiveModel model =
              MarkActiveInactiveModel.fromJson(jsonResponse);

          if (model.status == "true") {
            print("Model status true");

            setProgress(false);

            setState(() {
              markActiveInactiveModel = model;
              // Helper.popScreen(context);
              Helper.checkInternet(getmyservicelist());
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
