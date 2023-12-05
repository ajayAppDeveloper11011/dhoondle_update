
import 'package:dhoondle/src/constants/change_language_screen.dart';
import 'package:dhoondle/src/constants/helper/demo_localization.dart';
import 'package:dhoondle/src/constants/helper/session.dart';
import 'package:dhoondle/src/features/screens/add_property.dart';
import 'package:dhoondle/src/features/screens/add_property_screen.dart';
import 'package:dhoondle/src/features/screens/add_services.dart';
import 'package:dhoondle/src/features/screens/all_property.dart';
import 'package:dhoondle/src/features/screens/become_service_provider.dart';
import 'package:dhoondle/src/features/screens/bottomNavigation.dart';
import 'package:dhoondle/src/features/screens/find_roommate.dart';
import 'package:dhoondle/src/features/screens/home_screen.dart';
import 'package:dhoondle/src/features/screens/plumber_screen.dart';
import 'package:dhoondle/src/features/screens/privacy_policy.dart';
import 'package:dhoondle/src/features/screens/profile_screen.dart';
import 'package:dhoondle/src/features/screens/property_details_screen.dart';
import 'package:dhoondle/src/features/screens/property_screen.dart';
import 'package:dhoondle/src/features/screens/roommate_screen.dart';
import 'package:dhoondle/src/features/screens/service_screen.dart';
import 'package:dhoondle/src/features/screens/services_tabbar.dart';
import 'package:dhoondle/src/features/screens/setting%202%20(1).dart';
import 'package:dhoondle/src/features/screens/setting3.dart';
import 'package:dhoondle/src/features/screens/splash_screen.dart';
import 'package:dhoondle/src/features/screens/test_screen_tabbar.dart';
import 'package:dhoondle/src/registration/log_in_screen.dart';
import 'package:dhoondle/src/registration/otp_screen.dart';
import 'package:dhoondle/src/registration/signup.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>()!;
    state.setLocale(newLocale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Locale? _locale;

  setLocale(Locale locale) {
    if (mounted) {
      setState(() {
        _locale = locale;
      });
    }
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      if (mounted) {
        setState(() {
          this._locale = locale;
        });
      }
    });
    super.didChangeDependencies();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DHOONDLE APP',
      initialRoute: '/splash',
      locale: _locale,
      supportedLocales: const [
        Locale("en", "US"),
        Locale("hi", "IN"),
      ],
      localizationsDelegates: [
        DemoLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale!.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      getPages: [
        GetPage(name: '/splash', page: () => SplashScreen()),
        GetPage(name: '/changeLanguage', page: () =>ChangeLanguageScreen()),
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
        primarySwatch: Colors.blue,
      ),
      home: const TabbarTextNew(),
    );
  }
}








