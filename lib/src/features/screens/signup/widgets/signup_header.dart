import 'package:dhoondle/src/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../constants/images.dart';

class SignupHeader extends StatelessWidget {
  SignupHeader({
    Key? key,
    // required this.model,
    required this.header,
    required this.description,
  }) : super(key: key);
  // final SignupModel model;
  final header;
  final description;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          Images.logo,
          height: 100,
          width: 100,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(header,
            style: GoogleFonts.lato(
                fontSize: 20,
                color: AppColors.NewHeaderTextColor,
                fontWeight: FontWeight.w600)),
        const SizedBox(
          height: 6.0,
        ),
        Text(description,
            style: GoogleFonts.lato(
                fontSize: 16,
                color: AppColors.HintTextColor,
                fontWeight: FontWeight.w400)),
      ],
    );
  }
}
