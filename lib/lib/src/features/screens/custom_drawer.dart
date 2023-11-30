import 'package:flutter/material.dart';
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
              height: 80,
              child: DrawerHeader(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                ),
                child: ListTile(
                  leading: Container(
                    padding: EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: const Color.fromARGB(175, 179, 240, 224)),
                    child: ClipOval(
                        child: Image.asset('assets/logo/white-logo.png')),
                  ),
                  title: Text('Hello, XYZ',
                      style: TextStyle(
                          color: Color.fromARGB(255, 70, 68, 68),
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w600)),
                  trailing: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        size: 17,
                        color: AppColors.greycolor,
                      )),
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
                    // icon: 'assets/icon/fill1.svg',
                    title: 'Active Plan',
                    subtitle: 'Pro',
                    pressevent: () {},
                  ),

                  drawerList(
                    // icon: 'assets/icon/drawricon6.svg',
                    title: 'Language',
                    subtitle: 'English',
                    pressevent: () {},
                  ),
                  drawerList(
                    // icon: 'assets/icon/drawricon.svg',
                    title: 'About us',
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
    // required this.icon,
    required this.title,
    required this.subtitle,
    required this.pressevent,
  }) : super(key: key);

  // final String icon;
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
          // leading: Container(
          //   height: double.infinity,
          //   child: SvgPicture.asset(
          //     icon,
          //     width: 20,
          //   ),
          // ),
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
