import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

import '../../constants/Api.dart';

class SignUpController extends GetxController{
  final formKey = GlobalKey<FormState>();
  final isValid = RxBool(false);
  static SignUpController get find =>Get.find();
  final  nameController = TextEditingController().obs ;
  final addressController = TextEditingController().obs;
  final emailController = TextEditingController().obs ;
  final mobileController = TextEditingController().obs;

  void validatePhoneNumber(String value) {
    // Implement your validation logic here
    if (value.length == 10) {
      isValid.value = true;

    } else {
      isValid.value = false;
    }

  }

  void validatename(String value) {
    // Implement your validation logic here
    if (value.length <= 2) {
      isValid.value = true;

    } else {
      isValid.value = false;
    }

  }

  void validateaddress(String value) {
    // Implement your validation logic here
    if (value.length <= 2) {
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


  void signUp() async{
     try{
       final response= await post(Uri.parse(Api.signup),
           body: {
             'name':nameController.value.text.toString(),
             'address':addressController.value.text.toString(),
             'email':emailController.value.text.toString(),
             'phone':mobileController.value.text.toString(),
             'device_token':"13446"
           });
       var data = jsonDecode(response.body);
       print(response.statusCode);
       print(data);
       if(response.statusCode == 200){

         if(data['status']== 'true'){
           Get.snackbar('Your otp is', data['data']['otp']);

           Get.toNamed('/otp',arguments: mobileController.value.text.toString() );
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

}