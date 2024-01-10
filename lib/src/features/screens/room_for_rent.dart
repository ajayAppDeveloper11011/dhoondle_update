import 'dart:convert';

import 'package:dhoondle/src/api_model/get_property_model.dart';
import 'package:dhoondle/src/constants/Api.dart';
import 'package:dhoondle/src/constants/colors.dart';
import 'package:dhoondle/src/constants/helper.dart';

import 'package:dhoondle/src/features/controllers/api_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'home_screen.dart';



class RoomForRentScreen extends StatefulWidget {
  const RoomForRentScreen({super.key});

  @override
  State<RoomForRentScreen> createState() => _RoomForRentScreenState();
}

class _RoomForRentScreenState extends State<RoomForRentScreen> {
  int initPosition = 0;
  GetPropertyCategoryModel? _getPropertyCategoryModel;
  var myIndex = '0';
  ApiController controller = Get.put(ApiController());

  @override
  void initState() {
    controller.getpropertyapi();
    Helper.checkInternet(categoryapi());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.primaryColor,
              // toolbarHeight: 80,
              // leading: Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 5.0),
              //   child: Image.asset(
              //     Images.logo,
              //     height: 200,
              //   ),
              // ),
              centerTitle: true,
              elevation: 0,
              title: Text('Room for Rent',
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  )),
              actions: [
                // Padding(
                //   padding: const EdgeInsets.all(16.0),
                //   child: InkWell(
                //       onTap: () {
                //         Helper.moveToScreenwithPush(context, SearchScreen());
                //       },
                //       child: Image.asset(
                //         Images.search,
                //       )),
                // ),
              ],
            ),
            floatingActionButton: FloatingActionButton.extended(
              backgroundColor: AppColors.primaryColor,
              onPressed: () => Get.toNamed('/addproperty'),
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              label: Text('Add New'),
            ),

            body: SafeArea(
              child: _getPropertyCategoryModel == null
                  ? Container()
                  : Column(
                children: [
                  // CustomTabView(
                  //   initPosition: initPosition,
                  //   itemCount:
                  //       _getPropertyCategoryModel!.categoryList.length,

                  //   tabBuilder: (context, index) => Tab(
                  //       text: _getPropertyCategoryModel!
                  //           .categoryList[index].category
                  //           .toString()
                  //           .toUpperCase()),
                  //   // pageBuilder: (context, index) => Center(child: Text(_getPropertyCategoryModel!.categoryList[index].category.toString())),
                  //   pageBuilder: (context, index) => HomeScreen(
                  //       category: _getPropertyCategoryModel!
                  //           .categoryList[index].category
                  //           .toString()
                  //           .toUpperCase()),
                  //   onPositionChange: (index) {
                  //     print('current position: $index');
                  //     initPosition = index;
                  //   },
                  //   onScroll: (position) => print('$position'),
                  // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical:10.0, horizontal:15),
                    child: Container(
                      height: 110,
                      width: MediaQuery.of(context).size.width,
                      child: GridView.builder(
                        gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                            3, // Set the number of items in a row as per your design
                            mainAxisSpacing:15,
                            crossAxisSpacing:15,
                            childAspectRatio:2.5),
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: _getPropertyCategoryModel!
                            .categoryList.length,
                        itemBuilder: (context, index) {
                          String currentIndex = _getPropertyCategoryModel!
                              .categoryList[index].category
                              .toString()
                              .toUpperCase();

                          return InkWell(
                            onTap: () {
                              setState(() {
                                myIndex = currentIndex;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: myIndex == currentIndex
                                    ? AppColors.primaryColor
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                    color: AppColors.primaryColor),
                              ),
                              child: Center(
                                child: Text(
                                  currentIndex.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: myIndex == currentIndex
                                        ? Colors.white
                                        :Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Container(
                    height: Get.height * .7,
                    child: PageView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => HomeScreen(
                          category: _getPropertyCategoryModel!
                              .categoryList[index].category
                              .toString()
                              .toUpperCase()),
                      // onPageChanged: (value) {
                      //   print(value);
                      //   initPosition = value;
                      // },
                    ),
                  )
                ],
              ),
              //   child:Obx(
              //     () => controller.isLoading.value? Container():   Container(
              //     width: MediaQuery.of(context).size.width,
              //     height: MediaQuery.of(context).size.height,
              //     child: DefaultTabController(
              //         length: 4,
              //         child: Column(
              //           children: <Widget>[
              //             Padding(
              //               padding: EdgeInsets.only(top: 10),
              //               child: Row(
              //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //                   children: [
              //                     Container(
              //                       width: MediaQuery.of(context).size.width,
              //                       child: TabBar(
              //                         automaticIndicatorColorAdjustment: true,
              //                         isScrollable: false,
              //                         labelStyle: GoogleFonts.openSans(
              //                             textStyle: TextStyle(
              //                               fontSize: 15,
              //                               fontWeight: FontWeight.w500,
              //                               color: Colors.white,
              //                             )),
              //                         unselectedLabelColor: AppColors.greycolor,
              //                         labelColor: Colors.grey,
              //                         controller: _tabController,
              //                         indicatorSize: TabBarIndicatorSize.tab,
              //                         indicatorWeight: 2,
              //                         indicatorColor: AppColors.textcolor,
              //                         tabs: [
              //                           Tab(
              //                             child: InkWell(
              //                               onTap: () {
              //                                 setState(() {
              //                                   _tabController.index = 0;
              //                                 });
              //                               },
              //                               child: Center(
              //                                   child: _tabController.index == 0
              //                                       ? Container(
              //                                     // padding: EdgeInsets.symmetric(horizontal: 0,vertical: 0),
              //                                     decoration: BoxDecoration(
              //                                       borderRadius:
              //                                       BorderRadius.circular(
              //                                           20),
              //                                     ),
              //                                     child: MaterialButton(
              //                                         padding:
              //                                         EdgeInsets.symmetric(
              //                                             horizontal: 0,
              //                                             vertical: 0),
              //                                         // textColor: Colors.white,
              //                                         child: Text("RK",
              //                                             style: GoogleFonts
              //                                                 .lato(
              //                                               textStyle: TextStyle(
              //                                                   color: AppColors
              //                                                       .textcolor,
              //                                                   fontSize: 16,
              //                                                   fontWeight:
              //                                                   FontWeight
              //                                                       .w500),
              //                                             )),
              //                                         onPressed: () {}),
              //                                   )
              //                                       : Text("RK",
              //                                       style: GoogleFonts.lato(
              //                                         textStyle: TextStyle(
              //                                             color:
              //                                             AppColors.greycolor,
              //                                             fontSize: 16,
              //                                             fontWeight:
              //                                             FontWeight.w500),
              //                                       ))),
              //                             ),
              //                           ),
              //                           Tab(
              //                             child: InkWell(
              //                               onTap: () {
              //                                 setState(() {
              //                                   _tabController.index = 1;
              //                                 });
              //                               },
              //                               child: Center(
              //                                   child: _tabController.index == 01
              //                                       ? Container(
              //                                     // padding: EdgeInsets.symmetric(horizontal: 0,vertical: 0),
              //                                     decoration: BoxDecoration(
              //                                       borderRadius:
              //                                       BorderRadius.circular(
              //                                           20),
              //                                     ),
              //                                     child: MaterialButton(
              //                                         padding:
              //                                         EdgeInsets.symmetric(
              //                                             horizontal: 0,
              //                                             vertical: 0),
              //                                         // textColor: Colors.white,
              //                                         child: Text("1BHK",
              //                                             style: GoogleFonts
              //                                                 .lato(
              //                                               textStyle: TextStyle(
              //                                                   color:AppColors.textcolor,
              //                                                   fontSize: 16,
              //                                                   fontWeight:
              //                                                   FontWeight
              //                                                       .w500),
              //                                             )),
              //                                         onPressed: () {}),
              //                                   )
              //                                       : Text("1BHK",
              //                                       style: GoogleFonts.lato(
              //                                         textStyle: TextStyle(
              //                                             color:
              //                                            AppColors.greycolor,
              //                                             fontSize: 16,
              //                                             fontWeight:
              //                                             FontWeight.w500),
              //                                       ))),
              //                             ),
              //                           ),
              //                           Tab(
              //                             child: InkWell(
              //                               onTap: () {
              //                                 setState(() {
              //                                   _tabController.index = 2;
              //                                 });
              //                               },
              //                               child: Center(
              //                                   child: _tabController.index == 02
              //                                       ? Container(
              //                                     // padding: EdgeInsets.symmetric(horizontal: 0,vertical: 0),
              //                                     decoration: BoxDecoration(
              //                                       borderRadius:
              //                                       BorderRadius.circular(
              //                                           20),
              //                                     ),
              //                                     child: MaterialButton(
              //                                         padding:
              //                                         EdgeInsets.symmetric(
              //                                             horizontal: 0,
              //                                             vertical: 0),
              //                                         // textColor: Colors.white,
              //                                         child: Text("2BHK",
              //                                             style: GoogleFonts
              //                                                 .lato(
              //                                               textStyle: TextStyle(
              //                                                   color:AppColors.textcolor,
              //                                                   fontSize: 16,
              //                                                   fontWeight:
              //                                                   FontWeight
              //                                                       .w500),
              //                                             )),
              //                                         onPressed: () {}),
              //                                   )
              //                                       : Text("2BHK",
              //                                       style: GoogleFonts.lato(
              //                                         textStyle: TextStyle(
              //                                             color:
              //                                           AppColors.greycolor,
              //                                             fontSize: 16,
              //                                             fontWeight:
              //                                             FontWeight.w500),
              //                                       ))),
              //                             ),
              //                           ),
              //                           Tab(
              //                             child: InkWell(
              //                               onTap: () {
              //                                 setState(() {
              //                                   _tabController.index = 3;
              //                                 });
              //                               },
              //                               child: Center(
              //                                   child: _tabController.index == 03
              //                                       ? Container(
              //                                     // padding: EdgeInsets.symmetric(horizontal: 0,vertical: 0),
              //                                     decoration: BoxDecoration(
              //                                       borderRadius:
              //                                       BorderRadius.circular(
              //                                           20),
              //                                     ),
              //                                     child: MaterialButton(
              //                                         padding:
              //                                         EdgeInsets.symmetric(
              //                                             horizontal: 0,
              //                                             vertical: 0),
              //                                         // textColor: Colors.white,
              //                                         child: Text("Villa",
              //                                             style: GoogleFonts
              //                                                 .lato(
              //                                               textStyle: TextStyle(
              //                                                   color: AppColors.textcolor,
              //                                                   fontSize: 16,
              //                                                   fontWeight:
              //                                                   FontWeight
              //                                                       .w500),
              //                                             )),
              //                                         onPressed: () {}),
              //                                   )
              //
              //
              //                                   //controller.getPropertyCategoryModel!.categoryList[3].category.toString(),
              //                                       : Text("Villa",
              //                                       style: GoogleFonts.lato(
              //                                         textStyle: TextStyle(
              //                                             color:
              //                                            AppColors.greycolor,
              //                                             fontSize: 16,
              //                                             fontWeight:
              //                                             FontWeight.w500),
              //                                       ))),
              //                             ),
              //                           ),
              //                         ],
              //                       ),
              //                     ),
              //                     // Image.asset(ProjectImage.search,height: 40,),
              //                     // SizedBox(width: 10,),
              //                     // Image.asset(ProjectImage.home,height: 40,)                      ],
              //                   ]),
              //             ),
              //             Expanded(
              //               child: TabBarView(
              //                 controller: _tabController,
              //                 physics: NeverScrollableScrollPhysics(),
              //                 children: [
              //
              //                   HomeScreen(category: "RK",),
              //                   HomeScreen(category: "1BHK",),
              //                   HomeScreen(category: "2BHK",),
              //                   HomeScreen(category: "Villa"),
              //
              //
              //                 ],
              //
              //                 // children: <Widget>[
              //                 //   new Center(
              //                 //     child: new Card(
              //                 //       child: new Container(
              //                 //           height: 450.0,
              //                 //           width: 300.0,
              //                 //           child: new IconButton(
              //                 //             icon: new Icon(Icons.favorite, size: 100.0),
              //                 //             tooltip: 'Favorited',
              //                 //             onPressed: null,
              //                 //           )
              //                 //       ),
              //                 //     ),
              //                 //   ),
              //                 //   new Center(
              //                 //     child: new Card(
              //                 //       child: new Container(
              //                 //           height: 450.0,
              //                 //           width: 300.0,
              //                 //           child: new IconButton(
              //                 //             icon: new Icon(Icons.local_pizza, size: 50.0,),
              //                 //             tooltip: 'Pizza',
              //                 //             onPressed: null,
              //                 //           )
              //                 //       ),
              //                 //     ),
              //                 //   ),
              //                 // ],
              //
              //
              //               ),
              //             ),
              //
              //
              //
              //
              //           ],
              //         )),
              //   ),
              // )),
            )));
  }

  Future<void> categoryapi() async {
    print("<=============categoryapi =============>");

    final prefs = await SharedPreferences.getInstance();
    var user_id = await prefs.getString('user_id');

    // setProgress(true);

    try {
      var res = await http.get(
        Uri.parse(Api.getPropertyCategory + "?user_id=${user_id}"),
      );
      print("Response ============>" + res.body);

      if (res.statusCode == 200) {
        print("-----------Success-----------");
        try {
          final jsonResponse = jsonDecode(res.body);
          GetPropertyCategoryModel model =
          GetPropertyCategoryModel.fromJson(jsonResponse);

          if (model.status == "true") {
            print("Model status true");
            setState(() {
              _getPropertyCategoryModel = model;
            });

            // setProgress(false);

            // setState(() {
            //   _getprofileApi = model;
            //   fullNameController.text= _getprofileApi!.data.name.toString();
            //   addressController.text= _getprofileApi!.data.address.toString();
            //   emailController.text= _getprofileApi!.data.email.toString();
            //   mobileController.text= _getprofileApi!.data.mobile.toString();
            //
            // });

            // ToastMessage.msg(model.message.toString());
          } else {
            setState(() {
              // _hasData = false;
            });
            // setProgress(false);
            print("false ### ============>");
            // ToastMessage.msg(model.message.toString());
          }
        } catch (e) {
          // _hasData = false;
          // print("false ============>");
          // ToastMessage.msg(StaticMessages.API_ERROR);
          print('exception ==> ' + e.toString());
        }
      } else {
        print("status code ==> " + res.statusCode.toString());
        // ToastMessage.msg(StaticMessages.API_ERROR);
      }
    } catch (e) {
      // _hasData = false;
      // ToastMessage.msg(StaticMessages.API_ERROR);
      print('Exception ======> ' + e.toString());
    }
    // setProgress(false);
  }


// List<PropertyData>? getPropertyModel;
// Future<void> GetProperty() async {
//   setProgress(true);
//   var headers = {
//     'Accept-Encoding': 'gzip,deflat,br',
//     'Connection': 'keep alive',
//     'Accept': 'application/json',
//     'Cookie': 'ci_session=2hvjhphqe7lbro8oa1cmh8usivopnfaj'
//   };
//   var request = http.Request(
//       'GET', Uri.parse('https://dhoondle.com/Dhoondle/api/property/index'));

//   request.headers.addAll(headers);

//   http.StreamedResponse response = await request.send();

//   if (response.statusCode == 200) {
//     var Result = await response.stream.bytesToString();
//     final finalResult = GetPropertyModel.fromJson(json.decode(Result));
//     setState(() {
//       getPropertyModel = finalResult.data;
//       print('--------------${getPropertyModel?.first.id}');
//       setProgress(false);
//     });
//   } else {
//     setProgress(true);
//     print(response.reasonPhrase);
//   }
// }
}
