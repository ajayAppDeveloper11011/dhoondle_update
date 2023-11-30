import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api_model/logout_api_model.dart';
import '../../constants/Api.dart';

class LogOutController extends GetxController{
  final dio = Dio();
  static LogOutController get find =>Get.find();
  var isLoading = false.obs;
  LogoutApiModel?_logoutApiModel;



  logoutApi() async {
    print("========================logout============");
    isLoading(true);
    final prefs = await SharedPreferences.getInstance();
    var user_id=   await prefs.getString('user_id');
    if (user_id == "1") {
      prefs.clear();
    } else {
      prefs.clear();
    }
    var res = await dio.get(Api.logout+"?user_id=${user_id}");
    if(res.statusCode == 200){
      // Get.toNamed('/bottom');
      // Get.offAndToNamed('/signup');
      Get.offAllNamed("/login");
      isLoading(false);
      var body = jsonDecode(res.toString());
      _logoutApiModel = LogoutApiModel.fromJson(body);
    }
    else{
      isLoading(true);
      if (kDebugMode) {
        print(res.statusCode.toString());
      }
    }
  }
}