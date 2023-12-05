import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api_model/get_property_list_model.dart';
import '../../api_model/get_service_list_model.dart';
import '../../api_model/login_api_model.dart';
import '../../api_model/profile_model_api.dart';
import '../../constants/Api.dart';
import 'common_model.dart';

class HomePropertyController extends GetxController{

  GetPropertyList? getPropertyList;
  final dio = Dio();
  static HomePropertyController get find =>Get.find();
  var isLoading = false.obs;


  homeApi(String category) async {
    print("=====================homeApi===============");
    isLoading(true);
    final prefs = await SharedPreferences.getInstance();
    var user_id=   await prefs.getString('user_id');
    print("==============userId=======${user_id}");
    print("==============userId=======${category}");
    var res = await dio.get(Api.getPropertyList+"?user_id=${user_id}&category=${category}");
    if(res.statusCode == 200){
      isLoading(false);
      var body = jsonDecode(res.toString());
      getPropertyList = GetPropertyList.fromJson(body);
      print(body);
    }
    else{
      isLoading(true);
      if (kDebugMode) {
        print(res.statusCode.toString());
      }
    }
  }

  // Future<void> homeApi(String category) async {
  //   print("=====================homeApi===============");
  //   isLoading(true);
  //   final prefs = await SharedPreferences.getInstance();
  //   var userId = await prefs.getString('user_id');
  //
  //   print("==============userId=======${userId}");
  //   print("==============service_id=======${category}");
  //   try {
  //     final response = await dio.post(
  //       Api.getPropertyList,
  //       data: {
  //         'user_id': userId.toString(),
  //         'category':category,
  //       },
  //     );
  //
  //     if (response.statusCode == 200) {
  //
  //       isLoading(false);
  //       var body = response.data;
  //       getPropertyList = GetPropertyList.fromJson(body);
  //       Get.back();
  //       print(body);
  //     } else {
  //       isLoading(true);
  //       if (kDebugMode) {
  //         print(response.statusCode.toString());
  //       }
  //     }
  //   } catch (e) {
  //     // Handle any exceptions or errors that occur during the POST request
  //     isLoading(true);
  //     print("Error: $e");
  //   }
  // }

}

