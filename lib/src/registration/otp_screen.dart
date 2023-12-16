import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';

import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/Api.dart';
import '../constants/colors.dart';
import '../constants/helper.dart';
import '../constants/images.dart';
import '../features/screens/bottomNavigation.dart';
import '../features/screens/otp/widgets/otp_footer.dart';
import '../features/screens/otp/widgets/otp_form.dart';
import '../features/screens/otp/widgets/otp_header.dart';
import 'log_in_screen.dart';

class OtpScreen extends StatefulWidget {
  String number = "";
  String verificationId;
  bool afterSignUp;
  int? forceResendingToken;
  OtpScreen({required this.number, required this.forceResendingToken, required this.verificationId,
    required this.afterSignUp});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController otpController = TextEditingController();
  bool isValidated = false;
  final _formKey = GlobalKey<FormState>();
  var number= Get.arguments;
  bool _isVisible = false;
  Timer? _timer;
  int _start = 60;
  bool resend_visible=false;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          setState(() {
            resend_visible=true;
            timer.cancel();

          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    //otp header section
                    Otpheader(),

                    SizedBox(
                      height: 40,
                    ),

                    // OTPTextField(
                    //     //controller: otpController,
                    //     length: 5,
                    //
                    //
                    //     width: MediaQuery.of(context).size.width*0.7,
                    //     textFieldAlignment: MainAxisAlignment.spaceAround,
                    //     fieldWidth: 30,
                    //
                    //     fieldStyle: FieldStyle.underline,
                    //     outlineBorderRadius: 15,
                    //     style: TextStyle(fontSize: 17,),
                    //    ),

                    /* OTPTextField(

                      length: 5,

                      width: MediaQuery.of(context).size.width*0.6,


                      fieldWidth: 30,
                      style: TextStyle(
                          fontSize: 17,


                      ),
                      textFieldAlignment: MainAxisAlignment.spaceAround,
                      fieldStyle: FieldStyle.underline,

                      onCompleted: (pin) {
                        print("Completed: " + pin);
                      },
                    ),*/
                    // OtpTextField(
                    //   numberOfFields: 5,
                    //   borderColor: Color(0xff878787),
                    //   focusedBorderColor: Color(0xff878787),
                    //   // styles: otpTextStyles,
                    //   showFieldAsBox: false,
                    //   borderWidth: 4.0,
                    //   //runs when a code is typed in
                    //   onCodeChanged: (String code) {
                    //     //handle validation or checks here if necessary
                    //   },
                    //   //runs when every textfield is filled
                    //   onSubmit: (String verificationCode) {},
                    // ),
                    //otp form section
                    Pinput(

                      length: 6,//4
                      // Without Validator
                      // If true error state will be applied no matter what validator returns
                      forceErrorState: true,
                      // Text will be displayed under the Pinput
                      errorText: '',
                      /// ------------
                      /// With Validator
                      /// Auto validate after user tap on keyboard done button, or completes Pinput
                      pinputAutovalidateMode:
                      PinputAutovalidateMode.onSubmit,
                      validator: (pin) {
                        if (pin!.length > 6) return null;//4
                        /// Text will be displayed under the Pinput
                        return 'Pin is incorrect';
                      },
                      onCompleted: (value) => {
                        Helper.checkInternet(otpVerificationFirebase()),
                      },
                      controller: otpController,
                      // focusedPinTheme: defaultPinTheme.copyWith(
                      //   decoration: defaultPinTheme.decoration!.copyWith(
                      //     borderRadius: BorderRadius.circular(10),
                      //     border: Border.all(color: AppColors.primaryColor,
                      //         width: 1),
                      //   ),
                      // ),
                      // submittedPinTheme: defaultPinTheme.copyWith(
                      //   decoration: defaultPinTheme.decoration!.copyWith(
                      //     color: fillColor,
                      //     borderRadius: BorderRadius.circular(10),
                      //     border: Border.all(color: AppColors.primaryColor,width:1),
                      //   ),
                      // ),
                      // errorPinTheme: defaultPinTheme.copyBorderWith(
                      //   border: Border.all(color:AppColors.primaryColor),
                      // ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Text("Didn’t receive any code? ",
                          //   style: GoogleFonts.poppins(
                          //       color: Color(0xFFDEDEDE),
                          //       fontSize: 13,
                          //       fontWeight: FontWeight.w600
                          //   ),
                          // ),
                          // SizedBox(
                          //   width: 2,
                          // ),
                          // Padding(
                          //   padding: const EdgeInsets.all(5.0),
                          //   child: Row(
                          //     crossAxisAlignment: CrossAxisAlignment.center,
                          //     mainAxisAlignment: MainAxisAlignment.center,
                          //     children: [
                          //       Text("Didn’t receive any code? ",
                          //         style: GoogleFonts.poppins(
                          //             color:  AppColors.primaryColor,
                          //             fontSize: 13,
                          //             fontWeight: FontWeight.w600
                          //         ),
                          //       ),
                          //       SizedBox(
                          //         width: 2,
                          //       ),
                          //       InkWell(
                          //
                          //           onTap:
                          //           _start==0
                          //               ? () {
                          //             _start=300;
                          //             startTimer();
                          //             print("resend botton called");
                          //             resendVerificationCode("+91"+widget.number, widget.forceResendingToken);
                          //           }
                          //               :null,
                          //           child:_start==0? Visibility(
                          //             visible: true,
                          //             maintainAnimation: true,
                          //             maintainSize: true,
                          //             maintainState: true,
                          //             child:  Text("Resend Again",
                          //               style: GoogleFonts.poppins(
                          //                   color:  AppColors.primaryColor,
                          //                   fontSize: 13,
                          //                   fontWeight: FontWeight.bold
                          //               ),
                          //             ),
                          //           )
                          //               :Visibility(
                          //             visible: true,
                          //             maintainAnimation: true,
                          //             maintainSize: true,
                          //             maintainState: true,
                          //             child:  Text("Resend Again",
                          //               style: GoogleFonts.poppins(
                          //                   color:  AppColors.primaryColor,
                          //                   fontSize: 13,
                          //                   fontWeight: FontWeight.w500
                          //               ),
                          //             ),
                          //           )
                          //       ),
                          //
                          //     ],
                          //   ),
                          // ),

                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Otp expires in :",
                          style: GoogleFonts.poppins(
                              color: Color(0xff1D1D1D),
                              fontSize: 17,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                        Text('${(_start/60).floor()}'.padLeft(2, '0')+':'+'${_start%60}'.padLeft(2, '0') + "${" mins"}" ,
                          style: GoogleFonts.poppins(
                              color: Color(0xff1D1D1D),
                              fontSize: 17,
                              fontWeight: FontWeight.w400
                          ),),

                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    //otp footer section
                    MaterialButton(
                        onPressed: () {
                          otpVerificationFirebase();
                          // otpController.otpApi();
                          // Get.to(BottomNaigation());

                        },
                        color: AppColors.primaryColor,
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
                                fontWeight: FontWeight.w500))
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    InkWell(

                        onTap:
                        _start==0
                            ? () {
                          _start=300;
                          startTimer();
                          print("resend botton called");
                          resendVerificationCode("+91"+widget.number, widget.forceResendingToken);
                        }
                            :null,
                        child:_start==0? Visibility(
                          visible: true,
                          maintainAnimation: true,
                          maintainSize: true,
                          maintainState: true,
                          child:  Text("Resend",
                              style: GoogleFonts.roboto(
                                  fontSize: 20,
                                  color: Color(0xff1D1D1D),
                                  fontWeight: FontWeight.w500)
                          ),
                        )
                            :Visibility(
                          visible: true,
                          maintainAnimation: true,
                          maintainSize: true,
                          maintainState: true,
                          child:  Text("Resend",
                              style: GoogleFonts.roboto(
                                  fontSize: 20,
                                  color: Color(0xff1D1D1D),
                                  fontWeight: FontWeight.w500)
                          ),
                        )
                    ),
                  ],
                ),
              ),
            ),
            Positioned(child: Helper.getProgressBar(context, _isVisible))
          ],
        ),
      ),
    );
  }

  setProgress(bool show) {
    setState(() {
      _isVisible = show;
    });
  }

   otpApi() async{
    print("================otp api=============");
    setProgress(true);
    try{
      final response= await post(Uri.parse(Api.verifyOtp),
          body: {
            'number':widget.number,
            'otp':otpController.text.toString(),
            'device_token':"13446"
          });
      var data = jsonDecode(response.body);
      print(number);
      print(otpController.text.toString());
      print(data);
      if(response.statusCode == 200){
        // Get.snackbar('Your otp is', otpController.value.text.toString());

        if(data['status']== 'true'){
          // print("isverified==>${model.isVerified.toString()}");
          // String customerId = model.userId!;
          // print("customerId===>${customerId}");
          var docRef= FirebaseFirestore.instance.collection("customer_details").doc(data['data']['user_id'].toString());
          docRef.set({
            "customer_id":data['data']['user_id'].toString(),
            "customer_phone": widget.number.toString(),
            "isUserOnline":""
          }).then((_) => print("id stored on firebase"))
              .catchError((error)=>print("failed to add id"));

          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('user_id', data['data']['user_id'].toString());
          print(prefs.get('user_id'));
          Get.toNamed('/bottom');
        }
        else{
          Get.snackbar('Something went wrong', data['message']);
        }
      }
      else{
        Get.snackbar('Exception', 'something went wrong');
      }
    }
    catch(e){
      Get.snackbar('Exception', e.toString());
    }
  }

  Future<void> otpVerificationFirebase() async {
    print("otpVerification===firebase");
    setProgress(true);
    log("otpVerification firebase api calling");
    String otp = otpController.text.trim();
    log("otp=============>$otp");

    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: widget.verificationId,
      smsCode: otp,

    );

    print("sms code 1==>${credential.smsCode.toString()}");
    log("widget.verificationId===============>${widget.verificationId}");
    log("widget.phone===============>${widget.number}");
    try {
      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);
      if (userCredential.user != null) {
        //setProgress(false);
        if (widget.afterSignUp == true) {
          print("sms code 2==>${credential.smsCode.toString()}");
          var userDeatils = FirebaseAuth.instance.currentUser;
          userDeatils!.updatePhoneNumber(credential).toString();
          //userDeatils.updateEmail(widget.email).toString();
          //userDeatils.updateDis3playName(widget.name).toString();

          Fluttertoast.showToast(msg: "Login successful");

          Helper.checkInternet( otpApi());
        } else {

          Fluttertoast.showToast(msg: "login successfully");
          Helper.moveToScreenwithPushreplaceemt(context, LogInScreen());
        }
      }
    } on FirebaseAuthException catch (ex) {
      setProgress(false);
      log("exception 1===>${ex.code.toString()}");
      ToastMessage.msg(ex.code.toString());
    }
  }

  void resendVerificationCode(String phoneNumber, int? token) async{
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (credential) {
          setProgress(false);
        },
        verificationFailed: (ex) {
          log(ex.code.toString());
          setProgress(false);
        },
        codeSent: (verificationId, forceResendingToken) {
          setProgress(false);
          otpVerificationFirebase();
        },
        forceResendingToken:token,

        codeAutoRetrievalTimeout: (verificationId) {
          setProgress(false);
        },

        timeout: Duration(seconds: 300)
    );

  }



}






