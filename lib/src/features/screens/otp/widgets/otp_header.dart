import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/images.dart';

class Otpheader extends StatelessWidget {
  const Otpheader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 60),
          child: Image.asset(Images.logo),
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          "Enter OTP",
          style: GoogleFonts.roboto(
            textStyle: Theme.of(context).textTheme.displayLarge,
            fontSize: 30,
            color: AppColors.HeaderTextColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}