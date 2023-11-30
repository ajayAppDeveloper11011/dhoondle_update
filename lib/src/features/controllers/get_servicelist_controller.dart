import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api_model/get_service_list_model.dart';
import '../../api_model/login_api_model.dart';
import '../../api_model/profile_model_api.dart';
import '../../constants/Api.dart';
import 'common_model.dart';

class GetServiceListController extends GetxController{

  GetMyServiceList? getServiceListApi;
  CommonModel?commonmodel;
  final dio = Dio();
  static GetServiceListController get find =>Get.find();
  var isLoading = false.obs;


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



  getServiceList() async {
    print("=====================getservicelistapi===============");
    isLoading(true);
    final prefs = await SharedPreferences.getInstance();
    var user_id=   await prefs.getString('user_id');
    print("==============userId=======${user_id}");
    var res = await dio.get(Api.getMyServiceList+"?user_id=${user_id}");
    if(res.statusCode == 200){
      isLoading(false);
      var body = jsonDecode(res.toString());
      getServiceListApi = GetMyServiceList.fromJson(body);
      print(body);
    }
    else{
      isLoading(true);
      if (kDebugMode) {
        print(res.statusCode.toString());
      }
    }
  }



  Future<void> deleteApi(String service_id) async {
    print("=====================delete service===============");
    isLoading(true);
    final prefs = await SharedPreferences.getInstance();
    var userId = await prefs.getString('user_id');

    print("==============userId=======${userId}");
    print("==============service_id=======${service_id}");
    try {
      final response = await dio.post(
        Api.deleteService,
        data: {
          'user_id': userId.toString(),
          'service_id': service_id.toString(),
        },
      );

      if (response.statusCode == 200) {

        isLoading(false);
        var body = response.data;
        commonmodel = CommonModel.fromJson(body);
        Get.back();
        print(body);
      } else {
        isLoading(true);
        if (kDebugMode) {
          print(response.statusCode.toString());
        }
      }
    } catch (e) {
      // Handle any exceptions or errors that occur during the POST request
      isLoading(true);
      print("Error: $e");
    }
  }

}

