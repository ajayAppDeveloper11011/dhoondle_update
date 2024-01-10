import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dhoondle/src/features/screens/paymentType/payment_type.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../api_model/logout_api_model.dart';
import '../../api_model/profile_model_api.dart';
import '../../constants/Api.dart';
import '../../constants/colors.dart';
import '../../constants/helper.dart';
import 'edit_profile.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  var isLoading = false.obs;
  String? full_name, user_mob, user_email, user_add;
  final dio = Dio();
  LogoutApiModel? _logoutApiModel;
  ProfileApiModel? _getprofileApi;

  @override
  void initState() {
    // TODO: implement initState

    profileapi();
    super.initState();
  }

  bool _isVisible = false;
  bool _hasData = true;

  setProgress(bool show) {
    if (mounted)
      setState(() {
        _isVisible = show;
      });
  }

  logoutApi() async {
    print("========================logout============");
    isLoading(true);
    final prefs = await SharedPreferences.getInstance();
    var user_id = await prefs.getString('user_id');
    if (user_id == "1") {
      prefs.clear();
    } else {
      prefs.clear();
    }
    var res = await dio.get(Api.logout + "?user_id=${user_id}");
    if (res.statusCode == 200) {
      // Get.toNamed('/bottom');
      // Get.offAndToNamed('/signup');
      Get.offAllNamed("/login");
      isLoading(false);
      var body = jsonDecode(res.toString());
      _logoutApiModel = LogoutApiModel.fromJson(body);
    } else {
      isLoading(true);
      if (kDebugMode) {
        print(res.statusCode.toString());
      }
    }
  }

  Future<void> profileapi() async {
    print("<=============profileapi =============>");

    final prefs = await SharedPreferences.getInstance();
    var user_id = await prefs.getString('user_id');

    setProgress(true);

    try {
      var res = await http.get(
        Uri.parse(Api.getprofile + "?user_id=${user_id}"),
      );
      print("Response ============>" + res.body);

      if (res.statusCode == 200) {
        print("urvashi ============>");
        try {
          final jsonResponse = jsonDecode(res.body);
          ProfileApiModel model = ProfileApiModel.fromJson(jsonResponse);

          if (model.status == "true") {
            print("Model status true");

            setProgress(false);

            setState(() {
              _getprofileApi = model;
              full_name = _getprofileApi!.data.name.toString();
              user_mob = _getprofileApi!.data.mobile.toString();
            });
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

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Column(
          children: [
            _getprofileApi == null
                ? Text('Please Wait....')
                : SizedBox(
                    height: 120,
                    child: DrawerHeader(
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                      ),
                      child: Row(
                        children: [
                          Stack(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsetsDirectional.only(end: 20),
                                height: 100,
                                width: 90,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        width: 1.0, color: Colors.white)),
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50.0),
                                      child: CachedNetworkImage(
                                        imageUrl: _getprofileApi!.data.image,
                                        fit: BoxFit.fill,
                                        height: 100,
                                        width: 100,
                                        placeholder: (context, url) =>
                                            LinearProgressIndicator(
                                          color: Colors.white.withOpacity(0.2),
                                          backgroundColor:
                                              Colors.white.withOpacity(.5),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Container(
                                          height: 100,
                                          width: 100,
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(20),
                                            ),
                                            color: Colors.transparent,
                                          ),
                                          child: Center(
                                              child: Image.asset(
                                            'assets/images/profile_new.png',
                                            height: 100,
                                            width: 100,
                                          )),
                                        ),
                                      )),
                                ),
                              ),
                              Positioned(
                                top: 55,
                                left: 63,
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(40)),
                                  child: InkWell(
                                      onTap: () {
                                        Get.offAll(EditProfileScreen());
                                      },
                                      child: const Icon(
                                        Icons.edit_outlined,
                                        color: AppColors.primaryColor,
                                      )),
                                ),
                              )
                            ],
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 15),
                              Text(
                                  '${full_name != null ? full_name.toString() : 'Ajay Malviya'}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Lato',
                                      fontWeight: FontWeight.w600)),
                              // SizedBox(height: 2,),
                              // Text(user_email==""?'':'${user_email}',
                              //     style: TextStyle(
                              //         color:Colors.white,
                              //         fontFamily: 'Lato',
                              //         fontWeight: FontWeight.w600)),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                  '${user_mob != null ? user_mob : '9878xxxxxx'}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Lato',
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              child: ListView(
                children: [
                  // drawerList(
                  //   // icon: 'assets/icon/homicon.svg',
                  //   title: 'Home',
                  //   subtitle: 'Offers, Top Deals',
                  //   pressevent: () {},
                  // ),
                  // drawerList(
                  //   // icon: 'assets/icon/drawricon1.svg',
                  //   title: 'Search by Category',
                  //   subtitle: 'Men, Women, Kids, Family',
                  //   pressevent: () {},
                  // ),
                  // drawerList(
                  //   // icon: 'assets/icon/drawricon2.svg',
                  //   title: 'Orders',
                  //   subtitle: 'Recent Orders',
                  //   pressevent: () {},
                  // ),
                  // drawerList(
                  //   // icon: 'assets/icon/drawricon3.svg',
                  //   title: 'Your Wishlist',
                  //   subtitle: 'Your Save Properties',
                  //   pressevent: () {},
                  // ),
                  // drawerList(
                  //   // icon: 'assets/icon/drawricon7.svg',
                  //   title: 'Your Account',
                  //   subtitle: 'Profile, Settings',
                  //   pressevent: () {},
                  // ),
                  // drawerList(
                  //   // icon: 'assets/icon/drawricon5.svg',
                  //   title: 'Notification',
                  //   subtitle: 'Offers, New Properties',
                  //   pressevent: () {},
                  // ),
                  drawerList(
                    image: 'assets/logo/tasks.png',
                    title: 'Active Plan',
                    subtitle: 'Pro',
                    pressevent: () {
                      Get.toNamed('/planscreen');
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        height: 10,
                        child: Divider(
                          thickness: 1,
                          color: Colors.grey.withOpacity(0.5),
                        )),
                  ),
                  drawerList(
                    image: 'assets/logo/language.png',
                    title: 'Change Language',
                    subtitle: 'English',
                    pressevent: () {
                      Get.toNamed('/changeLanguage');
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        height: 10,
                        child: Divider(
                          thickness: 1,
                          color: Colors.grey.withOpacity(0.5),
                        )),
                  ),
                  drawerList(
                    image: 'assets/logo/white-logo.png',
                    title: 'About App',
                    subtitle: 'Dhoondle',
                    pressevent: () {},
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        height: 10,
                        child: Divider(
                          thickness: 1,
                          color: Colors.grey.withOpacity(0.5),
                        )),
                  ),
                  drawerList(
                    image: 'assets/logo/support.png',
                    title: 'Help Center',
                    subtitle: 'About Dhoondle',
                    pressevent: () {},
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        height: 10,
                        child: Divider(
                          thickness: 1,
                          color: Colors.grey.withOpacity(0.5),
                        )),
                  ),

                  drawerList(
                    image: 'assets/logo/sharing.png',
                    title: 'Share App',
                    subtitle: 'Dhoondle',
                    pressevent: () {
                      Share.share(
                          'https://play.google.com/store/apps/details?id=com.mojang.minecraftpe&hl=en&gl=US');
                    },
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        height: 10,
                        child: Divider(
                          thickness: 1,
                          color: Colors.grey.withOpacity(0.5),
                        )),
                  ),

                  drawerList(
                    image: 'assets/logo/logout.png',
                    title: 'Log Out',
                    subtitle: 'About Dhoondle',
                    pressevent: () {
                      logoutApi();
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}

class drawerList extends StatelessWidget {
  const drawerList({
    Key? key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.pressevent,
  }) : super(key: key);

  final String image;
  final String title;
  final String subtitle;
  final VoidCallback pressevent;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: GestureDetector(
        onTap: pressevent,
        child: ListTile(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          minLeadingWidth: 0,
          leading: Container(
            height: double.infinity,
            child: Image.asset(
              image,
              width: 30,
              color: AppColors.primaryColor,
            ),
          ),
          title: Text(title,
              style: GoogleFonts.lato(
                  fontSize: 14,
                  color: AppColors.textcolor,
                  fontWeight: FontWeight.w500)),
          subtitle: Text(subtitle,
              style: GoogleFonts.lato(
                  fontSize: 12,
                  color: AppColors.greycolor,
                  fontWeight: FontWeight.w400)),
        ),
      ),
    );
  }
}
