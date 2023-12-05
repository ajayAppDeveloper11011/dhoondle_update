import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constants/colors.dart';
import '../../../controllers/signup_controller.dart';
import '../../../models/sign_up_model.dart';

class SignupBottom extends StatelessWidget {
  SignupBottom({
    Key? key,
    required this.model,
  }) : super(key: key);
  final SignupModelfooter model;
  final signUpController = Get.put(SignUpController());
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("By continuing, you agree to the",
                style: GoogleFonts.lato(
                    fontSize: 16,
                    color: AppColors.HintTextColor,
                    fontWeight: FontWeight.w400)),
            SizedBox(
              width: 8,
            ),
            InkWell(
              onTap: () => {Get.toNamed('/Policy')},
              child: Text("Privacy Policy",
                  style: GoogleFonts.lato(
                      fontSize: 16,
                      color: AppColors.RedTextColor,
                      fontWeight: FontWeight.w500)),
            ),
          ],
        ),
        SizedBox(height: 50),
        MaterialButton(
            onPressed: () {
              // if (_formKey.currentState!.validate())
              if (signUpController.isValid.value) {
                signUpController.signUp();
                // Phone number is valid, proceed with your logic
                // For example, you can call an API or navigate to the next screen
              } else {
                Get.snackbar('Enter Valid Number', 'please check phone number');
                // Display an error message or take appropriate action
              }

              // print(signUpController.nameController.value.text.toString());
              // Get.toNamed('/otp');
              // Get.to(LogInScreen());
            },
            color: Color(0xffD70404),
            textColor: Colors.black,
            minWidth: 320,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Text(
              model.footertext,
              style: GoogleFonts.lato(
                textStyle: Theme.of(context).textTheme.displayLarge,
                fontSize: 20,
                color: AppColors.ButtonTextColor,
                fontWeight: FontWeight.bold,
              ),
            )),
        SizedBox(
          height: 100,
        ),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Already have an account?",
                  style: GoogleFonts.lato(
                      fontSize: 16,
                      color: AppColors.HintTextColor,
                      fontWeight: FontWeight.w400)),
              SizedBox(
                width: 8,
              ),
              InkWell(
                onTap: () => {Get.toNamed('/login')},
                child: Text("Log In",
                    style: GoogleFonts.lato(
                        fontSize: 16,
                        color: AppColors.RedTextColor,
                        fontWeight: FontWeight.w500)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
