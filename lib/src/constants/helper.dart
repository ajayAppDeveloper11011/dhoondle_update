import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';


import 'package:shared_preferences/shared_preferences.dart';

import 'colors.dart';




class Helper {
  /*================ progress bar ================*/
  static Widget getProgressBar(BuildContext context, bool _isVisible) {

    return Visibility(
        maintainSize: true,
        maintainAnimation: true,
        maintainState: true,
        visible: _isVisible,
        child: Container(
          margin: EdgeInsets.only(top: 20),
          child: Center(
            child: SpinKitSpinningLines(size: 60.0, color: AppColors.primaryColor, lineWidth: 3,),
          ),
        )
    );
  }

  static Widget progressBar(BuildContext context, bool _isVisible){

    return Visibility(
        maintainSize: true,
        maintainAnimation: true,
        maintainState: true,
        visible: _isVisible,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          // margin: EdgeInsets.only(top: 20),
          color: Colors.black54,
          child: Center(
            child: SpinKitSpinningLines(size: 60.0, color: AppColors.primaryColor, lineWidth: 3,),
          ),
        )
    );
  }

  static Widget getProgressBarWhite(BuildContext context, bool _isVisible){

    return Visibility(
        maintainSize: true,
        maintainAnimation: true,
        maintainState: true,
        visible: _isVisible,
        child: Container(
          margin: EdgeInsets.only(top: 20),
          child: Center(
            child: SpinKitSpinningLines(size: 60.0, color: Colors.white, lineWidth: 3,),
          ),
        )
    );
  }


  /*================ check Internet ================*/

  static Future<void> checkInternet(Future<dynamic> callback) async{

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

      callback.asStream();
      // callback.call();

    } else {
      Fluttertoast.showToast(msg: StaticMessages.CHECK_INTERNET);
    }
  }

  static Future<bool> internet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return true ;
      // callback.call();

    } else {
      Fluttertoast.showToast( msg:StaticMessages.CHECK_INTERNET);
      return false ;
    }
  }

  /*================ next Focus ================*/

  static void nextFocus(BuildContext context, FocusNode currentFocus,FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  /*================ open web ================*/

  // static Future<bool> launchUrl(String url) async{
  //
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //     return true;
  //   } else {
  //     print( 'Could not launch $url');
  //     return false;
  //   }
  // }

  /*================ for navigation ================*/

  static Future<void> moveToScreenwithPush(BuildContext context, dynamic nextscreen) async{
    await Navigator.push(context, MaterialPageRoute(builder: (context) => nextscreen));
  }

  static moveToScreenwithPushreplaceemt(BuildContext context, dynamic nextscreen){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => nextscreen));
  }

  static moveToScreenwithRoutClear(BuildContext context, nextscreen){

    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
        nextscreen()), (Route<dynamic> route) => false);

  }

  static popScreen(BuildContext context){
    Navigator.pop(context);
  }

/*================ for navigation ================*/


/*================ share sheet ================*/


// static  void  shareSheet(  BuildContext context,String shareData)  {
//   {
//     Share.share(shareData);
//     // Share.share(shareData, subject: 'Look what I made!');
//     //  Share.shareFiles([shareData], text: 'Great picture');
//     // Share.shareFiles([shareData, shareData]);
//
//   }
// }


/*================ social media webviews ================*/



}

class Apis {

  // static const BASEURL = "http://ixorainfotech.in/Aheadly/Customer/";
  //  static const BASEURL = "http://34.72.190.22/Aheadly/Customer/";

  ///ixora
  static const BASEURL = "http://ixorainfotech.in/Aheadly/Webservice/";

  // Customer screens API'S
  static const signup = BASEURL + "signupWithEmail";
  static const saveLocation = BASEURL + "saveLocation";
  static const Login = BASEURL + "login";
  static const signin = BASEURL + "signinWithEmail";
  static const verifyOtp = BASEURL + "verifyOtp";
  static const forgetPassword = BASEURL + "forgetPassword";

  static const addservices = BASEURL + "addservices";
  static const summary = BASEURL + "summary";
  static const editProfile = BASEURL + "editProfile";
  static const addnewcard = BASEURL + "addNewCard";
  static const getProfile = BASEURL + "getProfile";
  static const getsavedcards = BASEURL + "getSavedCards";
  static const getReceipt = BASEURL + "getReceipt";
  static const resetPassword = BASEURL + "resetPassword";
  static const sendOtp = BASEURL + "sendOtp";
  static const getCoupons = BASEURL + "getCoupons";
  static const getProfileList = BASEURL + "getProfileList";
  static const googleSignIn = BASEURL + "googleSignIn";
  static const addReview = BASEURL + "addReview";
  static const getUpcomingAppointment = BASEURL + "getUpcomingAppointment";
  static const getCancelledAppointment = BASEURL + "getCancelledAppointment";
  static const withdrawAmount = BASEURL + "withdrawAmount";
  static const deleteAccount = BASEURL + "deleteAccount";


  // Jaydeep
  static const getHome = BASEURL + "getHome";
  static const getPastAppointment = BASEURL + "getPastAppointment";
  static const getShopList = BASEURL + "getShopList";
  static const getShopAbout = BASEURL + "getShopAbout";
  static const getShopService = BASEURL + "getShopService";
  static const getShopReviews = BASEURL + "getShopReviews";
  static const bookAppointment = BASEURL + "bookAppointment";
  static const cancelAppointment = BASEURL + "cancelAppointment";
  static const rescheduleAppointment = BASEURL + "rescheduleAppointment";
  static const transaction = BASEURL + "transaction";
  static const facebookSignIn = BASEURL + "facebookSignIn";
  static const addNotes = BASEURL + "addNotes";
  static const verifyPayment = BASEURL + "verifyPayment";
  static const changePassword = BASEURL + "changePassword";
  static const getNotification = BASEURL + "getNotification";
  static const editService = BASEURL + "editService";
  static const getDaysofWeek = BASEURL + "getDaysofWeek";
  static const getShopTiming = BASEURL + "getShopTiming";
  static const reportShop = BASEURL + "reportShop";
  static const deleteSavedCard = BASEURL + "deleteSavedCard";
  static const saveNotification = BASEURL + "saveNotification";
  static const getReceiptDetails = BASEURL + "getReceiptDetails";


  //New api add
  static const registerUser = BASEURL + "registerUser";
  static const getReferalCode = BASEURL + "getReferalCode";
  static const getShopList2 = BASEURL + "getShopList";
  static const markFavorite = BASEURL + "markFavorite";
  static const getMonthList = BASEURL + "getMonthList";
  static const getUpcomingMonths = BASEURL + "getUpcomingMonths";
  static const getPastMonth = BASEURL + "getPastMonth";
  static const getWallet = BASEURL + "getWallet";
  static const getSavedShop = BASEURL + "getSavedShop";
  static const getRecentSearches = BASEURL + "getRecentSearches";
  static const saveRecentSearchAddress = BASEURL + "saveRecentSearchAddress";
  static const getServices = BASEURL + "getServices";
  static const addCoupon = BASEURL + "addCoupon";
  static const report = BASEURL + "report";
  static const refundAmount = BASEURL + "refundAmount";
  static const getMainServiceCategory = BASEURL + "getMainServiceCategory";
  static const payWithWallet = BASEURL + "payWithWallet";
  static const clearCart = BASEURL + "clearCart";


}

class StaticMessages {
  static const CHECK_INTERNET = "Please Check Internet Connection.";
  static const API_ERROR = "Something Went Wrong";
}


extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}



class SessionHelper {
  static late SharedPreferences sharedPreferences;

  static late SessionHelper _sessionHelper;

  static const String USER_ID = "uid";
  static const String FULLNAME = "fullName";
  static const String USERNAME = "userName";
  static const String NUMBER = "NUMBER";
  static const String IMAGE = "IMAGE";
  static const String IS_VERIFIED = "docID";
  static const String MAP_TO_PASS = "mapToPass";
  static const String ADD_SERVICE = "add_service";
  static const String COUPON = "coupon";
  static const String NO_OF_SERVICES = "no_of_services";
  static const String TOTAL = "total";
  static const String ID = "id";
  static const String DATE = "date";
  static const String TIME = "time";
  static const String STAFF_ID = "staff_id";
  static const String SHOP_ID = "shop_id";
  static const String IS_FOR = "is_for";
  static const String SERVICE1 = "service1";
  static const String SERVICE2 = "service2";
  static const String SERVICE3 = "service3";
  static const String SERVICE4 = "service4";
  static const String LATITUDE = "lattitude";
  static const String LONGITUDE = "longitude";
  static const String EMAIL = "email";
  static const String PASSWORD = "password";
  static const String CHECKBOX = "checkbox";
  static const String CUS_FIREBASE_ID = "CUS_FIREBASE_ID";
  static const String CUS_FIREBASE_NAME = "CUS_FIREBASE_NAME";
  static const String CUS_FIREBASE_EMAIL = "CUS_FIREBASE_EMAIL";
  static const String CUS_FIREBASE_IMAGE = "CUS_FIREBASE_IMAGE";
  static const String LOCATION = "LOCATION";
  static const String NOTI_COUNT = "0";
  static const String ADDRESS = "ADDRESS";
  static const String DATESEARCH = "DATESEARCH";
  static const String SERVICENAME = "SERVICENAME";
  static const String MONTHNAME = "MONTHNAME";
  static const String ISADDED = "ISADDED";
  static const String PROMO = "PROMO";











  static Future<SessionHelper> getInstance(BuildContext context) async {
    _sessionHelper = new SessionHelper();
    sharedPreferences = await SharedPreferences.getInstance();

    return _sessionHelper;
  }

  String? get(String key) {
    return sharedPreferences.getString(key);
  }

  put(String key, String value) {
    sharedPreferences.setString(key, value);
  }

  clear() {
    sharedPreferences.clear();
  }
  remove(String key) {
    sharedPreferences.remove(key);
  }

}

class ToastMessage {
  static void msg(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        fontSize: 16.0,
        backgroundColor: AppColors.primaryColor,
        textColor: Colors.white);
  }

  static void alertmsg(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        fontSize: 16.0,
        backgroundColor:AppColors.primaryColor,
        textColor: Colors.white);
  }
}

class HelperClass {
  /*================ progress bar ================*/
  static String _check = '';

  static Widget getProgressBar(BuildContext context, bool _isVisible){

    return Visibility(
        maintainSize: true,
        maintainAnimation: true,
        maintainState: true,
        visible: _isVisible,
        child: Container(
          color: Colors.transparent,
          margin: EdgeInsets.only(top: 20),
          child: Center(
            child: SpinKitSpinningLines(size: 60.0, color:AppColors.primaryColor, lineWidth: 3,),
          ),
        )
    );
  }

  static Widget progressBar(BuildContext context, bool _isVisible) {
    return Visibility(
        maintainSize: true,
        maintainAnimation: true,
        maintainState: true,
        visible: _isVisible,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          // margin: EdgeInsets.only(top: 20),
          color: Colors.black54,
          child: Center(
              child: Lottie.asset("assets/animation/loader.json",
                  width: 300, height: 300)
            // SpinKitSpinningLines(size: 60.0, color: AppColor.primaryColor, lineWidth: 3,),
          ),
        ));
  }

  static Widget getProgressBarWhite(BuildContext context, bool _isVisible) {
    return Visibility(
        maintainSize: true,
        maintainAnimation: true,
        maintainState: true,
        visible: _isVisible,
        child: Container(
          color: Colors.transparent,
          margin: EdgeInsets.only(top: 20),
          child: Center(
              child: Lottie.asset("assets/animation/loader.json",
                  width: 300, height: 300)
            // child: Image.asset("assets/images/loader.gif")
            // child: SpinKitSpinningLines(size: 60.0, color: AppColor.primaryColor, lineWidth: 3,),
          ),
        ));
  }

  /*================ check Internet ================*/

  static Future<void> checkInternet(Future<dynamic> callback) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      callback.asStream();
      // callback.call();

    } else {
      ToastMessage.msg(StaticMessages.CHECK_INTERNET);
    }
  }

  static Future<bool> internet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return true;
      // callback.call();

    } else {
      ToastMessage.msg(StaticMessages.CHECK_INTERNET);
      return false;
    }
  }

  /*================ next Focus ================*/

  static void nextFocus(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  /*================ for navigation ================*/

  static Future<void> moveToScreenwithPush(
      BuildContext context, dynamic nextscreen) async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => nextscreen));
  }

  static moveToScreenwithPushreplaceemt(
      BuildContext context, dynamic nextscreen) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => nextscreen));
  }

  static moveToScreenwithRoutClear(BuildContext context, nextscreen) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => nextscreen()),
            (Route<dynamic> route) => false);
  }

  static popScreen(BuildContext context) {
    Navigator.pop(context);
  }

/*================ for navigation ================*/

}