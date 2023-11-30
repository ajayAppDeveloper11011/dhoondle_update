import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/images.dart';
import '../../constants/text.dart';
import '../controllers/splash_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final splashController = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    splashController.startAnimation();
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Obx(
              () => AnimatedAlign(
                  duration: Duration(milliseconds: 1600),
                  alignment: splashController.animate.value
                      ? Alignment.center
                      : Alignment.topCenter,
                  // top: splashController.animate.value?200:-200,
                  // left:splashController.animate.value?80:-200,

                  child: AnimatedOpacity(
                      opacity: splashController.animate.value ? 1 : 0,
                      duration: Duration(milliseconds: 1000),
                      child: Image.asset(
                        Images.logo,
                        height: 100,
                      ))),
            ),
            Obx(
              () => AnimatedAlign(
                  // bottom: splashController.animate.value?size.height*0.38:-220,
                  //      left: splashController.animate.value?size.height*.17:-100,
                  duration: Duration(milliseconds: 1600),
                  // alignment:splashController.animate.value? Alignment.center:Alignment.bottomCenter,
                  alignment: splashController.animate.value
                      ? Alignment.center
                      : Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 180.0),
                    child: AnimatedOpacity(
                      opacity: splashController.animate.value ? 0.8 : 0,
                      duration: Duration(milliseconds: 1000),
                      child: Text(
                        TextScreen.DHOONDLE,
                        style: GoogleFonts.lato(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 18),
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
