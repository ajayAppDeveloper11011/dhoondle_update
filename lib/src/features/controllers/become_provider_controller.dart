import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api_model/become_provider_model.dart';
import '../../api_model/login_api_model.dart';
import '../../constants/Api.dart';

class BecomeProviderController extends GetxController{
  var isLoading = false.obs;
  final isValid = RxBool(false);
  static BecomeProviderController get find =>Get.find();


  void becomeProviderApi(String selectService) async{
    print("================become service provider api=============");
    try{
      isLoading(true);
      final prefs = await SharedPreferences.getInstance();
      var user_id=   await prefs.getString('user_id');
      final response= await post(Uri.parse(Api.becomeProvider),
          body: {
            'user_id':user_id,
            'serviceProvider':selectService
          }
      );
      var data = jsonDecode(response.body);



      print(response.statusCode);
      print(data);

      if(response.statusCode == 200){
        BecomeProviderModel model = BecomeProviderModel.fromJson(data);
        if(model.status == 'true'){

          Get.toNamed('/service');
          // Get.snackbar('Your otp is',model!.data!.otp.toString());
          //
          // Get.toNamed('/otp',arguments: mobileController.value.text.toString());
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





