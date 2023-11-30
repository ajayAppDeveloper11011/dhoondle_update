
import 'package:dhoondle/lib/src/features/screens/add_property.dart';
import 'package:dhoondle/lib/src/features/screens/add_property_screen.dart';
import 'package:dhoondle/lib/src/features/screens/add_services.dart';
import 'package:dhoondle/lib/src/features/screens/all_property.dart';
import 'package:dhoondle/lib/src/features/screens/become_service_provider.dart';
import 'package:dhoondle/lib/src/features/screens/bottomNavigation.dart';
import 'package:dhoondle/lib/src/features/screens/find_roommate.dart';
import 'package:dhoondle/lib/src/features/screens/home_screen.dart';
import 'package:dhoondle/lib/src/features/screens/plumber_screen.dart';
import 'package:dhoondle/lib/src/features/screens/privacy_policy.dart';
import 'package:dhoondle/lib/src/features/screens/profile_screen.dart';
import 'package:dhoondle/lib/src/features/screens/property_details_screen.dart';
import 'package:dhoondle/lib/src/features/screens/property_screen.dart';
import 'package:dhoondle/lib/src/features/screens/roommate_screen.dart';
import 'package:dhoondle/lib/src/features/screens/service_screen.dart';
import 'package:dhoondle/lib/src/features/screens/services_tabbar.dart';
import 'package:dhoondle/lib/src/features/screens/setting%202%20(1).dart';
import 'package:dhoondle/lib/src/features/screens/setting3.dart';
import 'package:dhoondle/lib/src/features/screens/splash_screen.dart';
import 'package:dhoondle/lib/src/features/screens/test_screen_tabbar.dart';
import 'package:dhoondle/lib/src/registration/log_in_screen.dart';
import 'package:dhoondle/lib/src/registration/otp_screen.dart';
import 'package:dhoondle/lib/src/registration/signup.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DHOONDLE APP',
      initialRoute: '/splash',
      getPages: [
        GetPage(name: '/splash', page: () => SplashScreen()),
        GetPage(name: '/signup', page: () => Signup()),
        GetPage(name: '/login', page: () => LogInScreen()),
        GetPage(name: '/otp', page: () => OtpScreen(number: '', forceResendingToken: null, verificationId: '', afterSignUp: true,)),
        GetPage(name: '/bottom', page: () => BottomNaigation()),
        GetPage(name: '/becomeservice', page: () => BecomeServiceProvider()),
        GetPage(name: '/service', page: () => ServicesTabbar()),
        GetPage(name: '/home', page: () => HomeScreen(category: '',)),
        GetPage(name: '/profile', page: () => ProfileScreen()),
        GetPage(name: '/servicescreen', page: () => ServiceScreen()),
        GetPage(name: '/property', page: () => PropertyScreen()),
        GetPage(name: '/allproperty', page: () => AllProperty()),
        GetPage(name: '/propertydetail', page: () => PropertyDetailsScreen(property_id: '',)),
        GetPage(name: '/addproperty', page: () => AddPropertyScreen()),
        GetPage(name: '/addpropertynew', page: () => AddPropertynew()),
        GetPage(name: '/setting3', page: () => Setting3()),
        GetPage(name: '/setting2', page: () => Setting2()),
        GetPage(name: '/addservice', page: () => AddServiceScreen(service_id: '', service_name: '', service_des: '', number: '', address: '', serviceImage: '', serviceCategory: '', experience: '', whichscreen: '',)),
        GetPage(name: '/plumber', page: () => PlumberScreen(services: '',)),
        GetPage(name: '/propertyscreen', page: () => PropertyScreen()),
        GetPage(name: '/Policy', page: () => PrivacyPolicyScreen()),
        GetPage(name: '/tabtext', page: () => TabbarTextNew()),
        GetPage(name: '/roomscreen', page: () =>  RoomMateScreen()),
        GetPage(name: '/findroommate', page: () =>  FindRoomMates()),
      ],
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: TabbarTextNew(),
    );
  }
}

