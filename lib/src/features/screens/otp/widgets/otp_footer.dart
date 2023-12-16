import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constants/colors.dart';
import '../../../controllers/otp_controller.dart';

class OtpFooter extends StatelessWidget {
   OtpFooter({
    Key? key,
     required this.number
  }) : super(key: key);
   String number='';
  final otpController=Get.put(OtpController());
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MaterialButton(
            onPressed: () {
              otpController.otpApi(number);
              // Get.to(BottomNaigation());

            },
            color: AppColors.ButtonColor,
            textColor: Colors.black,
            minWidth: 320,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13)),
            padding:
            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Text("Submit",
                style: GoogleFonts.roboto(
                    fontSize: 18,
                    color: AppColors.ButtonTextColor,
                    fontWeight: FontWeight.w500))),
        SizedBox(
          height: 30,
        ),
        Text("Resend",
            style: GoogleFonts.roboto(
                fontSize: 20,
                color: AppColors.HeaderTextColor,
                fontWeight: FontWeight.w500)),
      ],
    );
  }
}