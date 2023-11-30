import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../api_model/get_property_model.dart';
import '../../constants/Api.dart';



class ApiController extends GetxController{
  final dio = Dio();
  GetPropertyCategoryModel? getPropertyCategoryModel;
  var isLoading = true.obs;

  @override
  Future<void> onInit() async {
    getpropertyapi();
    super.onInit();
  }

  getpropertyapi() async {

    var res= await dio.post(Api.getPropertyCategory,data:{});

    // url=http://ixorainfotech.in/Dhoondle/Webservice/getProfile
    //
    // body={
    // 'user_id':userId
    // };


    // var res = await dio.post("https://reqres.in/api/users/$name");
    if(res.statusCode == 200){
      isLoading(false);
      var body = jsonDecode(res.toString());
      getPropertyCategoryModel = GetPropertyCategoryModel.fromJson(body);
    }
    else{
      isLoading(true);
      if (kDebugMode) {
        print(res.statusCode.toString());
      }
    }
  }
}