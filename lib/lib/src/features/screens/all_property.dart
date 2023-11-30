import 'dart:convert';
import 'package:dhoondle/lib/src/features/screens/tabbar_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../api_model/get_property_model.dart';
import '../../constants/Api.dart';
import '../../constants/colors.dart';
import '../../constants/helper.dart';
import '../controllers/api_controller.dart';
import 'home_screen.dart';

class AllProperty extends StatefulWidget {
  const AllProperty({super.key});

  @override
  State<AllProperty> createState() => _AllPropertyState();
}

class _AllPropertyState extends State<AllProperty> {
  late PageController _pageController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Property'), backgroundColor: AppColors.primaryColor),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: AppColors.primaryColor,
          onPressed: () {},
          icon: Icon(
            Icons.add,
            color: Colors.white,
          ),
          label: Text('Add New')),
      body: Column(
        children: [
          SizedBox(
            height: Get.height * .02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () => _onItemTapped(0),
                child: Container(
                  height: 45,
                  width: Get.width * .46,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: _selectedIndex == 0
                          ? AppColors.primaryColor
                          : Colors.grey),
                  child: Center(
                    child: Text('Residential',
                        style: GoogleFonts.lato(
                            fontSize: 16,
                            color: AppColors.FillColor,
                            fontWeight: FontWeight.w500)),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => _onItemTapped(1),
                child: Container(
                  height: 45,
                  width: Get.width * .46,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: _selectedIndex == 1
                          ? AppColors.primaryColor
                          : Colors.grey),
                  child: Center(
                    child: Text('Commercial',
                        style: GoogleFonts.lato(
                            fontSize: 16,
                            color: AppColors.FillColor,
                            fontWeight: FontWeight.w500)),
                  ),
                ),
              ),
              // ElevatedButton(
              //   onPressed: () => _onItemTapped(0),
              //   style: ElevatedButton.styleFrom(
              //     primary: _selectedIndex == 0 ? Colors.blue : Colors.grey,
              //   ),
              //   child: Text('Residential'),
              // ),
              // ElevatedButton(
              //   onPressed: () => _onItemTapped(1),
              //   style: ElevatedButton.styleFrom(
              //     primary: _selectedIndex == 1 ? Colors.blue : Colors.grey,
              //   ),
              //   child: Text('Commercial'),
              // ),
            ],
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
              pageSnapping: false,
              onPageChanged: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              children: [
                ResidencialScreen(),
                ResidencialScreen(),
                // CommercialPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ResidencialScreen extends StatefulWidget {
  const ResidencialScreen({super.key});

  @override
  State<ResidencialScreen> createState() => _ResidencialScreenState();
}

class _ResidencialScreenState extends State<ResidencialScreen> {
  GetPropertyCategoryModel? _getPropertyCategoryModel;
  ApiController controller = Get.put(ApiController());

  int initPosition = 0;

  void initState() {
    super.initState();
    // _tabController = TabController(length: 4, vsync: this);
    controller.getpropertyapi();
    Helper.checkInternet(categoryapi());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
            // appBar: AppBar(
            //   backgroundColor: AppColors.primaryColor,
            //   toolbarHeight: 80,
            //   leading: Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: 5.0),
            //     child: Image.asset(
            //       Images.logo,
            //       height: 200,
            //     ),
            //   ),
            //   centerTitle: true,
            //   elevation: 0,
            //   title: Text(TextScreen.Home,
            //       style: GoogleFonts.lato(
            //         textStyle: TextStyle(
            //             color: Colors.white,
            //             fontSize: 18,
            //             fontWeight: FontWeight.w500),
            //       )),
            //   actions: [
            //     Padding(
            //       padding: const EdgeInsets.all(25),
            //       child: InkWell(
            //           onTap: () {
            //             Helper.moveToScreenwithPush(context, SearchScreen());
            //           },
            //           child: Image.asset(
            //             Images.search,
            //           )),
            //     ),
            //   ],
            // ),
            body: SafeArea(
      child: _getPropertyCategoryModel == null
          ? Container()
          : CustomTabView(
              initPosition: initPosition,
              itemCount: _getPropertyCategoryModel!.categoryList.length,

              tabBuilder: (context, index) => Tab(
                  text: _getPropertyCategoryModel!.categoryList[index].category
                      .toString()
                      .toUpperCase()),
              // pageBuilder: (context, index) => Center(child: Text(_getPropertyCategoryModel!.categoryList[index].category.toString())),
              pageBuilder: (context, index) => HomeScreen(
                  category: _getPropertyCategoryModel!
                      .categoryList[index].category
                      .toString()
                      .toUpperCase()),
              onPositionChange: (index) {
                print('current position: $index');
                initPosition = index;
              },
              onScroll: (position) => print('$position'),
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
        print("urvashi ============>");
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

class ResidentialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Residential Page'),
    );
  }
}

class CommercialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Commercial Page'),
    );
  }
}
