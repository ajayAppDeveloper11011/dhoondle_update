import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

import '../../api_model/login_api_model.dart';
import '../../constants/Api.dart';
import '../../constants/helper.dart';
import '../../registration/otp_screen.dart';

class LoginController extends GetxController{
  final formKey = GlobalKey<FormState>();
  LoginOtp?_loginOtp;

  final phoneNumber = ''.obs;
  final isValid = RxBool(false);
  static LoginController get find =>Get.find();
  final mobileController = TextEditingController().obs;






  // String? validateEmail(String value) {
  //   if (!GetUtils.isEmail(value)) {
  //     return "Provide valid Email";
  //   }
  //   return null;
  // }

  void validatePhoneNumber(String value) {
    // Implement your validation logic here
    if (value.length == 10) {
      isValid.value = true;

    } else {
      isValid.value = false;
    }

  }
  void checkLogin() {
    if (formKey.currentState != null) {
      if (formKey.currentState!.validate()) {
        // Validation passed, you can proceed with your logic here
        formKey.currentState!.save();

      }
    }
  }


   login(String verificationId, int? forceResendingToken) async{
    print("================login api=============");
    try{
      final response= await post(Uri.parse(Api.login),
          body: {
            'number':mobileController.value.text.toString(),
            'device_token':"13446"
          }
          );
      var data = jsonDecode(response.body);



      print(response.statusCode);
      print(data);

      if(response.statusCode == 200){
        LoginOtp model = LoginOtp.fromJson(data);
        if(model.status == 'true'){
          Get.snackbar('Your otp is',model!.data!.otp.toString());

          // Helper.moveToScreenwithPush(context, OtpScreen(verificationId: '',))

          Get.toNamed('/otp',arguments: mobileController.value.text.toString());
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


  Future<void> phoneCheckWithFirebase() async{
    // setProgress(true);
    //firebase otp code
    // String phone = "+" + countryCodeCreated + phoneController.text.trim();
    String phone = "+234" + mobileController.toString();
    //new code start
    final _fireStore = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await _fireStore.collection('customer_details').where("customer_phone", isEqualTo: phone).get();
    // final allData =
    // querySnapshot.docs.map((doc) => doc.get('phone')).toList();
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    if (allData.length==0) {
      //new code end
      //firebase otp code
      // String phone = "+" + countryCodeCreated + phoneController.text.trim();
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: phone,
          verificationCompleted: (credential) {
            // setProgress(false);
          },
          verificationFailed: (ex) {
            ToastMessage.msg(ex.code.toString());
            log("ex"+ ex.code.toString());
            // setProgress(false);
          },
          codeSent: (verificationId, forceResendingToken) {
            // setProgress(false);
            //API to call

            Helper.checkInternet( login(verificationId,forceResendingToken ));
            //  Helper.moveToScreenwithPush(context, OtpVerifyScreen(
            //    forceResendingToken: forceResendingToken,
            //    number: numberController.text.trim(),
            //    verificationId: verificationId,
            //    afterSignUp: true,
            //  ));
          },
          codeAutoRetrievalTimeout: (verificationId) {
            // setProgress(false);
          },
          timeout: Duration(seconds: 30)
      );
      //firebase otp code end
      //firebase otp code end
    }
    else{
      FirebaseAuth.instance.signOut();
      ToastMessage.msg("Phone number already registered, Please sign in");
      // Fluttertoast.showToast( msg:"");
      // setProgress(false);
    }
  }




  //  validateData() {
  //   isValid.value = _isValidData(mobileController.value.text.toString());
  // }

  // bool _isValidData(String phone) {
  //   if (phone!.isEmpty) {
  //     return false;
  //     // ToastMessage.msg("Please enter phone number");
  //   } else if (phone.length < 10) {
  //     return false;
  //     // ToastMessage.msg("Mobile Number must be of 10 digit");
  //   }
  //   return true;
  //   // Implement your validation logic here
  //   // Return true if data is valid, otherwise return false
  // }
}


  // validationslogin(phone){
  //     if (phone!.isEmpty) {
  //       return "Please enter phone number";
  //       // ToastMessage.msg("Please enter phone number");
  //     } else if (phone.length != 10) {
  //       return "Mobile Number must be of 10 digit";
  //       // ToastMessage.msg("Mobile Number must be of 10 digit");
  //     }
  //   }


