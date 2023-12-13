import 'dart:convert';
import 'package:dhoondle/src/constants/helper/session.dart';
import 'package:dhoondle/src/features/screens/tabbar_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../Models/get_property_response.dart';
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
  bool isSelectedResidential = true;
  String myIndex = '0';
  var searchBar = false;
  bool _isVisible = false;
  var searchController = TextEditingController();



  setProgress(bool show) {
    if (mounted)
      setState(() {
        _isVisible = show;
      });
  }


  @override
  void initState() {
    // TODO: implement initState
    GetProperty();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      // _selectedIndex = index;
      _pageController.animateToPage(
        index,
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    });
  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: searchBar == true
              ? Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  height: 40,
                  width: Get.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: AppColors.greycolor, width: 1),
                      borderRadius: BorderRadius.circular(12.0)),
                  child: TextField(
                    controller: searchController,
                    autofocus: true,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Search Here'),
                  ),
                )
              : Text(getTranslated(context, 'Property')),
          backgroundColor: AppColors.primaryColor,
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
          ]),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primaryColor,
        onPressed: () => Get.toNamed('/addpropertynew'),
        icon: Icon(
          Icons.add,
          color: Colors.white,
        ),
        label: Text('Add New'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: Get.height * .02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isSelectedResidential = !isSelectedResidential;
                    });
                  },
                  child: Container(
                    height: 45,
                    width: Get.width * .46,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: isSelectedResidential
                          ? AppColors.primaryColor
                          : Colors.grey,
                    ),
                    child: Center(
                      child: Text(
                        'Residential',
                        style: GoogleFonts.lato(
                          fontSize: 16,
                          color: AppColors.FillColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isSelectedResidential = !isSelectedResidential;
                    });
                  },
                  child: Container(
                    height: 45,
                    width: Get.width * .46,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: isSelectedResidential
                          ? Colors.grey
                          :AppColors.primaryColor ,
                    ),
                    child: Center(
                      child: Text(
                        'Commercial',
                        style: GoogleFonts.lato(
                          fontSize: 16,
                          color: AppColors.FillColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),


            // Expanded(
            //   child: PageView(
            //     controller: _pageController,
            //     physics: NeverScrollableScrollPhysics(),
            //     pageSnapping: false,
            //     onPageChanged: (index) {
            //       setState(() {
            //         _selectedIndex = index;
            //       });
            //     },
            //     children: [
            //       ResidencialScreen(),
            //       ResidencialScreen(),
            //       // CommercialPage(),
            //     ],
            //   ),
            // ),

            SizedBox(height:20,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // controller: _tabController,
              // physics: NeverScrollableScrollPhysics(),
              children: [
                // PropertyScreen(),
                // ServiceScreenTabbar(),

                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10),
                  child: Container(
                    height: 160,
                    width: MediaQuery.of(context).size.width,
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, // Set the number of items in a row as per your design
                        mainAxisSpacing: 1,
                        crossAxisSpacing: 1,
                        childAspectRatio: 1.5
                      ),
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: isSelectedResidential
                          ? categoryList.length
                          : categoryList2.length,
                      itemBuilder: (context, index) {
                        String currentIndex = isSelectedResidential
                            ? categoryList[index]
                            : categoryList2[index];
                        return Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                myIndex = currentIndex;
                              });
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height:65,
                                  width: 140,
                                  decoration: BoxDecoration(
                                    color: myIndex == currentIndex
                                        ? AppColors.primaryColor
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(color: AppColors.primaryColor),
                                  ),
                                  child: Center(
                                    child: Text(
                                      currentIndex.toString(),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:20.0,right: 20),
                  child: Text('Recommendation',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15),),
                ),
                SizedBox(height: 10,),
                getPropertyModel==null ?Center(child: CircularProgressIndicator()):Container(
                  height:MediaQuery.of(context).size.height/1.9,
                  child: GridView.builder(
                    physics: const ScrollPhysics(),
                    primary: false,
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(
                      top: 16,
                      left:20,
                      right:20,
                    ),
                    gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      crossAxisSpacing:10,
                      mainAxisSpacing:10,
                      childAspectRatio:0.66
                    ),
                    itemCount: getPropertyModel?.length,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          InkWell(
                            onTap: () {
                              // controller.onTapCard(index);
                            },
                            child: Container(
                              height:260,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: AppColors.primaryColor)
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height:150,
                                    padding: EdgeInsets.only(left: 5,top: 5,right: 5),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: getPropertyModel?[index].propertyImage==null
                                          ? Image.asset(
                                        'assets/images/room_img.png',
                                        fit: BoxFit.fill,
                                      )
                                          : Image.network(
                                        'https://dhoondle.com/Dhoondle/${getPropertyModel![index].propertyImage.toString()}',
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height:10,
                                        ),
                                        Text(
                                          "Type : ${getPropertyModel![index].propertyType.toString()}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black,
                                              fontSize: 13
                                          ),
                                        ),
                                        const SizedBox(
                                          height:5,
                                        ),
                                        Container(
                                          width:150,
                                          child: Text(
                                            getPropertyModel![index].price==null?"":'Rs. ${getPropertyModel![index].price.toString()}',
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: TextStyle(
                                                color:Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize:12
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height:5,
                                        ),
                                        Text(
                                          'Parking : ${getPropertyModel![index].parkingAvailable.toString()}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                            fontSize: 12
                                          ),
                                        ),
                                        const SizedBox(
                                          height:5,
                                        ),
                                        Text(
                                          '${getPropertyModel![index].furnished.toString()}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                              fontSize: 12
                                          ),
                                        ),
                                        const SizedBox(
                                          height:5,
                                        ),
                                        Container(
                                          width: 120,
                                          child: Text(
                                            '${getPropertyModel![index].address.toString()}',
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black,
                                                fontSize: 12
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 5,)
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top:10,
                            left:130,
                            child: InkWell(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(40)),
                                child: Icon(Icons.favorite_border,
                                   size: 25,
                                ),
                              ),
                              onTap: () {
                              },
                            ),
                          ),

                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List categoryList = [
    'RK',
    '1BHK',
    '2BHK',
    '3BHK',
    'VILLA',
    'INDEPENDENT HOUSE'
  ];

  List categoryList2 = [
    'SHOP',
    'SHOWROOM',
    'GODOWN',
    'OFFICE',
    'AGRICULTURE LAND',

  ];

  List<PropertyData>? getPropertyModel;
  Future<void> GetProperty() async {
    setProgress(true);
    var headers = {
      'Accept-Encoding': 'gzip,deflat,br',
      'Connection': 'keep alive',
      'Accept': 'application/json',
      'Cookie': 'ci_session=2hvjhphqe7lbro8oa1cmh8usivopnfaj'
    };
    var request = http.Request('GET', Uri.parse('https://dhoondle.com/Dhoondle/api/property/index'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var Result = await response.stream.bytesToString();
      final finalResult =  GetPropertyModel.fromJson(json.decode(Result));
      setState(() {
        getPropertyModel = finalResult.data;
        print('--------------${getPropertyModel?.first.id}');
        setProgress(false);
      });
    }
    else {
      setProgress(true);
      print(response.reasonPhrase);
    }


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
              // itemCount: _getPropertyCategoryModel!.categoryList.length,
              itemCount: 4,

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
        print("-------------success------------");
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

  bool _isVisible = false;
  setProgress(bool show) {
    if (mounted)
      setState(() {
        _isVisible = show;
      });
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
