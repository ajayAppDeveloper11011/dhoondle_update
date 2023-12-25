import 'package:dhoondle/src/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

class PlanTypeScreen extends StatefulWidget {
  const PlanTypeScreen({Key? key}) : super(key: key);

  @override
  State<PlanTypeScreen> createState() => _PlanTypeScreenState();
}

class _PlanTypeScreenState extends State<PlanTypeScreen> {
  int currentIndex = 0;
  var planData = [
    {
      'price': '49',
      'plan_type': 'Basic Plan',
      'line_1': 'This plan available for 7 Days',
      'line_2': 'Maximum 5 calls available',
      'line_3': '5 WhatsApp calls available',
      'line_4': 'For extra call buy another plan'
    },
    {
      'price': '99',
      'plan_type': 'Premium Plan',
      'line_1': 'This plan available for 10 Days',
      'line_2': 'Maximum 10 calls available',
      'line_3': '10 WhatsApp calls available',
      'line_4': 'For extra call buy another plan'
    },
    {
      'price': '199',
      'plan_type': 'Platinam Plan',
      'line_1': 'This plan available for 30 Days',
      'line_2': 'Maximum 30 calls available',
      'line_3': '30 WhatsApp calls available',
      'line_4': 'For extra call buy another plan'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor.withOpacity(0.9),
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: InkWell(
            onTap: () {
              Get.toNamed('/bottom');
            },
            child: Icon(Icons.arrow_back)),
        title: Text(
          'Select Your Favorite Plan',
          style: GoogleFonts.lato(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 60.0,
          ),
          SizedBox(
            height: Get.height * 0.5,
            child: PageView.builder(
              itemCount: planData.length,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return Container(
                    margin:
                    EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
                    alignment: Alignment.center,
                    padding:
                    EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.0),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          '\u20B9${planData[index]['price']}',
                          style: GoogleFonts.lato(
                              color:AppColors.primaryColor,
                              fontSize: 26,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${planData[index]['plan_type']}',
                          style: GoogleFonts.lato(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 4.0),
                                height: 14,
                                width: 14,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color:AppColors.primaryColor),
                              ),
                              Text(
                                '${planData[index]['line_1']}',
                                style: GoogleFonts.lato(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 4.0),
                                height: 14,
                                width: 14,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color:AppColors.primaryColor),
                              ),
                              Text(
                                '${planData[index]['line_2']}',
                                style: GoogleFonts.lato(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 4.0),
                                height: 14,
                                width: 14,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color:AppColors.primaryColor),
                              ),
                              Text(
                                '${planData[index]['line_3']}',
                                style: GoogleFonts.lato(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 4.0),
                                height: 14,
                                width: 14,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.primaryColor),
                              ),
                              Text(
                                '${planData[index]['line_4']}',
                                style: GoogleFonts.lato(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 50,
                          width: Get.width * .7,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24.0),
                              color:AppColors.primaryColor),
                          child: Text(
                            'Buy This Plan',
                            style: GoogleFonts.lato(
                                color: Colors.white, fontSize: 18),
                          ),
                        )
                      ],
                    ));
              },
            ),
          ),
          SizedBox(
            height: 20,
            child: Center(
              child: ListView.builder(
                itemCount: planData.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(4.0),
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: index == currentIndex
                          ? AppColors.primaryColor
                          : Colors
                          .grey, // Indicator color based on currentIndex
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}