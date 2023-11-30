import 'package:dhoondle/src/constants/colors.dart';
import 'package:dhoondle/src/features/screens/plumber_screen.dart';
import 'package:dhoondle/src/features/screens/service_screen/widgets/service_design.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/images.dart';
import '../controllers/servicelist_controller.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({super.key});

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  List<Choice> choices = [
    Choice(color: Colors.white, image: Images.img1, title: 'Electrician'),
    Choice(color: Colors.white, image: Images.img2, title: 'Plumber'),
    Choice(color: Colors.white, image: Images.img3, title: 'Cleaner'),
  ];

  final serviceController = Get.put(ServiceListController());

  void initState() {
    // TODO: implement initState
    super.initState();
    serviceController.serviceApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        toolbarHeight: 80,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Image.asset(
            Images.logo,
            height: 200,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        title: Text('Services',
            style: GoogleFonts.lato(
              textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            )),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: ServiceListDesign(choices: choices),
        ),
      ),
    );
  }
}

class Choice {
  String title = "";
  String image = "";
  Color color = Colors.white;
  Choice({required this.color, required this.image, required this.title});
}
