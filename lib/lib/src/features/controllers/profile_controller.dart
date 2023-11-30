import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api_model/login_api_model.dart';
import '../../api_model/profile_model_api.dart';
import '../../constants/Api.dart';

class ProfileController extends GetxController{

  ProfileApiModel? profileApiModel;
  final dio = Dio();
  static ProfileController get find =>Get.find();
  var isLoading = false.obs;
  final mobileController = TextEditingController().obs;

  // void profileApi() async{
  //   print("================profile api=============");
  //   try{
  //     isLoading(true);
  //     final prefs = await SharedPreferences.getInstance();
  //     var user_id=   await prefs.getString('user_id');
  //     final response= await get(Uri.parse(Api.getprofile+"?user_id=${user_id}"),);
  //
  //     //
  //     // var data = jsonDecode(response.body);
  //     // print(response.statusCode);
  //     // print(data);
  //
  //     if(response.statusCode == 200){
  //       var result = jsonDecode(response.body);
  //       print("============result==========${result}");
  //       // openseaModel = OpenseaModel.fromJson(result);
  //       //
  //       // ProfileApiModel model = ProfileApiModel.fromJson(data);
  //       profileApiModel=ProfileApiModel.fromJson(result);
  //
  //       if(result.status == 'true'){
  //
  //         print(prefs.get('user_id'));
  //         // Get.snackbar('Your otp is',result!.data!.otp.toString());
  //         // Get.toNamed('/otp',arguments: mobileController.value.text.toString());
  //       }
  //       // else{
  //       //   Get.snackbar('Something went wrong', data['message']);
  //       // }
  //     }
  //     else{
  //       Get.snackbar('Exception', 'something went wrong');
  //     }
  //   }
  //   catch(e){
  //     Get.snackbar('Exception', e.toString());
  //     isLoading(false);
  //   }
  // }

  Future<void> onInit() async {
    profileApi();
    super.onInit();
  }

  profileApi() async {
    isLoading(true);
    final prefs = await SharedPreferences.getInstance();
    var user_id=   await prefs.getString('user_id');
    var res = await dio.get(Api.getprofile+"?user_id=${user_id}");
    if(res.statusCode == 200){
      isLoading(false);
      var body = jsonDecode(res.toString());
      profileApiModel = ProfileApiModel.fromJson(body);
    }
    else{
      isLoading(true);
      if (kDebugMode) {
        print(res.statusCode.toString());
      }
    }
  }
}

