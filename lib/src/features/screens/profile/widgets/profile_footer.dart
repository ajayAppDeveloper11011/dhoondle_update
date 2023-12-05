import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/helper.dart';
import '../../../../constants/text.dart';
import '../../../../webview.dart';
import '../../../controllers/logout_controller.dart';
import '../../about_us.dart';
import '../../help.dart';
import '../../privacy_policy.dart';
import '../../services_tabbar.dart';

class ProfileFooter extends StatelessWidget {
  ProfileFooter({
    Key? key,
  }) : super(key: key);
  final logoutController = Get.put(LogOutController());
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => {
            Helper.moveToScreenwithPush(context, ServicesTabbar())
            // Get.toNamed('/becomeservice')
            // Get.to(BecomeServiceProvider())
            // becomeservice
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            // height: 40,
            child: Text(TextScreen.become,
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                      color: AppColors.txtgreyclr,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                )),
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(vertical: 15.0),
        //   child: Divider(
        //     color: Color(0xffB8B8B8),
        //   ),
        // ),
        // Text(TextScreen.transaction,
        //     style: GoogleFonts.lato(
        //       textStyle: TextStyle(
        //           color: AppColors.txtgreyclr,
        //           fontSize: 16,
        //           fontWeight: FontWeight.w400),
        //     )),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Divider(
            color: Color(0xffB8B8B8),
          ),
        ),
        InkWell(
          onTap: () {
            HelperClass.moveToScreenwithPush(context, Terms());
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Text(TextScreen.term,
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                      color: AppColors.txtgreyclr,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                )),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Divider(
            color: Color(0xffB8B8B8),
          ),
        ),
        InkWell(
          onTap: () {
            HelperClass.moveToScreenwithPush(context, HelpScreen());
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Text(TextScreen.help,
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                      color: AppColors.txtgreyclr,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                )),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Divider(
            color: Color(0xffB8B8B8),
          ),
        ),
        InkWell(
          onTap: () {
            HelperClass.moveToScreenwithPush(context, Aboutscreen());
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Text(TextScreen.about_us,
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                      color: AppColors.txtgreyclr,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                )),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Divider(
            color: Color(0xffB8B8B8),
          ),
        ),
        InkWell(
          onTap: () => {logoutController.logoutApi()},
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Text(TextScreen.log_out,
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                )),
          ),
        ),
      ],
    );
  }
}
