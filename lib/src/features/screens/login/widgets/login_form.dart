import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constants/colors.dart';
import '../../../controllers/login_controller.dart';

class LoginForm extends StatelessWidget {
  LoginForm({
    Key? key,
    required GlobalKey<FormState> formKey,
  }) : _formKey = formKey, super(key: key);

  final GlobalKey<FormState> _formKey;
  final loginController = Get.put(LoginController());
  void onClose() {
    loginController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    loginController.mobileController.value=='';
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child:Obx(
                ()=>TextFormField(
                controller: loginController.mobileController.value,
                keyboardType: TextInputType.phone,
                    inputFormatters: [
                        LengthLimitingTextInputFormatter(10),
                      ],
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        fillColor: AppColors.FillColor,
                        filled: true,
                        hintText: "Mobile",
                        hintStyle:
                        GoogleFonts.roboto(color: AppColors.HintTextColor),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide:
                          BorderSide(width: 1, color: Color(0xffBFBFBF)),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide:
                          BorderSide(width: 1, color: Color(0xffBFBFBF)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide:
                          BorderSide(width: 1, color: Color(0xffBFBFBF)),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide(
                              width: 1,
                            )),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide:
                            BorderSide(width: 1, color: Color(0xffBFBFBF))),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide:
                            BorderSide(width: 1, color: Color(0xffBFBFBF))),
                      ),
                onChanged: (value) {

                  loginController.validatePhoneNumber(value);
                },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter a mobile number";
                      } else if (!GetUtils.isPhoneNumber(value)) {
                        return "Mobile number is not valid";
                      }
                      return null;
                    },
              ),
            ),

            // TextFormField(
            //   inputFormatters: [
            //     LengthLimitingTextInputFormatter(10),
            //   ],
            //   textInputAction: TextInputAction.done,
            //   keyboardType: TextInputType.number,
            //   controller: loginController.mobileController.value,
            //   decoration: InputDecoration(
            //     fillColor: AppColors.FillColor,
            //     filled: true,
            //     hintText: "Mobile",
            //     hintStyle:
            //     GoogleFonts.roboto(color: AppColors.HintTextColor),
            //     focusedBorder: OutlineInputBorder(
            //       borderRadius: BorderRadius.all(Radius.circular(15)),
            //       borderSide:
            //       BorderSide(width: 1, color: Color(0xffBFBFBF)),
            //     ),
            //     disabledBorder: OutlineInputBorder(
            //       borderRadius: BorderRadius.all(Radius.circular(15)),
            //       borderSide:
            //       BorderSide(width: 1, color: Color(0xffBFBFBF)),
            //     ),
            //     enabledBorder: OutlineInputBorder(
            //       borderRadius: BorderRadius.all(Radius.circular(15)),
            //       borderSide:
            //       BorderSide(width: 1, color: Color(0xffBFBFBF)),
            //     ),
            //     border: OutlineInputBorder(
            //         borderRadius: BorderRadius.all(Radius.circular(15)),
            //         borderSide: BorderSide(
            //           width: 1,
            //         )),
            //     errorBorder: OutlineInputBorder(
            //         borderRadius: BorderRadius.all(Radius.circular(15)),
            //         borderSide:
            //         BorderSide(width: 1, color: Color(0xffBFBFBF))),
            //     focusedErrorBorder: OutlineInputBorder(
            //         borderRadius: BorderRadius.all(Radius.circular(15)),
            //         borderSide:
            //         BorderSide(width: 1, color: Color(0xffBFBFBF))),
            //   ),
            //   validator: (value) {
            //     if (value == null || value.isEmpty) {
            //       return "Please enter a mobile number";
            //     } else if (!GetUtils.isPhoneNumber(value)) {
            //       return "Mobile number is not valid";
            //     }
            //     return null;
            //   },
            // ),
          ),
        ],
      ),
    );
  }
}


// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import '../../../../constants/colors.dart';
// import '../../../controllers/login_controller.dart';
//
// class LoginForm extends StatelessWidget {
//    LoginForm({
//     Key? key,
//     required GlobalKey<FormState> formKey,
//   }) : _formKey = formKey, super(key: key);
//
//   final GlobalKey<FormState> _formKey;
//   final loginController= Get.put(LoginController());
//
//   @override
//   Widget build(BuildContext context) {
//     var mobile=loginController.mobileController.value;
//     return Form(
//       key: _formKey,
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: TextFormField(
//               inputFormatters: [
//                 LengthLimitingTextInputFormatter(10),
//               ],
//               textInputAction: TextInputAction.done,
//               keyboardType: TextInputType.number,
//               controller: loginController.mobileController.value,
//               //obscureText: true,
//               decoration: InputDecoration(
//                 fillColor: AppColors.FillColor,
//                 filled: true,
//                 hintText: "Mobile",
//                 hintStyle:
//                 GoogleFonts.roboto(color: AppColors.HintTextColor),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(15)),
//                   borderSide:
//                   BorderSide(width: 1, color: Color(0xffBFBFBF)),
//                 ),
//                 disabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(15)),
//                   borderSide:
//                   BorderSide(width: 1, color: Color(0xffBFBFBF)),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(15)),
//                   borderSide:
//                   BorderSide(width: 1, color: Color(0xffBFBFBF)),
//                 ),
//                 border: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(15)),
//                     borderSide: BorderSide(
//                       width: 1,
//                     )),
//                 errorBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(15)),
//                     borderSide:
//                     BorderSide(width: 1, color: Color(0xffBFBFBF))),
//                 focusedErrorBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(15)),
//                     borderSide:
//                     BorderSide(width: 1, color: Color(0xffBFBFBF))),
//                 // border: OutlineInputBorder(
//                 //     borderRadius: BorderRadius.circular(20),
//                 //     borderSide: new BorderSide(color: Color(0xffBFBFBF))
//                 // )
//               ),
//
//
//                 // onSaved: (value) {
//                 //   loginController.password = value!;
//                 // },
//                 validator: (value) {
//                   // return loginController.validatemobile(value!);
//                   if(GetUtils.isPhoneNumber(value!)){
//                     Get.snackbar('null', 'null');
//                   }
//                   Get.snackbar('s', 'ss');
//                 },
//
//
//
//
//               // validator:  (phone){
//               //     if (phone!.isEmpty) {
//               //       return "Please enter phone number";
//               //       // ToastMessage.msg("Please enter phone number");
//               //     } else if (phone.length != 10) {
//               //       return "Mobile Number must be of 10 digit";
//               //       // ToastMessage.msg("Mobile Number must be of 10 digit");
//               //     }
//               //   }
//
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }