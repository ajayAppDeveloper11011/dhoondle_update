import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

import '../../../controllers/otp_controller.dart';

class OtpForm extends StatelessWidget {
  OtpForm({
    Key? key,
    required GlobalKey<FormState> formKey,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final otpContoller = Get.put(OtpController());

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Pinput(
            controller: otpContoller.otpController.value,
            length: 6,
            obscureText: false,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "OTP expires in : 53 sec",
            style: GoogleFonts.lato(
              textStyle: Theme.of(context).textTheme.displayLarge,
              fontSize: 19,
              color: Color(0xff1D1D1D),
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}
