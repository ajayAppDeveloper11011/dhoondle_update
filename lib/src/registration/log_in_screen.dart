import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhoondle/src/features/models/sign_up_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart'as http;
import 'package:http/http.dart';
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
  bool _isVisible=false;
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
                    child: Column(
                      children: [
                        //signup header
                        SignupHeader(model: SignupModel(headertext: 'Welcome'),),
                        SizedBox(
                          height: MediaQuery.of(context).size.height*0.04,
                        ),
                        //form section
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: TextFormField(
                            controller: numberController,
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
                            // onChanged: (value) {
                            //
                            //   numberController.validatePhoneNumber(value);
                            // },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return ("Please enter your number");
                                }
                                else if (value.length != 10) {
                                  return ("Number must be equal to ten digits");
                                }
                              }
                          ),
                        ),


                        SizedBox(
                          height: MediaQuery.of(context).size.height*0.03,
                        ),

                        //footer section
                        MaterialButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              Helper.checkInternet( login());

                              // Helper.checkInternet(phoneCheckWithFirebase());
                            }
                            // if (loginController.isValid.value) {
                            //   loginController.login();
                            //   // Phone number is valid, proceed with your logic
                            //   // For example, you can call an API or navigate to the next screen
                            // } else {
                            //   Get.snackbar('Enter Valid Number', 'please check phone number');
                            //   // Display an error message or take appropriate action
                            // }

                            // loginController.isValid();
                            // if(loginController.validateData() == true){
                            //   loginController.login();
                            // }
                            // else{
                            //   Get.snackbar('Phone not valid', 'mobile number should be greater than 10 in length');
                            // }

                            //  print(loginController.validateData());
                            //  if(loginController.validateData()==true){
                            //    loginController.login();
                            //  }
                            //
                            // else{
                            //   print("nothing");
                            //  }
                            // Get.to(OtpScreen());
                            // Get.toNamed('/otp');
                          },
                          color: AppColors.primaryColor,
                          textColor: Colors.black,
                          minWidth: 320,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          child: Text(
                            'Log In',
                            style: GoogleFonts.roboto(
                              textStyle: Theme.of(context).textTheme.displayLarge,
                              fontSize: 20,
                              color: AppColors.ButtonTextColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height*0.03,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("By continuing, you agree to the",
                                style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    color: AppColors.HintTextColor,
                                    fontWeight: FontWeight.w400)),
                            SizedBox(
                              width: 8,
                            ),
                            InkWell(
                              onTap: () => {
                                HelperClass.moveToScreenwithPush(context, Terms())
                              },
                              child: Text("Privacy Policy",
                                  style: GoogleFonts.roboto(
                                      fontSize: 16,
                                      color: AppColors.RedTextColor,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height*0.25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Do not have an account",
                                style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    color: AppColors.HintTextColor,
                                    fontWeight: FontWeight.w400)),
                            SizedBox(
                              width: 5,
                            ),
                            InkWell(
                              onTap: () => {
                                Get.toNamed('/signup')
                              },
                              child: Text("Signup",
                                  style: GoogleFonts.roboto(
                                      fontSize: 16,
                                      color: AppColors.RedTextColor,
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
  login({String? verificationId, int? forceResendingToken}) async{
    setProgress(true);
    print("================login api=============");
    try{
      final response= await post(Uri.parse(Api.login),
          body: {
            'number':numberController.text.toString(),
            'device_token':"13446"
          }
      );
      var data = jsonDecode(response.body);



      print(response.statusCode);
      print(data);

      if(response.statusCode == 200){
        LoginOtp model = LoginOtp.fromJson(data);
        if(model.status == 'true'){
          // Get.snackbar('Your otp is',model!.data!.otp.toString());
           String otp = model.data!.otp.toString();
           print('----------------kkk----------${otp}');
           // Helper.moveToScreenwithPush(context, OtpScreen(verificationId: '', number: '', forceResendingToken: null, afterSignUp: null,));
          Helper.moveToScreenwithPush(context, OtpScreen(
            forceResendingToken: forceResendingToken,
            number: numberController.text.trim(),
            verificationId: verificationId??'',
            afterSignUp:false,
             otp:otp, signUpOtp: '',
          ));
          // Get.toNamed('/otp',arguments: mobileController.value.text.toString());
        }
        else{
          setProgress(false);
          Get.snackbar('Something went wrong', data['message']);
        }
      }
      else{
        setProgress(false);
        Get.snackbar('Exception', 'something went wrong');
      }
    }
    catch(e){
      setProgress(false);
      Get.snackbar('Exception', e.toString());
    }
  }


  Future<void> phoneCheckWithFirebase() async{
     setProgress(true);
    //firebase otp code
    // String phone = "+" + countryCodeCreated + phoneController.text.trim();
    String phone = "+91" + numberController.text.toString();
    print('-------kkk------${numberController.text}');
    //new code start
    final _fireStore = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await _fireStore.collection('customer_details').where("customer_phone", isEqualTo: phone).get();
    // final allData =
    // querySnapshot.docs.map((doc) => doc.get('phone')).toList();
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    print('all data length${allData.length}');
    if (allData.length==0) {

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
            log("ex"+ ex.code.toString());
             setProgress(false);
          },
          codeSent: (verificationId, forceResendingToken) {
             setProgress(false);
            //API to call

            Helper.checkInternet(login());
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
          timeout: Duration(seconds: 30)
      );
      //firebase otp code end
      //firebase otp code end
    }
    else{
      FirebaseAuth.instance.signOut();
      ToastMessage.msg("No Account found, Please Register First");
      // Fluttertoast.showToast( msg:"");
       setProgress(false);
    }
  }

}




