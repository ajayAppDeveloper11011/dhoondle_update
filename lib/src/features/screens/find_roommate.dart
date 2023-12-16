import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../api_model/add_property_images_model.dart';
import '../../api_model/get_property_model.dart';
import '../../constants/Api.dart';
import '../../constants/colors.dart';
import '../../constants/helper.dart';
import '../../constants/images.dart';
import '../../constants/text.dart';

class FindRoomMates extends StatefulWidget {
  const FindRoomMates({super.key});

  @override
  State<FindRoomMates> createState() => _FindRoomMatesState();
}

class _FindRoomMatesState extends State<FindRoomMates> {
  var city = [
    "Indore",
    "Bhopal",
    "Ujjain",
    "Mumbai",
    "Devas",
    "Delhi",
  ];

  var roomtype = ["Semi furnished", "Fully furnished", "Unfurnished"];

  var furnished = ["Semi furnished", "Fully furnished", "Unfurnished"];
  var selectedFurnished = '';
  int? furnishedIndex;

  var catagory = ["Hostal", "PG", "Rent"];
  var profission = ['Student', 'Job', 'Other'];
  String? dropdownvalueOfCity = null;
  String? dropdownvalueOfroom = null;
  String? dropdownvalueOfCatagory = null;

  bool _isVisible = false;
  String restaurentText = '';
  List<CategoryList> restaurent = [];
  List<String> _restaurent = [];
  Map newMapOfMonths = {};
  GetPropertyCategoryModel? getPropertyCategoryModel;
  String selectedKey = "";
  String selectedOption = "";

  File? _image;
  final _picker = ImagePicker();
  List imageList = [];
  List facilitiesList = [];
  String getImage = "";
  List<File> _assetImgList = <File>[];

  TextEditingController nameController = TextEditingController();
  TextEditingController numbercontroller = TextEditingController();
  TextEditingController whatsAppController = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();
  TextEditingController citycontroller = TextEditingController();
  TextEditingController roomLocationController = TextEditingController();
  TextEditingController professionController = TextEditingController();
  TextEditingController describeProfisionController = TextEditingController();
  TextEditingController roomTypeController = TextEditingController();
  TextEditingController rentcontroller = TextEditingController();
  TextEditingController facilitiescontroller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Helper.checkInternet(getPropertyCategoryapi());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        // toolbarHeight: 80,
        leading: InkWell(
          onTap: () {
            Helper.popScreen(context);
          },
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0),
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        centerTitle: true,
        elevation: 0,
        title: Text('Find Roommate',
            style: GoogleFonts.lato(
              textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            )),

        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.all(25),
        //     child: Image.asset(Images.search,),
        //   ),
        // ],
      ),
      body: Stack(
        children: [
          getPropertyCategoryModel == null
              ? Container()
              : SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 10),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Name',
                              style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                                    color: AppColors.textcolor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              )),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: Color.fromARGB(227, 193, 192, 192),
                                  width: 0.5),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color.fromARGB(147, 193, 192, 192)
                                          .withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: TextField(
                              controller: nameController,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                hintText: 'Name',
                                border: InputBorder.none,
                                fillColor: Colors.white,
                                filled: true,
                                hintStyle: GoogleFonts.lato(
                                    color: AppColors.HintTextColor),
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 12,
                          ),
                          Text(TextScreen.phone,
                              style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                                    color: AppColors.textcolor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              )),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: Color.fromARGB(227, 193, 192, 192),
                                  width: 0.5),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color.fromARGB(147, 193, 192, 192)
                                          .withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: TextField(
                              controller: numbercontroller,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(11)
                              ],
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                hintText: '+91',
                                border: InputBorder.none,
                                fillColor: Colors.white,
                                filled: true,
                                hintStyle: GoogleFonts.lato(
                                    color: AppColors.HintTextColor),
                                // prefixIcon: Padding(
                                //   padding: const EdgeInsets.all(15.0),
                                //   child: Image.asset(
                                //     Images.telephonetxtfield,
                                //     height: 5,
                                //   ),
                                // ),
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 12,
                          ),
                          Text('WhatsApp',
                              style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                                    color: AppColors.textcolor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              )),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: Color.fromARGB(227, 193, 192, 192),
                                  width: 0.5),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color.fromARGB(147, 193, 192, 192)
                                          .withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: TextField(
                              controller: whatsAppController,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(10),
                              ],
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                hintText: 'WhatsApp Number',
                                border: InputBorder.none,
                                fillColor: Colors.white,
                                filled: true,
                                hintStyle: GoogleFonts.lato(
                                    color: AppColors.HintTextColor),
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 12,
                          ),
                          Text('Hometown Address',
                              style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                                    color: AppColors.textcolor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              )),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: Color.fromARGB(227, 193, 192, 192),
                                  width: 0.5),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color.fromARGB(147, 193, 192, 192)
                                          .withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: TextField(
                              controller: addresscontroller,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                hintText: 'Hometown Address',
                                border: InputBorder.none,
                                fillColor: Colors.white,
                                filled: true,
                                hintStyle: GoogleFonts.lato(
                                    color: AppColors.HintTextColor),
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 12,
                          ),
                          Text(TextScreen.City,
                              style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                                    color: AppColors.textcolor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              )),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: Color.fromARGB(227, 193, 192, 192),
                                  width: 0.5),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color.fromARGB(147, 193, 192, 192)
                                          .withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            // child: TextField(
                            //   controller: citycontroller,
                            //   textInputAction: TextInputAction.next,
                            //   decoration: InputDecoration(
                            //     hintText: 'City',
                            //     border: InputBorder.none,
                            //     fillColor: Colors.white,
                            //     filled: true,
                            //     hintStyle: GoogleFonts.lato(
                            //         color: AppColors.HintTextColor),
                            //   ),
                            // ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                  hint: Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Text("Select City",
                                        style: GoogleFonts.lato(
                                            color: AppColors.HintTextColor)),
                                  ),
                                  isExpanded: true,
                                  value: dropdownvalueOfCity,
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  items: city.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(
                                        items,
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      dropdownvalueOfCity = newValue!;
                                      citycontroller.text = newValue;
                                    });
                                  }),
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text('Location',
                              style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                                    color: AppColors.textcolor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              )),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: Color.fromARGB(227, 193, 192, 192),
                                  width: 0.5),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color.fromARGB(147, 193, 192, 192)
                                          .withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: TextField(
                              controller: roomLocationController,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                hintText: 'Room Location',
                                border: InputBorder.none,
                                fillColor: Colors.white,
                                filled: true,
                                hintStyle: GoogleFonts.lato(
                                    color: AppColors.HintTextColor),
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 12,
                          ),

                          Text('Profession',
                              style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                                    color: AppColors.textcolor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              )),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: Color.fromARGB(227, 193, 192, 192),
                                  width: 0.5),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color.fromARGB(147, 193, 192, 192)
                                          .withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                  hint: Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Text("Select Profession",
                                        style: GoogleFonts.lato(
                                            color: AppColors.HintTextColor)),
                                  ),
                                  isExpanded: true,
                                  value: dropdownvalueOfroom,
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  items: profission.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(
                                        items,
                                      ),
                                    );
                                  }).toList(),
                                  // After selecting the desired option,it will
                                  // change button value to selected value
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      dropdownvalueOfroom = newValue!;
                                    });
                                  }),
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text('Profession Details',
                              style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                                    color: AppColors.textcolor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              )),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: Color.fromARGB(227, 193, 192, 192),
                                  width: 0.5),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color.fromARGB(147, 193, 192, 192)
                                          .withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: TextField(
                              controller: describeProfisionController,
                              maxLines: 2,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                hintText: 'Describe Profession',
                                border: InputBorder.none,
                                fillColor: Colors.white,
                                filled: true,
                                hintStyle: GoogleFonts.lato(
                                    color: AppColors.HintTextColor),
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 12,
                          ),

                          Text('Furnished',
                              style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                                    color: AppColors.textcolor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              )),
                          const SizedBox(
                            height: 5,
                          ),
                          // Container(
                          //   padding: const EdgeInsets.symmetric(horizontal: 8),
                          //   decoration: BoxDecoration(
                          //     color: Colors.white,
                          //     borderRadius: BorderRadius.circular(12),
                          //       border: Border.all(
                          //         color: Color.fromARGB(227, 193, 192, 192),
                          //         width: 0.5),
                          //     boxShadow: [
                          //       BoxShadow(
                          //         color:
                          //             const Color.fromARGB(147, 193, 192, 192)
                          //                 .withOpacity(0.5),
                          //         spreadRadius: 1,
                          //         blurRadius: 1,
                          //         offset: const Offset(0, 2),
                          //       ),
                          //     ],
                          //   ),
                          //   child: DropdownButtonHideUnderline(
                          //     child: DropdownButton(
                          //         hint: Padding(
                          //           padding: const EdgeInsets.only(left: 8),
                          //           child: Text("Room Type",
                          //               style: GoogleFonts.lato(
                          //                   color: AppColors.HintTextColor)),
                          //         ),
                          //         isExpanded: true,
                          //         value: dropdownvalueOfroom,
                          //         icon: const Icon(Icons.keyboard_arrow_down),
                          //         items: catagory.map((String items) {
                          //           return DropdownMenuItem(
                          //             value: items,
                          //             child: Text(
                          //               items,
                          //             ),
                          //           );
                          //         }).toList(),
                          //         // After selecting the desired option,it will
                          //         // change button value to selected value
                          //         onChanged: (String? newValue) {
                          //           setState(() {
                          //             dropdownvalueOfroom = newValue!;
                          //           });
                          //         }),
                          //   ),
                          // ),
                          SizedBox(
                            height: 60,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: furnished.length,
                              itemBuilder: (constant, index) => GestureDetector(
                                onTap: () => _selectFurinshed(index),
                                child: Container(
                                  height: 55,
                                  // width: 100,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.0),
                                  decoration: BoxDecoration(
                                      color: furnishedIndex == index
                                          ? AppColors.primaryColor
                                          : Colors.transparent,
                                      border: Border.all(
                                        color: furnishedIndex == index
                                            ? AppColors.primaryColor
                                            : Colors.grey,
                                        width: 1.0,
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  alignment: Alignment.center,
                                  child: Text(furnished[index],
                                      style: GoogleFonts.lato(
                                        textStyle: TextStyle(
                                          color: furnishedIndex == index
                                              ? Colors.white
                                              : AppColors.primaryColor,
                                          fontSize: 16,
                                        ),
                                      )),
                                ),
                              ),
                              separatorBuilder:
                                  (BuildContext context, int index) => SizedBox(
                                width: 12.0,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(TextScreen.rent_price,
                              style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                                    color: AppColors.textcolor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              )),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: Color.fromARGB(227, 193, 192, 192),
                                  width: 0.5),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color.fromARGB(147, 193, 192, 192)
                                          .withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: TextField(
                              controller: rentcontroller,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                hintText: 'Amount',
                                border: InputBorder.none,
                                fillColor: Colors.white,
                                filled: true,
                                hintStyle: GoogleFonts.lato(
                                    color: AppColors.HintTextColor),
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 12,
                          ),

                          // Container(
                          //   padding: EdgeInsets.symmetric(horizontal: 22, vertical: 6),
                          //   decoration: BoxDecoration(
                          //     color: Color(0xffEAEDF2),
                          //     border: Border.all(color: AppColors.addpropertyfillclr, width: 1),
                          //     borderRadius: BorderRadius.circular(10),
                          //   ),
                          //   child: DropdownButtonHideUnderline(
                          //     child: DropdownButton(
                          //         hint: Padding(
                          //           padding:  EdgeInsets.only(left: 5),
                          //           child: Text("City",
                          //               style: GoogleFonts.lato(
                          //                 textStyle: TextStyle(
                          //                   color: AppColors.txtgreyclr,
                          //                   fontSize: 15,
                          //                 ),
                          //               )),
                          //         ),
                          //         isExpanded: true,
                          //         value: dropdownvalueOfCity,
                          //         icon: const Icon(Icons.keyboard_arrow_down),
                          //         items: city.map((String items) {
                          //           return DropdownMenuItem(
                          //             value: items,
                          //             child: Text(items),
                          //           );
                          //         }).toList(),
                          //         // After selecting the desired option,it will
                          //         // change button value to selected value
                          //         onChanged: (String? newValue) {
                          //           setState(() {
                          //             dropdownvalueOfCity = newValue!;
                          //           });
                          //         }),
                          //   ),
                          // ),

                          // Text('Furnished',
                          //     style: GoogleFonts.lato(
                          //       textStyle: const TextStyle(
                          //           color: AppColors.textcolor,
                          //           fontSize: 14,
                          //           fontWeight: FontWeight.w500),
                          //     )),
                          // const SizedBox(
                          //   height: 5,
                          // ),
                          // Container(
                          //   padding: const EdgeInsets.symmetric(horizontal: 8),
                          //   decoration: BoxDecoration(
                          //     color: Colors.white,
                          //     borderRadius: BorderRadius.circular(12),
                          //       border: Border.all(
                          //         color: Color.fromARGB(227, 193, 192, 192),
                          //         width: 0.5),
                          //     boxShadow: [
                          //       BoxShadow(
                          //         color:
                          //             const Color.fromARGB(147, 193, 192, 192)
                          //                 .withOpacity(0.5),
                          //         spreadRadius: 1,
                          //         blurRadius: 1,
                          //         offset: const Offset(0, 2),
                          //       ),
                          //     ],
                          //   ),
                          //   child: DropdownButtonHideUnderline(
                          //     child: DropdownButton(
                          //         hint: Padding(
                          //           padding: const EdgeInsets.only(left: 8),
                          //           child: Text("Room",
                          //               style: GoogleFonts.lato(
                          //                   color: AppColors.HintTextColor)),
                          //         ),
                          //         isExpanded: true,
                          //         value: dropdownvalueOfroom,
                          //         icon: const Icon(Icons.keyboard_arrow_down),
                          //         items: roomtype.map((String items) {
                          //           return DropdownMenuItem(
                          //             value: items,
                          //             child: Text(
                          //               items,
                          //             ),
                          //           );
                          //         }).toList(),
                          //         // After selecting the desired option,it will
                          //         // change button value to selected value
                          //         onChanged: (String? newValue) {
                          //           setState(() {
                          //             dropdownvalueOfroom = newValue!;
                          //           });
                          //         }),
                          //   ),
                          // ),
                          // const SizedBox(
                          //   height: 12,
                          // ),
                          Text(TextScreen.Categories,
                              style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                                    color: AppColors.textcolor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              )),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                              width: Get.width,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        const Color.fromARGB(147, 193, 192, 192)
                                            .withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                    offset: const Offset(
                                        0, 2), // changes the shadow direction
                                  ),
                                ],
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  hint: Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Text("Category",
                                        style: GoogleFonts.lato(
                                            color: AppColors.HintTextColor)),
                                  ),
                                  value: selectedOption,
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  items: newMapOfMonths.keys.map((key) {
                                    return DropdownMenuItem(
                                      value: newMapOfMonths[key],
                                      child: Text(
                                        key.toString(),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedOption = value.toString();
                                      // Find the corresponding key for the selected value
                                      selectedKey =
                                          newMapOfMonths.keys.firstWhere(
                                        (key) => newMapOfMonths[key] == value,
                                        orElse: () =>
                                            null, // Handle if no match is found
                                      );
                                      print(
                                          "Selectservice============>${selectedKey}");
                                      print(
                                          "serviceid============>${selectedOption}");
                                    });
                                  },
                                ),
                              )
                              // DropdownButtonHideUnderline(
                              //   child: DropdownButton(
                              //       hint: Padding(
                              //         padding:  EdgeInsets.only(left: 5),
                              //         child: Text("Category",
                              //             style: GoogleFonts.lato(
                              //               textStyle: TextStyle(
                              //                 color: AppColors.txtgreyclr,
                              //                 fontSize: 15,
                              //               ),
                              //             )),
                              //       ),
                              //       // isExpanded: true,
                              //       value: selectedOption,
                              //       icon: const Icon(Icons.keyboard_arrow_down),
                              //       items: newMapOfMonths.map((key,value) {
                              //         return MapEntry(key,
                              //             DropdownMenuItem(
                              //           value: value,
                              //           child: Text(key.toString(),
                              //             style: TextStyle(
                              //                 color: Colors.grey,fontSize: 18
                              //             ),
                              //           ),
                              //         ));
                              //       }).values.toList(),
                              //       onChanged: (value) {
                              //         setState(() {
                              //           selectedOption=value.toString();
                              //           // serviceid=value.toString();
                              //           // print("serviceid============>${serviceid.toString()}");
                              //           print("selectedOption============>${selectedOption.toString()}");
                              //
                              //         });
                              //
                              //       },
                              //        ),
                              // ),

                              ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(TextScreen.facilities_add,
                              style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                                    color: AppColors.textcolor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              )),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Container(
                              //   width: MediaQuery.of(context).size.width/1.8,
                              //   padding: EdgeInsets.symmetric(horizontal: 22, vertical: 18),
                              //   decoration: BoxDecoration(
                              //     color: Color(0xffEAEDF2),
                              //     border: Border.all(color: AppColors.addpropertyfillclr, width: 1),
                              //     borderRadius: BorderRadius.circular(10),
                              //   ),
                              //   child:  Text("Facilities",
                              //       style: GoogleFonts.lato(
                              //         textStyle: TextStyle(
                              //           color: AppColors.txtgreyclr,
                              //           fontSize: 15,
                              //         ),
                              //       )),
                              // ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color.fromARGB(
                                                147, 193, 192, 192)
                                            .withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 1,
                                        offset: const Offset(0,
                                            2), // changes the shadow direction
                                      ),
                                    ],
                                  ),
                                  child: TextField(
                                    controller: facilitiescontroller,
                                    // onSubmitted: (value) => dispose(),
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(20),
                                    ],
                                    // textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      hintText: 'Facilities',
                                      border: InputBorder.none,
                                      fillColor: Colors.white,
                                      filled: true,
                                      hintStyle: GoogleFonts.lato(
                                          color: AppColors.HintTextColor),
                                    ),
                                  ),
                                ),
                              ),
                              // Container(
                              //   width: MediaQuery.of(context).size.width / 1.8,
                              //   child: TextField(
                              //     controller: facilitiescontroller,
                              //     onSubmitted: (value) {
                              //       dispose();
                              //     },
                              //     inputFormatters: [
                              //       LengthLimitingTextInputFormatter(20),
                              //     ],
                              //     // controller: MobileController,
                              //     //obscureText: true,
                              //     decoration: InputDecoration(
                              //       // fillColor: AppColors.addpropertyfillclr,
                              //       fillColor: Colors.white,
                              //       filled: true,
                              //       hintText: "Facilities",
                              //       contentPadding: const EdgeInsets.symmetric(
                              //           horizontal: 22, vertical: 18),
                              //       hintStyle: GoogleFonts.lato(
                              //           color: AppColors.txtgreyclr,
                              //           fontSize: 15),
                              //       focusedBorder: OutlineInputBorder(
                              //         borderRadius: const BorderRadius.all(
                              //             Radius.circular(10)),
                              //         borderSide: BorderSide(
                              //             width: 1,
                              //             color: AppColors.addpropertyfillclr),
                              //       ),
                              //       disabledBorder: OutlineInputBorder(
                              //         borderRadius: const BorderRadius.all(
                              //             Radius.circular(10)),
                              //         borderSide: BorderSide(
                              //             width: 1,
                              //             color: AppColors.addpropertyfillclr),
                              //       ),
                              //       enabledBorder: OutlineInputBorder(
                              //         borderRadius: const BorderRadius.all(
                              //             Radius.circular(10)),
                              //         borderSide: BorderSide(
                              //             width: 1,
                              //             color: AppColors.addpropertyfillclr),
                              //       ),
                              //       border: const OutlineInputBorder(
                              //           borderRadius: BorderRadius.all(
                              //               Radius.circular(10)),
                              //           borderSide: BorderSide(
                              //             width: 1,
                              //           )),
                              //       errorBorder: OutlineInputBorder(
                              //           borderRadius: const BorderRadius.all(
                              //               Radius.circular(10)),
                              //           borderSide: BorderSide(
                              //               width: 1,
                              //               color:
                              //                   AppColors.addpropertyfillclr)),
                              //       focusedErrorBorder: OutlineInputBorder(
                              //           borderRadius: const BorderRadius.all(
                              //               Radius.circular(10)),
                              //           borderSide: BorderSide(
                              //               width: 1,
                              //               color:
                              //                   AppColors.addpropertyfillclr)),
                              //       // border: OutlineInputBorder(
                              //       //     borderRadius: BorderRadius.circular(20),
                              //       //     borderSide: new BorderSide(color: Color(0xffBFBFBF))
                              //       // )
                              //     ),
                              //   ),
                              // ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      facilitiescontroller.text.length >= 2
                                          ? facilitiesList
                                              .add(facilitiescontroller.text)
                                          : ToastMessage.msg(
                                              "Please enter valid Facilities");
                                      facilitiescontroller.clear();
                                      print(
                                          "facilitiesList====${facilitiesList}");
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 12),
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      border: Border.all(
                                          color: AppColors.addpropertyfillclr,
                                          width: 1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text("Add",
                                          style: GoogleFonts.lato(
                                            textStyle: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                            ),
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          facilitiesList.isEmpty
                              ? Container()
                              : Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 50,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: facilitiesList.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Stack(
                                        children: [
                                          Container(
                                            // height: 58,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 12),
                                            decoration: BoxDecoration(
                                              color: AppColors.primaryColor,
                                              // border: Border.all(
                                              //     color: AppColors
                                              //         .addpropertyfillclr,
                                              //     width: 1),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: Center(
                                              child: Text(
                                                  facilitiesList[index]
                                                      .toString(),
                                                  style: GoogleFonts.lato(
                                                    textStyle: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                    ),
                                                  )),
                                            ),
                                          ),
                                          Positioned(
                                              top: 0,
                                              right: 0,
                                              child: InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      print(facilitiesList
                                                          .length);
                                                      facilitiesList
                                                          .removeAt(index);
                                                      print(facilitiesList
                                                          .length);
                                                    });
                                                  },
                                                  child: Image.asset(
                                                    Images.cross,
                                                    height: 20,
                                                    width: 20,
                                                  ))),
                                        ],
                                      );
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) =>
                                            Container(
                                      width: 10,
                                    ),
                                  ),
                                ),

                          // GridView.builder(
                          //   shrinkWrap: true,
                          //     physics: NeverScrollableScrollPhysics(),
                          //     itemCount: facilitiesList.length,
                          //     gridDelegate:  SliverGridDelegateWithMaxCrossAxisExtent(
                          //         maxCrossAxisExtent: 100,
                          //          childAspectRatio: 2 / 1.5,
                          //         crossAxisSpacing: 10,
                          //         mainAxisSpacing: 20),
                          //     itemBuilder: (BuildContext ctx, index) {
                          //       return Stack(
                          //         children: [
                          //           Container(
                          //              // width: MediaQuery.of(context).size.width/2.5,
                          //              width: 200,
                          //              height: 58,
                          //             padding: EdgeInsets.symmetric(horizontal: 22, vertical: 18),
                          //             decoration: BoxDecoration(
                          //               color: AppColors.primaryColor,
                          //               border: Border.all(color: AppColors.addpropertyfillclr, width: 1),
                          //               borderRadius: BorderRadius.circular(10),
                          //             ),
                          //             child:  Center(
                          //               child: Text(facilitiesList[index].toString(),
                          //                   style: GoogleFonts.lato(
                          //                     textStyle: TextStyle(
                          //                       color: Colors.white,
                          //                       fontSize: 15,
                          //                     ),
                          //                   )),
                          //             ),
                          //           ),
                          //           Positioned(
                          //               top: 0,
                          //               right: 0,
                          //               child: InkWell(
                          //                   onTap: (){
                          //                     setState(() {
                          //                       print(facilitiesList.length);
                          //                       facilitiesList.removeAt(index);
                          //                       print(facilitiesList.length);
                          //                     });
                          //                   },
                          //                   child: Image.asset(Images.cross,height: 24,width: 24,))),
                          //         ],
                          //       );
                          //     }),
                          const SizedBox(
                            height: 12,
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Container(
                          //       width: MediaQuery.of(context).size.width/2.3,
                          //       padding: EdgeInsets.symmetric(horizontal: 22, vertical: 18),
                          //       decoration: BoxDecoration(
                          //         color: AppColors.primaryColor,
                          //         border: Border.all(color: AppColors.addpropertyfillclr, width: 1),
                          //         borderRadius: BorderRadius.circular(10),
                          //       ),
                          //       child:  Center(
                          //         child: Text("AC",
                          //             style: GoogleFonts.lato(
                          //               textStyle: TextStyle(
                          //                 color: Colors.white,
                          //                 fontSize: 15,
                          //               ),
                          //             )),
                          //       ),
                          //     ),
                          //     Container(
                          //       width: MediaQuery.of(context).size.width/2.3,
                          //       padding: EdgeInsets.symmetric(horizontal: 22, vertical: 18),
                          //       decoration: BoxDecoration(
                          //         color: AppColors.primaryColor,
                          //         border: Border.all(color: AppColors.addpropertyfillclr, width: 1),
                          //         borderRadius: BorderRadius.circular(10),
                          //       ),
                          //       child:  Center(
                          //         child: Text("TV",
                          //             style: GoogleFonts.lato(
                          //               textStyle: TextStyle(
                          //                 color: Colors.white,
                          //                 fontSize: 15,
                          //               ),
                          //             )),
                          //       ),
                          //     ),
                          //
                          //   ],
                          // ),

                          GestureDetector(
                            onTap: (() => _showPicker(context)),
                            child: Container(
                              width: Get.width,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 8.0),
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(70, 201, 225, 222),
                                  border: Border.all(
                                      color: AppColors.primaryColor,
                                      width: 1,
                                      style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Image.asset(
                                      'assets/images/pencil-1.png',
                                      height: 40,
                                    ),
                                  ),
                                  Text("+ Add Images",
                                      style: GoogleFonts.lato(
                                        textStyle: const TextStyle(
                                            color: AppColors.primaryColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      )),
                                  Text(
                                      "(Click from camera or browse to upload)",
                                      style: GoogleFonts.lato(
                                        textStyle: const TextStyle(
                                            color: Color(0xffB2B2B2),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300),
                                      )),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          // Stack(
                          //   children: [
                          //     Container(
                          //       height: MediaQuery.of(context).size.height*0.18,
                          //       width: MediaQuery.of(context).size.width,
                          //       decoration: BoxDecoration(
                          //         borderRadius: BorderRadius.circular(10),
                          //         color: Colors.transparent,
                          //       ),
                          //       child: ClipRRect(
                          //           borderRadius: BorderRadius.circular(10),
                          //           child: Image.asset(Images.room_img,fit: BoxFit.fill,)),
                          //     ),
                          //     Positioned(
                          //         top: 0,
                          //         right: 0,
                          //         child: Image.asset(Images.cross,height: 40,))
                          //
                          //   ],
                          // ),
                          ListView.builder(
                              itemCount: _assetImgList.length,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                File asset = _assetImgList[index];
                                return Stack(
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.18,
                                      width: MediaQuery.of(context).size.width,
                                      margin: const EdgeInsets.only(top: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.transparent,
                                      ),
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.file(
                                            asset,
                                            fit: BoxFit.fill,
                                          )),
                                    ),
                                    Positioned(
                                        top: 0,
                                        right: 0,
                                        child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                print(_assetImgList.length);
                                                _assetImgList.removeAt(index);
                                                print(_assetImgList.length);
                                              });
                                            },
                                            child: Image.asset(
                                              Images.cross,
                                              height: 40,
                                            ))),
                                  ],
                                );
                              }),
                          const SizedBox(
                            height: 12,
                          ),
                          Center(
                            child: MaterialButton(
                              onPressed: () {
                                Helper.checkInternet(addRoommatesApiNow());
                                // Get.to(OtpScreen());
                                // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ServicesTabbar()));
                              },
                              color: AppColors.NewButtonColor,
                              textColor: Colors.black,
                              minWidth: 320,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                              child: Text(
                                'Submit',
                                style: GoogleFonts.lato(
                                  textStyle:
                                      Theme.of(context).textTheme.displayLarge,
                                  fontSize: 20,
                                  color: AppColors.ButtonTextColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
          Positioned(child: Helper.getProgressBar(context, _isVisible))
        ],
      ),
    );
  }

  setProgress(bool show) {
    if (mounted)
      setState(() {
        _isVisible = show;
      });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _selectFurinshed(int index) {
    setState(() {
      furnishedIndex = furnishedIndex == index ? null : index;
    });

    if (furnishedIndex != null) {
      selectedFurnished = '';
      selectedFurnished = furnished[furnishedIndex!];
    }
    print('Selected Container Index: $selectedFurnished');
  }

  _imgFromCamera() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );
    setState(() {
      _image = File(image!.path);
      print("_image====${_image}");
      print("_image=====2==${_image!.path}");
      // imageList.insert(imageList.length, image as File);
      _assetImgList.insert(_assetImgList.length, _image as File);
      // print("imageList=======${imageList.toString()}");
      Helper.checkInternet(addPropertyImagesApi(image.path));
    });
  }

  _imgFromGallery() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    // _image=_cropImage(image);
    setState(() {
      _image = File(image!.path);
      // String path = _image.toString();
      print("path" + _image!.path);
      _assetImgList.insert(_assetImgList.length, _image as File);
      Helper.checkInternet(addPropertyImagesApi(image.path));
    });

    // Helper.checkInternet(uploadImage(_image!.path));
  }

  Future<void> getPropertyCategoryapi() async {
    print("<=============getPropertyCategoryapi=============>");

    setProgress(true);

    final prefs = await SharedPreferences.getInstance();
    var user_id = await prefs.getString('user_id');
    try {
      var res = await http
          .get(Uri.parse(Api.getPropertyCategory + "?user_id=${user_id}"));
      // var res = await http.post(Uri.parse(Api.getMyServiceList), );
      print("Response ============>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);

          GetPropertyCategoryModel model =
              GetPropertyCategoryModel.fromJson(jsonResponse);

          if (model.status == "true") {
            restaurent.addAll(model.categoryList);

            _restaurent.clear();
            for (int i = 0; i < restaurent.length; i++) {
              _restaurent.add(restaurent[i].category.toString());
              newMapOfMonths[restaurent[i].category] = restaurent[i].categoryId;
              print(newMapOfMonths);
            }
            setState(() {
              getPropertyCategoryModel = model;
              // if(widget.service_name ==""){
              //   selectedOption="3";
              // }else{
              selectedOption = getPropertyCategoryModel!
                  .categoryList[0].categoryId
                  .toString();
              // }
            });

            setProgress(false);
            // ToastMessage.msg(model.message.toString());

            // Helper.moveToScreenwithPush(context, OtpVerifyScreen(number: model.data!.phone.toString(),));
            // sessionHelper.put(SessionHelper.NAME,model.data!.name.toString());
            // sessionHelper.put(SessionHelper.EMAIL,model.data!.email.toString());
            // sessionHelper.put(SessionHelper.IMAGE,model.data!.image.toString());
            // sessionHelper.put(SessionHelper.DOB,model.data!.dob.toString());
            // sessionHelper.put(SessionHelper.USER_ID,model.data!.userId.toString());
          } else {
            getPropertyCategoryModel = null;
            setProgress(false);
            print("false ============>");
            // ToastMessage.msg(model.message.toString());
          }
        } catch (e) {
          print("false ============>");
          ToastMessage.msg(StaticMessages.API_ERROR);
          print('exception ==> ' + e.toString());
        }
      } else {
        print("status code ==> " + res.statusCode.toString());
        ToastMessage.msg(StaticMessages.API_ERROR);
      }
    } catch (e) {
      ToastMessage.msg(StaticMessages.API_ERROR);
      print('Exception ======> ' + e.toString());
    }
    setProgress(false);
  }

  // Future<void> addPropertyApi() async {
  //   print("<=============addPropertyApi =============>");
  //   setProgress(true);
  //   final prefs = await SharedPreferences.getInstance();
  //   var user_id = await prefs.getString('user_id');

  //   Map data = {
  //     'user_id': user_id.toString(),
  //     'title': titlecontroller.text.tr,
  //     'description': descriptioncontroller.text.tr,
  //     'address': addresscontroller.text.toString(),
  //     'mobile': numbercontroller.text.toString(),
  //     'rent': rentcontroller.text.toString(),
  //     'city': citycontroller.text.toString(),
  //     'roomtype': dropdownvalueOfroom.toString(),
  //     'category': selectedKey.toString(),
  //     'facilities': facilitiesList.toString(),
  //     'image': imageList.toString()
  //   };

  //   print("Request =============>" + data.toString());
  //   try {
  //     var res = await http.post(Uri.parse(Api.addProperty), body: data);
  //     print("Response ============>" + res.body);

  //     if (res.statusCode == 200) {
  //       try {
  //         final jsonResponse = jsonDecode(res.body);
  //         CommonModel model = CommonModel.fromJson(jsonResponse);

  //         if (model.status == "true") {
  //           print("Model status true");

  //           setProgress(false);

  //           // setState(() {
  //           //   getPropertyList = model;
  //           // });
  //           Helper.moveToScreenwithPushreplaceemt(
  //               context, const ServicesTabbar());
  //           // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Setting3()));
  //           // ToastMessage.msg(model.message.toString());
  //         } else {
  //           // setState(() {
  //           //   _hasData = false;
  //           // });
  //           setProgress(false);
  //           print("false ### ============>");
  //           ToastMessage.msg(model.message.toString());
  //         }
  //       } catch (e) {
  //         print("false ============>");
  //         ToastMessage.msg(StaticMessages.API_ERROR);
  //         print('exception ==> ' + e.toString());
  //       }
  //     } else {
  //       print("status code ==> " + res.statusCode.toString());
  //       ToastMessage.msg(StaticMessages.API_ERROR);
  //     }
  //   } catch (e) {
  //     ToastMessage.msg(StaticMessages.API_ERROR);
  //     print('Exception ======> ' + e.toString());
  //   }
  //   setProgress(false);
  // }

  Future<void> addPropertyImagesApi(filename) async {
    print("<==============addPropertyImagesApi===============>");

    final prefs = await SharedPreferences.getInstance();
    var user_id = await prefs.getString('user_id');
    // setProgress(true);

    var request =
        http.MultipartRequest('POST', Uri.parse(Api.addPropertyImages));

    request.fields['user_id'] = user_id!;
    request.files.add(await http.MultipartFile.fromPath('image', filename));

    print(request.fields);
    print(request.files);

    var res = await request.send();

    if (res.statusCode == 200) {
      setProgress(false);
      try {
        res.stream.transform(utf8.decoder).listen((value) async {
          final jsonResponse = jsonDecode(value);

          AddPropertyImagesModel model =
              AddPropertyImagesModel.fromJson(jsonResponse);

          if (model.status == "true") {
            setProgress(false);
            ToastMessage.msg("Image uploaded successfully");

            print("imagesss========================>>>>>>>>${model.image}");

            imageList.add(model.image);

            print("imageList================>${imageList.toString()}");

            ToastMessage.msg(model.message.toString());
          } else {
            ToastMessage.msg(model.message.toString());
          }
        });
      } catch (e) {
        print('exception ==> ' + e.toString());
        ToastMessage.msg(StaticMessages.API_ERROR);
      }
    } else {
      print("status code ==> " + res.statusCode.toString());
      ToastMessage.msg(StaticMessages.API_ERROR);
    }
    setProgress(false);
  }

  Future<void> addRoommatesApiNow() async {

    final prefs = await SharedPreferences.getInstance();
    var user_id = await prefs.getString('user_id');
    setProgress(true);
    var headers = {
      'Accept-Encoding': 'gzip,deflat,br',
      'Connection': 'keep alive',
      'Accept': 'application/json',
      'Cookie': 'ci_session=g32tearkq4b70s55bstrcq6mu6blu0lj'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://dhoondle.com/Dhoondle/api/roommate/create'));
    request.fields.addAll({
      'user_id': '1',
      'local_address': addresscontroller.text,
      'contact_no': numbercontroller.text.toString(),
      'whatsapp_no': whatsAppController.text.toString(),
      'city_address': addresscontroller.text,
      'city': 'Indore',
      'address': roomLocationController.text,
      'profession': professionController.text,
      'profession_description': describeProfisionController.text,
      'live_in': ' indore',
      'status': ' 1',
      'image': _image!.path
    });
    request.files.add(await http.MultipartFile.fromPath('image', _image!.path));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    print('--------ijk-------${_image!.path}');
    if (response.statusCode == 200) {
      var Result = await response.stream.bytesToString();
      final finalResult = json.decode(Result);
      String msg = finalResult['message'];
      print('-------------${msg}');
      setProgress(false);
      Get.toNamed('/roomscreen');
    } else {
      setProgress(true);
      print(response.reasonPhrase);
    }
  }
}
