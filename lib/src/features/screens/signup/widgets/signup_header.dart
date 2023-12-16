import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constants/images.dart';
import '../../../../registration/signup.dart';
import '../../../models/sign_up_model.dart';

class SignupHeader extends StatelessWidget {
  const SignupHeader({
    Key? key, required this.model,
  }) : super(key: key);
 final SignupModel model;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(Images.logo,height: 100,width: 100,),
        SizedBox(height: 20,),
        Text(model.headertext ,
          style: GoogleFonts.roboto(
            textStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 30),
          ),),
      ],
    );
  }
}