import 'dart:convert';
import 'package:dhoondle/src/constants/helper/session.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../api_model/get_property_model.dart';
import '../../constants/Api.dart';
import '../../constants/colors.dart';
import '../../constants/helper.dart';
import '../../constants/images.dart';
import '../controllers/api_controller.dart';
import 'custom_drawer.dart';

class TabbarScreen extends StatefulWidget {
  const TabbarScreen({Key? key}) : super(key: key);

  @override
  State<TabbarScreen> createState() => _TabbarScreenState();
}

class _TabbarScreenState extends State<TabbarScreen>
    with SingleTickerProviderStateMixin {
  String? full_name, user_mob, user_email, user_add;
  int initPosition = 0;
  GetPropertyCategoryModel? _getPropertyCategoryModel;
  late TabController _tabController;
  ApiController controller = Get.put(ApiController());
  int selectedContainerIndex = -1;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var services = [
    'Plumber',
    'Electrican',
    'Carpenter',
    'Painter',
    'AC Repair',
    'Pandit'
  ];

  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    controller.getpropertyapi();
    getUserData();
    Helper.checkInternet(categoryapi());
  }

  getUserData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    full_name = preferences.getString('user_name');
    user_mob = preferences.getString('user_mobile');
    user_email = preferences.getString('user_email');
    user_add = preferences.getString('user_address');

    print('-----0---------${full_name}');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      key: scaffoldKey,
      drawer: const Drawer(
        child: CustomDrawer(),
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: AppColors.primaryColor,
      //   onPressed: (() {}),
      //   child: Icon(
      //     Icons.add,
      //     size: 30,
      //     color: Colors.white,
      //   ),
      // ),
      body: SizedBox(
        height: Get.height,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              height: Get.height * .40,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: AppColors.gradeintColor),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: Get.height * .02,
                  ),
                  SizedBox(
                    height: Get.height * .1,
                    child: Center(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () =>
                                  scaffoldKey.currentState!.openDrawer(),
                              child: Container(
                                height: Get.height * .08,
                                width: Get.height * .075,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: const Color.fromARGB(
                                        175, 179, 240, 224)),
                                child: Image.asset(
                                  Images.whiteLogo,
                                  height: 40,
                                  width: 40,
                                ),
                              ),
                            ),

                            // IconButton(
                            //     onPressed: () {},
                            //     icon: Icon(
                            //       Icons.filter_alt,
                            //       color: Colors.white,
                            //       size: 30,
                            //     ))
                          ]),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * .20,
                    child: Center(
                      child: Row(
                        children: [
                          Expanded(
                              child: GestureDetector(
                            onTap: () => Get.toNamed('/roomforrent'),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 15.0),
                              height: Get.height * .16,
                              decoration: BoxDecoration(
                                  color: const Color.fromRGBO(168, 242, 243, 1),
                                  borderRadius: BorderRadius.circular(12.0)),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset(
                                    'assets/logo/house.png',
                                    height: Get.height * .06,
                                  ),
                                  // const SizedBox(
                                  //   height: 12.0,
                                  // ),
                                  SizedBox(
                                    child: Text(
                                        getTranslated(context, 'Room_for_Rent'),
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.lato(
                                            fontSize: 14,
                                            color: AppColors.textcolor,
                                            fontWeight: FontWeight.w400)),
                                  )
                                ],
                              ),
                            ),
                          )),
                          const SizedBox(
                            width: 16.0,
                          ),
                          Expanded(
                              child: GestureDetector(
                            onTap: () {
                              Get.toNamed('/addpropertynew');
                            },
                            child: Container(
                              height: Get.height * .16,
                              decoration: BoxDecoration(
                                  color: const Color.fromRGBO(160, 232, 204, 1),
                                  borderRadius: BorderRadius.circular(12.0)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/logo/for-sale.png',
                                    height: Get.height * .06,
                                  ),
                                  const SizedBox(
                                    height: 12.0,
                                  ),
                                  SizedBox(
                                    child: Text(
                                        getTranslated(
                                            context, 'Selling_Property'),
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.lato(
                                            fontSize: 14,
                                            color: AppColors.textcolor,
                                            fontWeight: FontWeight.w400)),
                                  )
                                ],
                              ),
                            ),
                          )),
                          const SizedBox(
                            width: 16.0,
                          ),
                          Expanded(
                              child: GestureDetector(
                            onTap: () => Get.toNamed('/roomscreen'),
                            child: Container(
                              height: Get.height * .16,
                              decoration: BoxDecoration(
                                  color: const Color.fromRGBO(8, 255, 200, 1),
                                  borderRadius: BorderRadius.circular(12.0)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/logo/room-mate.png',
                                    height: Get.height * .06,
                                  ),
                                  const SizedBox(
                                    height: 12.0,
                                  ),
                                  SizedBox(
                                    child: Text(
                                        getTranslated(context, 'Find_Roommate'),
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.lato(
                                            fontSize: 14,
                                            color: AppColors.textcolor,
                                            fontWeight: FontWeight.w400)),
                                  )
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
            Positioned(
                top: Get.height * .34,
                bottom: 0,
                right: 0,
                left: 0,
                child: Container(
                  height: Get.height * .66,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18.0, vertical: 20.0),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25.0),
                          topRight: Radius.circular(24.0))),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(getTranslated(context, 'Our_Services'),
                              style: GoogleFonts.lato(
                                  fontSize: 20,
                                  color: AppColors.NewHeaderTextColor,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            buildContainer(
                                0,
                                'Plumber',
                                'assets/logo/plumber.png',
                                () => Get.toNamed('/plumber',
                                    arguments: services[0])),
                            const SizedBox(width: 16.0),
                            buildContainer(
                                1,
                                'Electrician',
                                'assets/logo/electrician.png',
                                () => Get.toNamed('/plumber',
                                    arguments: services[1])),
                            const SizedBox(width: 16.0),
                            buildContainer(
                                2,
                                'Carpenter',
                                'assets/logo/cappainter.png',
                                () => Get.toNamed('/plumber',
                                    arguments: services[2])),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            buildContainer(
                                3,
                                'Painter',
                                'assets/logo/painter.png',
                                () => Get.toNamed('/plumber',
                                    arguments: services[3])),
                            const SizedBox(width: 16.0),
                            buildContainer(
                                4,
                                'AC_Repair',
                                'assets/logo/ac-repair.png',
                                () => Get.toNamed('/plumber',
                                    arguments: services[4])),
                            const SizedBox(width: 16.0),
                            buildContainer(
                                5,
                                'Pandit',
                                'assets/logo/pandit.png',
                                () => Get.toNamed('/plumber',
                                    arguments: services[5])),
                          ],
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    ));
  }

  Widget buildContainer(int index, title, image, Function() onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          onTap();
          if (selectedContainerIndex != index) {
            selectContainer(index);
          } else {
            selectContainer(-1);
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          height: (Get.width / 3) - 16.6,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: selectedContainerIndex == index
                  ? AppColors.NewButtonColor
                  : AppColors.home_divider_color,
              width: selectedContainerIndex == index ? 2.0 : 1.0,
            ),
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundColor: const Color.fromARGB(255, 202, 236, 227),
                  radius: 25,
                  child: Center(
                    child: Image.asset(image),
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                SizedBox(
                  child: Text(getTranslated(context, title),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                          fontSize: 14,
                          color: AppColors.textcolor,
                          fontWeight: FontWeight.w400)),
                )
              ]),
        ),
      ),
    );
  }

  void selectContainer(int index) {
    setState(() {
      selectedContainerIndex = index;
    });
  }
  // @override
  // Widget build(BuildContext context) {
  //   final size = MediaQuery.of(context).size;
  //   return SafeArea(
  //       child: Scaffold(
  //           appBar: AppBar(
  //             backgroundColor: AppColors.primaryColor,
  //             toolbarHeight: 80,
  //             leading: Padding(
  //               padding: const EdgeInsets.symmetric(horizontal: 5.0),
  //               child: Image.asset(
  //                 Images.logo,
  //                 height: 200,
  //               ),
  //             ),
  //             centerTitle: true,
  //             elevation: 0,
  //             title: Text(TextScreen.Home,
  //                 style: GoogleFonts.lato(
  //                   textStyle: TextStyle(
  //                       color: Colors.white,
  //                       fontSize: 18,
  //                       fontWeight: FontWeight.w500),
  //                 )),
  //             actions: [
  //               Padding(
  //                 padding: const EdgeInsets.all(25),
  //                 child: InkWell(
  //                     onTap: () {
  //                       Helper.moveToScreenwithPush(context, SearchScreen());
  //                     },
  //                     child: Image.asset(
  //                       Images.search,
  //                     )),
  //               ),
  //             ],
  //           ),
  //           body: SafeArea(
  //             child: _getPropertyCategoryModel == null
  //                 ? Container()
  //                 : CustomTabView(
  //                     initPosition: initPosition,
  //                     itemCount: _getPropertyCategoryModel!.categoryList.length,

  //                     tabBuilder: (context, index) => Tab(
  //                         text: _getPropertyCategoryModel!
  //                             .categoryList[index].category
  //                             .toString()
  //                             .toUpperCase()),
  //                     // pageBuilder: (context, index) => Center(child: Text(_getPropertyCategoryModel!.categoryList[index].category.toString())),
  //                     pageBuilder: (context, index) => HomeScreen(
  //                         category: _getPropertyCategoryModel!
  //                             .categoryList[index].category
  //                             .toString()
  //                             .toUpperCase()),
  //                     onPositionChange: (index) {
  //                       print('current position: $index');
  //                       initPosition = index;
  //                     },
  //                     onScroll: (position) => print('$position'),
  //                   ),
  //             //   child:Obx(
  //             //     () => controller.isLoading.value? Container():   Container(
  //             //     width: MediaQuery.of(context).size.width,
  //             //     height: MediaQuery.of(context).size.height,
  //             //     child: DefaultTabController(
  //             //         length: 4,
  //             //         child: Column(
  //             //           children: <Widget>[
  //             //             Padding(
  //             //               padding: EdgeInsets.only(top: 10),
  //             //               child: Row(
  //             //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //             //                   children: [
  //             //                     Container(
  //             //                       width: MediaQuery.of(context).size.width,
  //             //                       child: TabBar(
  //             //                         automaticIndicatorColorAdjustment: true,
  //             //                         isScrollable: false,
  //             //                         labelStyle: GoogleFonts.openSans(
  //             //                             textStyle: TextStyle(
  //             //                               fontSize: 15,
  //             //                               fontWeight: FontWeight.w500,
  //             //                               color: Colors.white,
  //             //                             )),
  //             //                         unselectedLabelColor: AppColors.greycolor,
  //             //                         labelColor: Colors.grey,
  //             //                         controller: _tabController,
  //             //                         indicatorSize: TabBarIndicatorSize.tab,
  //             //                         indicatorWeight: 2,
  //             //                         indicatorColor: AppColors.textcolor,
  //             //                         tabs: [
  //             //                           Tab(
  //             //                             child: InkWell(
  //             //                               onTap: () {
  //             //                                 setState(() {
  //             //                                   _tabController.index = 0;
  //             //                                 });
  //             //                               },
  //             //                               child: Center(
  //             //                                   child: _tabController.index == 0
  //             //                                       ? Container(
  //             //                                     // padding: EdgeInsets.symmetric(horizontal: 0,vertical: 0),
  //             //                                     decoration: BoxDecoration(
  //             //                                       borderRadius:
  //             //                                       BorderRadius.circular(
  //             //                                           20),
  //             //                                     ),
  //             //                                     child: MaterialButton(
  //             //                                         padding:
  //             //                                         EdgeInsets.symmetric(
  //             //                                             horizontal: 0,
  //             //                                             vertical: 0),
  //             //                                         // textColor: Colors.white,
  //             //                                         child: Text("RK",
  //             //                                             style: GoogleFonts
  //             //                                                 .lato(
  //             //                                               textStyle: TextStyle(
  //             //                                                   color: AppColors
  //             //                                                       .textcolor,
  //             //                                                   fontSize: 16,
  //             //                                                   fontWeight:
  //             //                                                   FontWeight
  //             //                                                       .w500),
  //             //                                             )),
  //             //                                         onPressed: () {}),
  //             //                                   )
  //             //                                       : Text("RK",
  //             //                                       style: GoogleFonts.lato(
  //             //                                         textStyle: TextStyle(
  //             //                                             color:
  //             //                                             AppColors.greycolor,
  //             //                                             fontSize: 16,
  //             //                                             fontWeight:
  //             //                                             FontWeight.w500),
  //             //                                       ))),
  //             //                             ),
  //             //                           ),
  //             //                           Tab(
  //             //                             child: InkWell(
  //             //                               onTap: () {
  //             //                                 setState(() {
  //             //                                   _tabController.index = 1;
  //             //                                 });
  //             //                               },
  //             //                               child: Center(
  //             //                                   child: _tabController.index == 01
  //             //                                       ? Container(
  //             //                                     // padding: EdgeInsets.symmetric(horizontal: 0,vertical: 0),
  //             //                                     decoration: BoxDecoration(
  //             //                                       borderRadius:
  //             //                                       BorderRadius.circular(
  //             //                                           20),
  //             //                                     ),
  //             //                                     child: MaterialButton(
  //             //                                         padding:
  //             //                                         EdgeInsets.symmetric(
  //             //                                             horizontal: 0,
  //             //                                             vertical: 0),
  //             //                                         // textColor: Colors.white,
  //             //                                         child: Text("1BHK",
  //             //                                             style: GoogleFonts
  //             //                                                 .lato(
  //             //                                               textStyle: TextStyle(
  //             //                                                   color:AppColors.textcolor,
  //             //                                                   fontSize: 16,
  //             //                                                   fontWeight:
  //             //                                                   FontWeight
  //             //                                                       .w500),
  //             //                                             )),
  //             //                                         onPressed: () {}),
  //             //                                   )
  //             //                                       : Text("1BHK",
  //             //                                       style: GoogleFonts.lato(
  //             //                                         textStyle: TextStyle(
  //             //                                             color:
  //             //                                            AppColors.greycolor,
  //             //                                             fontSize: 16,
  //             //                                             fontWeight:
  //             //                                             FontWeight.w500),
  //             //                                       ))),
  //             //                             ),
  //             //                           ),
  //             //                           Tab(
  //             //                             child: InkWell(
  //             //                               onTap: () {
  //             //                                 setState(() {
  //             //                                   _tabController.index = 2;
  //             //                                 });
  //             //                               },
  //             //                               child: Center(
  //             //                                   child: _tabController.index == 02
  //             //                                       ? Container(
  //             //                                     // padding: EdgeInsets.symmetric(horizontal: 0,vertical: 0),
  //             //                                     decoration: BoxDecoration(
  //             //                                       borderRadius:
  //             //                                       BorderRadius.circular(
  //             //                                           20),
  //             //                                     ),
  //             //                                     child: MaterialButton(
  //             //                                         padding:
  //             //                                         EdgeInsets.symmetric(
  //             //                                             horizontal: 0,
  //             //                                             vertical: 0),
  //             //                                         // textColor: Colors.white,
  //             //                                         child: Text("2BHK",
  //             //                                             style: GoogleFonts
  //             //                                                 .lato(
  //             //                                               textStyle: TextStyle(
  //             //                                                   color:AppColors.textcolor,
  //             //                                                   fontSize: 16,
  //             //                                                   fontWeight:
  //             //                                                   FontWeight
  //             //                                                       .w500),
  //             //                                             )),
  //             //                                         onPressed: () {}),
  //             //                                   )
  //             //                                       : Text("2BHK",
  //             //                                       style: GoogleFonts.lato(
  //             //                                         textStyle: TextStyle(
  //             //                                             color:
  //             //                                           AppColors.greycolor,
  //             //                                             fontSize: 16,
  //             //                                             fontWeight:
  //             //                                             FontWeight.w500),
  //             //                                       ))),
  //             //                             ),
  //             //                           ),
  //             //                           Tab(
  //             //                             child: InkWell(
  //             //                               onTap: () {
  //             //                                 setState(() {
  //             //                                   _tabController.index = 3;
  //             //                                 });
  //             //                               },
  //             //                               child: Center(
  //             //                                   child: _tabController.index == 03
  //             //                                       ? Container(
  //             //                                     // padding: EdgeInsets.symmetric(horizontal: 0,vertical: 0),
  //             //                                     decoration: BoxDecoration(
  //             //                                       borderRadius:
  //             //                                       BorderRadius.circular(
  //             //                                           20),
  //             //                                     ),
  //             //                                     child: MaterialButton(
  //             //                                         padding:
  //             //                                         EdgeInsets.symmetric(
  //             //                                             horizontal: 0,
  //             //                                             vertical: 0),
  //             //                                         // textColor: Colors.white,
  //             //                                         child: Text("Villa",
  //             //                                             style: GoogleFonts
  //             //                                                 .lato(
  //             //                                               textStyle: TextStyle(
  //             //                                                   color: AppColors.textcolor,
  //             //                                                   fontSize: 16,
  //             //                                                   fontWeight:
  //             //                                                   FontWeight
  //             //                                                       .w500),
  //             //                                             )),
  //             //                                         onPressed: () {}),
  //             //                                   )
  //             //
  //             //
  //             //                                   //controller.getPropertyCategoryModel!.categoryList[3].category.toString(),
  //             //                                       : Text("Villa",
  //             //                                       style: GoogleFonts.lato(
  //             //                                         textStyle: TextStyle(
  //             //                                             color:
  //             //                                            AppColors.greycolor,
  //             //                                             fontSize: 16,
  //             //                                             fontWeight:
  //             //                                             FontWeight.w500),
  //             //                                       ))),
  //             //                             ),
  //             //                           ),
  //             //                         ],
  //             //                       ),
  //             //                     ),
  //             //                     // Image.asset(ProjectImage.search,height: 40,),
  //             //                     // SizedBox(width: 10,),
  //             //                     // Image.asset(ProjectImage.home,height: 40,)                      ],
  //             //                   ]),
  //             //             ),
  //             //             Expanded(
  //             //               child: TabBarView(
  //             //                 controller: _tabController,
  //             //                 physics: NeverScrollableScrollPhysics(),
  //             //                 children: [
  //             //
  //             //                   HomeScreen(category: "RK",),
  //             //                   HomeScreen(category: "1BHK",),
  //             //                   HomeScreen(category: "2BHK",),
  //             //                   HomeScreen(category: "Villa"),
  //             //
  //             //
  //             //                 ],
  //             //
  //             //                 // children: <Widget>[
  //             //                 //   new Center(
  //             //                 //     child: new Card(
  //             //                 //       child: new Container(
  //             //                 //           height: 450.0,
  //             //                 //           width: 300.0,
  //             //                 //           child: new IconButton(
  //             //                 //             icon: new Icon(Icons.favorite, size: 100.0),
  //             //                 //             tooltip: 'Favorited',
  //             //                 //             onPressed: null,
  //             //                 //           )
  //             //                 //       ),
  //             //                 //     ),
  //             //                 //   ),
  //             //                 //   new Center(
  //             //                 //     child: new Card(
  //             //                 //       child: new Container(
  //             //                 //           height: 450.0,
  //             //                 //           width: 300.0,
  //             //                 //           child: new IconButton(
  //             //                 //             icon: new Icon(Icons.local_pizza, size: 50.0,),
  //             //                 //             tooltip: 'Pizza',
  //             //                 //             onPressed: null,
  //             //                 //           )
  //             //                 //       ),
  //             //                 //     ),
  //             //                 //   ),
  //             //                 // ],
  //             //
  //             //
  //             //               ),
  //             //             ),
  //             //
  //             //
  //             //
  //             //
  //             //           ],
  //             //         )),
  //             //   ),
  //             // )),
  //           )));
  // }

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
}

class CustomTabView extends StatefulWidget {
  const CustomTabView({
    super.key,
    required this.itemCount,
    required this.tabBuilder,
    required this.pageBuilder,
    this.stub,
    this.onPositionChange,
    this.onScroll,
    this.initPosition,
  });

  final int itemCount;
  final IndexedWidgetBuilder tabBuilder;
  final IndexedWidgetBuilder pageBuilder;
  final Widget? stub;
  final ValueChanged<int>? onPositionChange;
  final ValueChanged<double>? onScroll;
  final int? initPosition;

  @override
  CustomTabsState createState() => CustomTabsState();
}

class CustomTabsState extends State<CustomTabView>
    with TickerProviderStateMixin {
  late TabController controller;
  late int _currentCount;
  late int _currentPosition;

  @override
  void initState() {
    _currentPosition = widget.initPosition ?? 0;
    controller = TabController(
      length: widget.itemCount,
      vsync: this,
      initialIndex: _currentPosition,
    );
    controller.addListener(onPositionChange);
    controller.animation!.addListener(onScroll);
    _currentCount = widget.itemCount;
    super.initState();
  }

  @override
  void didUpdateWidget(CustomTabView oldWidget) {
    if (_currentCount != widget.itemCount) {
      controller.animation!.removeListener(onScroll);
      controller.removeListener(onPositionChange);
      controller.dispose();

      if (widget.initPosition != null) {
        _currentPosition = widget.initPosition!;
      }

      if (_currentPosition > widget.itemCount - 1) {
        _currentPosition = widget.itemCount - 1;
        _currentPosition = _currentPosition < 0 ? 0 : _currentPosition;
        if (widget.onPositionChange is ValueChanged<int>) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted && widget.onPositionChange != null) {
              widget.onPositionChange!(_currentPosition);
            }
          });
        }
      }

      _currentCount = widget.itemCount;
      setState(() {
        controller = TabController(
          length: widget.itemCount,
          vsync: this,
          initialIndex: _currentPosition,
        );
        controller.addListener(onPositionChange);
        controller.animation!.addListener(onScroll);
      });
    } else if (widget.initPosition != null) {
      controller.animateTo(widget.initPosition!);
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    controller.animation!.removeListener(onScroll);
    controller.removeListener(onPositionChange);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.itemCount < 1) return widget.stub ?? Container();

    return Column(
      // crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10),
          margin: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
          width: MediaQuery.of(context).size.width,
          alignment:
              widget.itemCount <= 5 ? Alignment.center : Alignment.topLeft,
          child: TabBar(
            isScrollable: true,
            controller: controller,
            labelStyle: GoogleFonts.lato(
                textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            )),
            unselectedLabelColor: const Color(0xffA7A7A7),
            labelColor: Colors.black,
            indicator: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: AppColors.greycolor,
                  width: 5,
                ),
              ),
            ),
            tabs: List.generate(
              widget.itemCount,
              (index) => widget.tabBuilder(context, index),
            ),
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: controller,
            children: List.generate(
              widget.itemCount,
              (index) => widget.pageBuilder(context, index),
            ),
          ),
        ),
      ],
    );
  }

  void onPositionChange() {
    if (!controller.indexIsChanging) {
      _currentPosition = controller.index;
      if (widget.onPositionChange is ValueChanged<int>) {
        widget.onPositionChange!(_currentPosition);
      }
    }
  }

  void onScroll() {
    if (widget.onScroll is ValueChanged<double>) {
      widget.onScroll!(controller.animation!.value);
    }
  }
}
