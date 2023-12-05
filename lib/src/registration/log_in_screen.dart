import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhoondle/src/constants/helper/session.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:pinput/pinput.dart';
import '../api_model/login_api_model.dart';
import '../constants/Api.dart';
import '../constants/colors.dart';
import '../constants/helper.dart';
import '../features/screens/signup/widgets/signup_header.dart';
import '../webview.dart';
import 'otp_screen.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _formKey = GlobalKey<FormState>();
  final isValid = RxBool(false);
  bool _isVisible = false;
  var textValue = 0.obs;
  TextEditingController numberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(top: 60),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          SignupHeader(
                            header: getTranslated(context, 'Login'),
                            description: getTranslated(context, 'Please login to your account'),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color.fromARGB(147, 193, 192, 192)
                                          .withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: const Offset(
                                      0, 2), // changes the shadow direction
                                ),
                              ],
                            ),
                            child: TextFormField(
                              controller: numberController,
                              keyboardType: TextInputType.phone,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(10),
                              ],
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                hintText: getTranslated(context, 'Mobile'),
                                border: InputBorder.none,
                                fillColor: AppColors.FillColor,
                                filled: true,
                                hintStyle: GoogleFonts.lato(
                                    color: AppColors.HintTextColor),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Obx(() => textValue.value == 1
                                ? Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      getTranslated(context, 'Please enter your number'),
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 220, 62, 50),
                                          fontSize: 12),
                                    ),
                                  )
                                : textValue.value == 2
                                    ? Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          getTranslated(context, 'Number must be equal to 10 digits'),
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 220, 62, 50),
                                              fontSize: 12),
                                        ))
                                    : textValue.value == 0
                                        ? Container()
                                        : Container()),
                          ),
                          SizedBox(
                            height: Get.height * .03,
                          ),
                          //form section
                          // Padding(
                          //   padding: const EdgeInsets.all(20.0),
                          //   child: SizedBox(
                          //     height: 50,
                          //     child: TextFormField(
                          //         controller: numberController,
                          //         keyboardType: TextInputType.phone,
                          //         inputFormatters: [
                          //           LengthLimitingTextInputFormatter(10),
                          //         ],
                          //         textInputAction: TextInputAction.done,
                          //         decoration: InputDecoration(
                          //           fillColor: AppColors.FillColor,
                          //           filled: true,
                          //           hintText: "Mobile",
                          //           hintStyle: GoogleFonts.lato(
                          //               color: AppColors.HintTextColor),
                          //           focusedBorder: const OutlineInputBorder(
                          //             borderRadius:
                          //                 BorderRadius.all(Radius.circular(24)),
                          //             borderSide: BorderSide(
                          //                 width: 1, color: Color(0xffBFBFBF)),
                          //           ),
                          //           disabledBorder: const OutlineInputBorder(
                          //             borderRadius:
                          //                 BorderRadius.all(Radius.circular(24)),
                          //             borderSide: BorderSide(
                          //                 width: 1, color: Color(0xffBFBFBF)),
                          //           ),
                          //           enabledBorder: const OutlineInputBorder(
                          //             borderRadius:
                          //                 BorderRadius.all(Radius.circular(24)),
                          //             borderSide: BorderSide(
                          //                 width: 1, color: Color(0xffBFBFBF)),
                          //           ),
                          //           border: const OutlineInputBorder(
                          //               borderRadius: BorderRadius.all(
                          //                   Radius.circular(24)),
                          //               borderSide: BorderSide(
                          //                 width: 1,
                          //               )),
                          //           errorBorder: const OutlineInputBorder(
                          //               borderRadius: BorderRadius.all(
                          //                   Radius.circular(24)),
                          //               borderSide: BorderSide(
                          //                   width: 1,
                          //                   color: Color(0xffBFBFBF))),
                          //           focusedErrorBorder:
                          //               const OutlineInputBorder(
                          //                   borderRadius: BorderRadius.all(
                          //                       Radius.circular(24)),
                          //                   borderSide: BorderSide(
                          //                       width: 1,
                          //                       color: Color(0xffBFBFBF))),
                          //         ),
                          //         // onChanged: (value) {
                          //         //
                          //         //   numberController.validatePhoneNumber(value);
                          //         // },
                          //         validator: (value) {
                          //           if (value!.isEmpty) {
                          //             return ("Please enter your number");
                          //           } else if (value.length != 10) {
                          //             return ("Number must be equal to 10 digits");
                          //           }
                          //         }),
                          //   ),
                          // ),

                          // SizedBox(
                          //   height: MediaQuery.of(context).size.height * 0.02,
                          // ),

                          MaterialButton(
                            onPressed: () {
                              // if (numberController.length == 10) {
                              //   textValue.value = 0;
                              // }
                              if (numberController.text.isNotEmpty) {
                                if (numberController.text.length >= 10) {
                                  _formKey.currentState!.save();

                                  Helper.checkInternet(
                                      phoneCheckWithFirebase());
                                } else {
                                  textValue.value = 2;
                                }
                              } else {
                                textValue.value = 1;
                              }
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();

                                Helper.checkInternet(phoneCheckWithFirebase());
                              }
                            },
                            color: AppColors.NewButtonColor,
                            textColor: Colors.black,
                            minWidth: 320,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            child: Text(
                              getTranslated(context, 'LOGIN'),
                              style: GoogleFonts.lato(
                                textStyle:
                                    Theme.of(context).textTheme.displayLarge,
                                fontSize: 16,
                                color: AppColors.ButtonTextColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width - 40,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(getTranslated(context, "By continuing, you agree to the"),
                                      style: GoogleFonts.lato(
                                          fontSize: 14,
                                          color: AppColors.HintTextColor,
                                          fontWeight: FontWeight.w400)),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  InkWell(
                                    onTap: () => {
                                      HelperClass.moveToScreenwithPush(
                                          context, Terms())
                                    },
                                    child: Text(getTranslated(context, "Privacy Policy"),
                                        style: GoogleFonts.lato(
                                            fontSize: 14,
                                            color: AppColors.GreenTextColor,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(getTranslated(context, "Do not have an account"),
                                  style: GoogleFonts.lato(
                                      fontSize: 14,
                                      color: AppColors.HintTextColor,
                                      fontWeight: FontWeight.w400)),
                              const SizedBox(
                                width: 5,
                              ),
                              InkWell(
                                onTap: () => {Get.toNamed('/signup')},
                                child: Text(getTranslated(context, "Signup"),
                                    style: GoogleFonts.lato(
                                        fontSize: 14,
                                        color: AppColors.GreenTextColor,
                                        fontWeight: FontWeight.w500)),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(child: Helper.getProgressBar(context, _isVisible))
          ],
        ),
      ),
    );
  }

  // void validatePhoneNumber(String value) {
  //   // Implement your validation logic here
  //   if (value.length == 10) {
  //     isValid.value = true;
  //
  //   } else {
  //     isValid.value = false;
  //   }
  //
  // }
  // void checkLogin() {
  //   if (_formKey.currentState != null) {
  //     if (_formKey.currentState!.validate()) {
  //       // Validation passed, you can proceed with your logic here
  //       _formKey.currentState!.save();
  //
  //     }
  //   }
  // }

  setProgress(bool show) {
    setState(() {
      _isVisible = show;
    });
  }

  login(String verificationId, int? forceResendingToken) async {
    setProgress(true);
    print("================login api=============");
    try {
      final response = await post(Uri.parse(Api.login), body: {
        'number': numberController.text.toString(),
        'device_token': "13446"
      });
      var data = jsonDecode(response.body);

      print(response.statusCode);
      print(data);

      if (response.statusCode == 200) {
        LoginOtp model = LoginOtp.fromJson(data);
        if (model.status == 'true') {
          // Get.snackbar('Your otp is',model!.data!.otp.toString());

          // Helper.moveToScreenwithPush(context, OtpScreen(verificationId: '', number: '', forceResendingToken: null, afterSignUp: null,));
          Helper.moveToScreenwithPush(
              context,
              OtpScreen(
                forceResendingToken: forceResendingToken,
                number: numberController.text.trim(),
                verificationId: verificationId,
                afterSignUp: true,
              ));
          // Get.toNamed('/otp',arguments: mobileController.value.text.toString());
        } else {
          setProgress(false);
          Get.snackbar(getTranslated(context, 'Something went wrong'), data['message']);
        }
      } else {
        setProgress(false);
        Get.snackbar('Exception', getTranslated(context, 'something went wrong'));
      }
    } catch (e) {
      setProgress(false);
      Get.snackbar('Exception', e.toString());
    }
  }

  Future<void> phoneCheckWithFirebase() async {
    setProgress(true);
    //firebase otp code
    // String phone = "+" + countryCodeCreated + phoneController.text.trim();
    String phone = "+91" + numberController.text.toString();
    //new code start
    final _fireStore = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await _fireStore
        .collection('customer_details')
        .where("customer_phone", isEqualTo: phone)
        .get();
    // final allData =
    // querySnapshot.docs.map((doc) => doc.get('phone')).toList();
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    print('all data length${allData.length}');
    if (allData.length == 0) {
      //new code end
      //firebase otp code
      // String phone = "+" + countryCodeCreated + phoneController.text.trim();
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: phone,
          verificationCompleted: (credential) {
            setProgress(false);
          },
          verificationFailed: (ex) {
            ToastMessage.msg(ex.code.toString());
            log("ex" + ex.code.toString());
            setProgress(false);
          },
          codeSent: (verificationId, forceResendingToken) {
            setProgress(false);
            //API to call

            Helper.checkInternet(login(verificationId, forceResendingToken));
            //  Helper.moveToScreenwithPush(context, OtpVerifyScreen(
            //    forceResendingToken: forceResendingToken,
            //    number: numberController.text.trim(),
            //    verificationId: verificationId,
            //    afterSignUp: true,
            //  ));
          },
          codeAutoRetrievalTimeout: (verificationId) {
            setProgress(false);
          },
          timeout: const Duration(seconds: 30));
      //firebase otp code end
      //firebase otp code end
    } else {
      FirebaseAuth.instance.signOut();
      ToastMessage.msg(getTranslated(context, "No Account found, Please Register First"));
      // Fluttertoast.showToast( msg:"");
      setProgress(false);
    }
  }
}
