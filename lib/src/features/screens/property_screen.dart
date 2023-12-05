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
import '../../api_model/get_my_property_list_model.dart';
import '../../api_model/markproperty_activeinactive.dart';
import '../../constants/Api.dart';
import '../../constants/colors.dart';
import '../../constants/helper.dart';
import '../../constants/images.dart';
import '../controllers/common_model.dart';
import 'add_property.dart';
import 'package:http/http.dart' as http;

import 'edit_property_screen.dart';

class PropertyScreen extends StatefulWidget {
  const PropertyScreen({Key? key}) : super(key: key);

  @override
  State<PropertyScreen> createState() => _PropertyScreenState();
}

class _PropertyScreenState extends State<PropertyScreen> {
  GetMyPropertyList? _getMyPropertyList;
  String property_id = "";
  CommonModel? commonmodel;
  bool _isVisible = false;
  bool _hasData = true;
  bool isSwitchOn = false;
  ActiveInactivePropertyModel? _activeInactivePropertyModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Helper.checkInternet(getmypropertylistApi());
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
          _getMyPropertyList == null
              ? Container(
                  height: 400,
                  child: Center(child: Text("No property found")),
                )
              : Container(
                  height: size.height,
                  width: size.width,
                  child: _getMyPropertyList!.propertyList!.isEmpty
                      ? Container(
                          height: 400,
                          child: Center(child: Text("No property found")),
                        )
                      : Container(
                          height: size.height,
                          width: size.width,
                          child: ListView.builder(
                              itemCount:
                                  _getMyPropertyList!.propertyList!.length,
                              itemBuilder: (BuildContext context, int index) {
                                property_id = _getMyPropertyList!
                                    .propertyList![index].propertyId
                                    .toString();
                                return InkWell(
                                  onTap: () => {
                                    Get.to(PropertyDetailsScreen(
                                      property_id: _getMyPropertyList!
                                          .propertyList![index].propertyId
                                          .toString(),
                                    ))
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 20),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Color(0xffDADADA)),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Stack(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        _getMyPropertyList!
                                                            .propertyList![
                                                                index]!
                                                            .image
                                                            .toString(),
                                                    fit: BoxFit.fill,
                                                    height: size.height * 0.28,
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
                                                    errorWidget:
                                                        (context, url, error) =>
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
                                                // Container(
                                                //   height: size.height * 0.28,
                                                //   padding: EdgeInsets.symmetric(horizontal: 0),
                                                //   margin: EdgeInsets.symmetric(horizontal: 0),
                                                //   decoration: BoxDecoration(
                                                //       image: DecorationImage(
                                                //           image: AssetImage(Images.flat))),
                                                // ),

                                                Positioned(
                                                    top: 40,
                                                    right: 0,
                                                    child: Container(
                                                        padding:
                                                            EdgeInsets.all(20),
                                                        decoration: BoxDecoration(
                                                            image: DecorationImage(
                                                                image: AssetImage(
                                                                    Images
                                                                        .Frame))),
                                                        child: Text(
                                                            "Rent:${_getMyPropertyList!.propertyList![index]!.price.toString()}"))),
                                              ],
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 0.0),
                                              child: Text(
                                                _getMyPropertyList!
                                                    .propertyList![index]
                                                    .category
                                                    .toString(),
                                                style: GoogleFonts.lato(
                                                    color: Color(0xff4C4C4C),
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 0.0),
                                              child: Text(
                                                "${_getMyPropertyList!.propertyList![index].address.toString()},${_getMyPropertyList!.propertyList![index].city.toString()}",
                                                style: GoogleFonts.lato(
                                                    color: Color(0xff4C4C4C),
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 0.0),
                                              child: Text(
                                                _getMyPropertyList!
                                                    .propertyList![index]
                                                    .roomtype
                                                    .toString(),
                                                style: GoogleFonts.lato(
                                                    color: Color(0xff4C4C4C),
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 0.0),
                                              child: Text(
                                                _getMyPropertyList!
                                                    .propertyList![index].name
                                                    .toString(),
                                                style: GoogleFonts.lato(
                                                    color: Color(0xff4C4C4C),
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 12),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 0.0),
                                              child: Text(
                                                _getMyPropertyList!
                                                    .propertyList![index]
                                                    .description
                                                    .toString(),
                                                style: GoogleFonts.lato(
                                                    color: Color(0xff4C4C4C),
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 12),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 0.0,
                                                      vertical: 10),
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
                                                        activeColor: AppColors
                                                            .primaryColor,
                                                        showOnOff: true,
                                                        activeText: "ON",
                                                        inactiveText: "OFF",
                                                        // activeToggleColor:AppColor.primaryColor ,
                                                        value: (_getMyPropertyList!
                                                                    .propertyList![
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
                                                              "service=====${_getMyPropertyList!.propertyList![index].propertyId.toString()}");
                                                          Helper.checkInternet(
                                                              activeInactive(
                                                                  _getMyPropertyList!
                                                                      .propertyList![
                                                                          index]
                                                                      .propertyId
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

                                                  // edit property

                                                  InkWell(
                                                    onTap: () => {
                                                      Helper
                                                          .moveToScreenwithPush(
                                                              context,
                                                              EditPropertyScreen(
                                                                serviceImage: _getMyPropertyList!
                                                                    .propertyList![
                                                                        index]
                                                                    .image
                                                                    .toString(),
                                                                service_id: _getMyPropertyList!
                                                                    .propertyList![
                                                                        index]
                                                                    .propertyId
                                                                    .toString(),
                                                                service_name: _getMyPropertyList!
                                                                    .propertyList![
                                                                        index]
                                                                    .name
                                                                    .toString(),
                                                                service_des: _getMyPropertyList!
                                                                    .propertyList![
                                                                        index]
                                                                    .description
                                                                    .toString(),
                                                                address: _getMyPropertyList!
                                                                    .propertyList![
                                                                        index]
                                                                    .address
                                                                    .toString(),
                                                                number: _getMyPropertyList!
                                                                    .propertyList![
                                                                        index]
                                                                    .mobile
                                                                    .toString(),
                                                                // serviceCategory:_getMyPropertyList!.propertyList![index].id.toString(),
                                                                serviceCategory:
                                                                    _getMyPropertyList!
                                                                        .propertyList![
                                                                            index]
                                                                        .category
                                                                        .toString(),
                                                                city: _getMyPropertyList!
                                                                    .propertyList![
                                                                        index]
                                                                    .city
                                                                    .toString(),
                                                                rent: _getMyPropertyList!
                                                                    .propertyList![
                                                                        index]
                                                                    .price
                                                                    .toString(),
                                                                title: '',
                                                              ))
                                                    },
                                                    child: Image.asset(
                                                      Images.pencil,
                                                      height:
                                                          size.height * 0.03,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 25,
                                                  ),
                                                  InkWell(
                                                      onTap: () =>
                                                          {showAlertDailog()},
                                                      child: Image.asset(
                                                        Images.bin,
                                                        height:
                                                            size.height * 0.03,
                                                      )),
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
                        )),
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
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => AddPropertynew()));
          // Add your action here
          // For example, you can navigate to another screen or perform some action.
          // Navigator.push(context, MaterialPageRoute(builder: (context) => NextScreen()));
        },
        child: Icon(Icons.add), // Add your FAB icon here
      ),
    );
  }

  setProgress(bool show) {
    if (mounted)
      setState(() {
        _isVisible = show;
      });
  }

  Future<void> getmypropertylistApi() async {
    print("<=============getmypropertylistApi =============>");

    final prefs = await SharedPreferences.getInstance();
    var user_id = await prefs.getString('user_id');

    setProgress(true);
    Map data = {
      'user_id': user_id.toString(),
    };

    print("Request =============>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Api.getMyProperty), body: data);
      print("Response ============>" + res.body);

      if (res.statusCode == 200) {
        print("true ============>");
        try {
          final jsonResponse = jsonDecode(res.body);
          GetMyPropertyList model = GetMyPropertyList.fromJson(jsonResponse);

          if (model.status == "true") {
            print("Model status true");

            setProgress(false);

            setState(() {
              _getMyPropertyList = model;
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

  Future<void> activeInactive(String propertyid) async {
    print("<=============activeInactive =============>");

    final prefs = await SharedPreferences.getInstance();
    var user_id = await prefs.getString('user_id');

    setProgress(true);
    Map data = {
      'user_id': user_id.toString(),
      'property_id': propertyid.toString(),
    };

    print("Request =============>" + data.toString());
    try {
      var res =
          await http.post(Uri.parse(Api.markMypropertyInactive), body: data);
      print("Response ============>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          ActiveInactivePropertyModel model =
              ActiveInactivePropertyModel.fromJson(jsonResponse);

          if (model.status == "true") {
            print("Model status true");

            setProgress(false);

            setState(() {
              _activeInactivePropertyModel = model;
              // Helper.popScreen(context);
              Helper.checkInternet(getmypropertylistApi());
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

  Future<void> deletepropertyApi(String propertyid) async {
    print("<=============deleteApi =============>");

    final prefs = await SharedPreferences.getInstance();
    var user_id = await prefs.getString('user_id');

    setProgress(true);
    Map data = {
      'user_id': user_id.toString(),
      'property_id': propertyid.toString(),
    };

    print("Request =============>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Api.deleteMyProperty), body: data);
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
              Helper.checkInternet(getmypropertylistApi());
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
                            Helper.checkInternet(
                                deletepropertyApi(property_id));
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
}
