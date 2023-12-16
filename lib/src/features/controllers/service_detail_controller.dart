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
import '../../api_model/service_detail_model.dart';
import '../../api_model/service_list_api.dart';
import '../../constants/Api.dart';

class ServiceDetailsController extends GetxController{

  ServiceDetailModel? serviceDetailModel;
  static ServiceDetailsController get find =>Get.find();
  var isLoading = false.obs;
  final dio=Dio();


  // void servicedetailApi(String service) async{
  //   print("================serviceApi=============");
  //   try{
  //     isLoading(true);
  //     final prefs = await SharedPreferences.getInstance();
  //     var user_id=   await prefs.getString('user_id');
  //     final response= await post(Uri.parse(Api.getServiceProviderList),
  //         body: {
  //           'user_id':user_id,
  //           'service':service
  //         });
  //
  //
  //     var data = jsonDecode(response.body);
  //     print(response.statusCode);
  //     print(data);
  //
  //     if(response.statusCode == 200){
  //       var result = jsonDecode(response.body);
  //
  //       // openseaModel = OpenseaModel.fromJson(result);
  //       //
  //       // ProfileApiModel model = ProfileApiModel.fromJson(data);
  //       serviceDetailModel=ServiceDetailModel.fromJson(result);
  //
  //       if(result.status == 'true'){
  //
  //         print(prefs.get('user_id'));
  //         // Get.snackbar('Your otp is',result!.data!.otp.toString());
  //         // Get.toNamed('/otp',arguments: mobileController.value.text.toString());
  //       }
  //       else{
  //         Get.snackbar('Something went wrong', data['message']);
  //       }
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


   servicedetailApi(String service) async {
    print("=====================homeApi===============");
    isLoading(true);
    final prefs = await SharedPreferences.getInstance();
    var user_id=   await prefs.getString('user_id');
    print("==============userId=======${user_id}");
    print("==============userId=======${service}");
    // print("==============userId=======${category}");
    var res = await dio.get(Api.getServiceProviderList+"?user_id=${user_id}&service=${service}");
    if(res.statusCode == 200){
      isLoading(false);
      var body = jsonDecode(res.toString());
      serviceDetailModel = ServiceDetailModel.fromJson(body);
      print(body);
    }
    else{
      isLoading(true);
      if (kDebugMode) {
        print(res.statusCode.toString());
      }
    }
  }


}

