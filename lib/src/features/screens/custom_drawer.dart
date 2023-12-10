import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/colors.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Column(
          children: [
            SizedBox(
              height:120,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                ),
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsetsDirectional.only(end: 20),
                      height:100,
                      width:90,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              width: 1.0, color:Colors.white)),
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child:Image.asset("assets/images/man.jpg",fit: BoxFit.fill,)

                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height:15),
                        Text('John Luise',
                            style: TextStyle(
                                color:Colors.white,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w600)),
                        SizedBox(height: 2,),
                        Text('johan@gmail.com',
                            style: TextStyle(
                                color:Colors.white,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w600)),
                        SizedBox(height: 2,),
                        Text('6265665522',
                            style: TextStyle(
                                color:Colors.white,
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
                    image:'assets/logo/tasks.png',
                    title: 'Active Plan',
                    subtitle: 'Pro',
                    pressevent: () {},
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        height:10,
                        child: Divider(
                          thickness:1,
                          color:Colors.grey.withOpacity(0.5),
                        )),
                  ),
                  drawerList(
                    image: 'assets/logo/language.png',
                    title: 'Change Language',
                    subtitle: 'English',
                    pressevent: () {
                    Get.offAllNamed('/changeLanguage');
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        height:10,
                        child: Divider(
                          thickness:1,
                          color:Colors.grey.withOpacity(0.5),
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
                        height:10,
                        child: Divider(
                          thickness:1,
                          color:Colors.grey.withOpacity(0.5),
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
                        height:10,
                        child: Divider(
                          thickness:1,
                          color:Colors.grey.withOpacity(0.5),
                        )),
                  ),

                  drawerList(
                    image: 'assets/logo/sharing.png',
                    title: 'Share App',
                    subtitle: 'Dhoondle',
                    pressevent: () {},
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        height:10,
                        child: Divider(
                          thickness:1,
                          color:Colors.grey.withOpacity(0.5),
                        )),
                  ),

                  drawerList(
                    image: 'assets/logo/logout.png',
                    title: 'Log Out',
                    subtitle: 'About Dhoondle',
                    pressevent: () {},
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
            child:Image.asset(
              image,
              width:30,
              color:AppColors.primaryColor,
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
