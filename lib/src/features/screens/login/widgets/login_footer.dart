// import 'dart:math';
//
// import 'package:dhoondle/src/constants/helper.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import '../../../../constants/colors.dart';
// import '../../../../webview.dart';
// import '../../../controllers/login_controller.dart';
//
// class FooterLogin extends StatelessWidget {
//
//    FooterLogin({
//     Key? key,
//   }) : super(key: key);
//   final loginController=Get.put(LoginController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         MaterialButton(
//           onPressed: () {
//             if (loginController.isValid.value) {
//               loginController.login();
//               // Phone number is valid, proceed with your logic
//               // For example, you can call an API or navigate to the next screen
//             } else {
//               Get.snackbar('Enter Valid Number', 'please check phone number');
//               // Display an error message or take appropriate action
//             }
//
//             // loginController.isValid();
//             // if(loginController.validateData() == true){
//             //   loginController.login();
//             // }
//             // else{
//             //   Get.snackbar('Phone not valid', 'mobile number should be greater than 10 in length');
//             // }
//
//            //  print(loginController.validateData());
//            //  if(loginController.validateData()==true){
//            //    loginController.login();
//            //  }
//            //
//            // else{
//            //   print("nothing");
//            //  }
//             // Get.to(OtpScreen());
//             // Get.toNamed('/otp');
//           },
//           color: AppColors.ButtonColor,
//           textColor: Colors.black,
//           minWidth: 320,
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12)),
//           padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//           child: Text(
//             'Log In',
//             style: GoogleFonts.roboto(
//               textStyle: Theme.of(context).textTheme.displayLarge,
//               fontSize: 20,
//               color: AppColors.ButtonTextColor,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//         SizedBox(
//           height: MediaQuery.of(context).size.height*0.03,
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text("By continuing, you agree to the",
//                 style: GoogleFonts.roboto(
//                     fontSize: 16,
//                     color: AppColors.HintTextColor,
//                     fontWeight: FontWeight.w400)),
//             SizedBox(
//               width: 8,
//             ),
//             InkWell(
//               onTap: () => {
//                 HelperClass.moveToScreenwithPush(context, Terms())
//               },
//               child: Text("Privacy Policy",
//                   style: GoogleFonts.roboto(
//                       fontSize: 16,
//                       color: AppColors.RedTextColor,
//                       fontWeight: FontWeight.w500)),
//             ),
//           ],
//         ),
//         SizedBox(
//           height: MediaQuery.of(context).size.height*0.25,
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text("Do not have an account",
//                 style: GoogleFonts.roboto(
//                     fontSize: 16,
//                     color: AppColors.HintTextColor,
//                     fontWeight: FontWeight.w400)),
//             SizedBox(
//               width: 5,
//             ),
//             InkWell(
//               onTap: () => {
//                 Get.toNamed('/signup')
//               },
//               child: Text("Signup",
//                   style: GoogleFonts.roboto(
//                       fontSize: 16,
//                       color: AppColors.RedTextColor,
//                       fontWeight: FontWeight.w500)),
//             ),
//           ],
//         )
//       ],
//     );
//   }
// }