import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../registration/signup.dart';
import '../screens/splash_screen.dart';




class SplashController extends GetxController{
  static SplashController get find=>Get.find();
  RxBool animate=false.obs;
  Future startAnimation() async{
    await Future.delayed(Duration(milliseconds: 500));
    animate.value=true;
     await Future.delayed(Duration(milliseconds: 5000));
       onDoneLoading();
    // Get.to(()=>Signup());
     // Navigator.push(context,MaterialPageRoute(builder: (context)=> SplashScreen()));
  }
}
onDoneLoading() async {
  final prefs = await SharedPreferences.getInstance();
  var user_id=   await prefs.getString('user_id');
  if(user_id == null){
    // Helper.moveToScreenwithPushreplaceemt(context,  PageViewScreen());
    // Get.offAllNamed('/login');
    Get.offAllNamed('/bottom');
  }else
     Get.offAllNamed('/bottom');
    // Get.offAllNamed('/Policy');
}