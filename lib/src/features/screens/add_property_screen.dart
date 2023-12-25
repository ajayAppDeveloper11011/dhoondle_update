import 'dart:convert';
import 'dart:io';

import 'package:dhoondle/src/features/screens/services_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
import '../../api_model/add_property_images_model.dart';
import '../../api_model/get_property_model.dart';
import '../../constants/Api.dart';
import '../../constants/colors.dart';
import '../../constants/helper.dart';
import '../../constants/images.dart';
import '../../constants/text.dart';
import '../controllers/common_model.dart';

class AddPropertyScreen extends StatefulWidget {
  const AddPropertyScreen({super.key});

  @override
  State<AddPropertyScreen> createState() => _AddPropertyScreenState();
}

class _AddPropertyScreenState extends State<AddPropertyScreen> {

  var city = [
    "Indore",
    "Bhopal",
    "Ujjain",
    "Mumbai",
  ];

  var roomtype = [
    "Semi furnished",
    "Fully furnished",
    "Unfurnished"
  ];

  var catagory = [
    "Studio room",
    "1RK",
  ];
  String? dropdownvalueOfCity = null;
  String? dropdownvalueOfroom = null;
  String? dropdownvalueOfCatagory = null;

  bool _isVisible = false;
  String restaurentText = '';
  List<CategoryList> restaurent = [];
  List<String> _restaurent = [];
  Map newMapOfMonths={};
  GetPropertyCategoryModel? getPropertyCategoryModel;
  String selectedKey="";
  String selectedOption="";

  File? _image;
  final _picker = ImagePicker();
  List imageList=[];
  List facilitiesList=[];
  String getImage="";
  List<File> _assetImgList = <File>[];

  TextEditingController titlecontroller=TextEditingController();
  TextEditingController descriptioncontroller=TextEditingController();
  TextEditingController addresscontroller=TextEditingController();
  TextEditingController numbercontroller=TextEditingController();
  TextEditingController rentcontroller=TextEditingController();
  TextEditingController citycontroller=TextEditingController();
  TextEditingController facilitiescontroller=TextEditingController();

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
        toolbarHeight: 80,
        leading: InkWell(
          onTap: () {
            Helper.popScreen(context);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Icon(Icons.arrow_back,color: Colors.white,),
          ),
        ),
        centerTitle: true,
        elevation: 0,
        title: Text(TextScreen.add_property,
            style: GoogleFonts.roboto(
              textStyle: TextStyle(
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
          getPropertyCategoryModel==null?
          Container():
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(TextScreen.title,
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: AppColors.textcolor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        )),
                    SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: titlecontroller,
                      //obscureText: true,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        // fillColor: AppColors.addpropertyfillclr,
                        fillColor: Color(0xffEAEDF2),
                        filled: true,
                        hintText: "Title",
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 22, vertical: 18),
                        hintStyle: GoogleFonts.poppins(
                            color: AppColors.txtgreyclr, fontSize: 15),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                              width: 1, color: AppColors.addpropertyfillclr),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                              width: 1, color: AppColors.addpropertyfillclr),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                              width: 1, color: AppColors.addpropertyfillclr),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              width: 1,
                            )),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                                width: 1, color: AppColors.addpropertyfillclr)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                                width: 1, color: AppColors.addpropertyfillclr)),
                        // border: OutlineInputBorder(
                        //     borderRadius: BorderRadius.circular(20),
                        //     borderSide: new BorderSide(color: Color(0xffBFBFBF))
                        // )
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(TextScreen.description,
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: AppColors.textcolor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        )),
                    SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: descriptioncontroller,
                      maxLines: 2,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(250),
                      ],
                      // controller: MobileController,
                      //obscureText: true,
                      decoration: InputDecoration(
                        // fillColor: AppColors.addpropertyfillclr,
                        fillColor: Color(0xffEAEDF2),
                        filled: true,
                        hintText: "Description",
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 22, vertical: 18),
                        hintStyle: GoogleFonts.poppins(
                            color: AppColors.txtgreyclr, fontSize: 15),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                              width: 1, color: AppColors.addpropertyfillclr),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                              width: 1, color: AppColors.addpropertyfillclr),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                              width: 1, color: AppColors.addpropertyfillclr),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              width: 1,
                            )),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                                width: 1, color: AppColors.addpropertyfillclr)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                                width: 1, color: AppColors.addpropertyfillclr)),
                        // border: OutlineInputBorder(
                        //     borderRadius: BorderRadius.circular(20),
                        //     borderSide: new BorderSide(color: Color(0xffBFBFBF))
                        // )
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(TextScreen.address,
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: AppColors.textcolor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        )),
                    SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: addresscontroller,
                      // controller: MobileController,
                      //obscureText: true,
                      decoration: InputDecoration(
                        // fillColor: AppColors.addpropertyfillclr,
                        fillColor: Color(0xffEAEDF2),
                        filled: true,
                        hintText: "Address",
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 22, vertical: 18),
                        hintStyle: GoogleFonts.poppins(
                            color: AppColors.txtgreyclr, fontSize: 15),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                              width: 1, color: AppColors.addpropertyfillclr),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                              width: 1, color: AppColors.addpropertyfillclr),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                              width: 1, color: AppColors.addpropertyfillclr),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              width: 1,
                            )),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                                width: 1, color: AppColors.addpropertyfillclr)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                                width: 1, color: AppColors.addpropertyfillclr)),
                        // border: OutlineInputBorder(
                        //     borderRadius: BorderRadius.circular(20),
                        //     borderSide: new BorderSide(color: Color(0xffBFBFBF))
                        // )
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(TextScreen.phone,
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: AppColors.textcolor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        )),
                    SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: numbercontroller,
                      // controller: MobileController,
                      //obscureText: true,
                      keyboardType: TextInputType.number,
                      inputFormatters: [LengthLimitingTextInputFormatter(11)],
                      decoration: InputDecoration(
                        // fillColor: AppColors.addpropertyfillclr,
                        fillColor: Color(0xffEAEDF2),
                        filled: true,
                        hintText: "+91",
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Image.asset(
                            Images.telephonetxtfield,
                            height: 5,
                          ),
                        ),
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 22, vertical: 18),
                        hintStyle: GoogleFonts.poppins(
                            color: AppColors.txtgreyclr, fontSize: 15),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                              width: 1, color: AppColors.addpropertyfillclr),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                              width: 1, color: AppColors.addpropertyfillclr),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                              width: 1, color: AppColors.addpropertyfillclr),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              width: 1,
                            )),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                                width: 1, color: AppColors.addpropertyfillclr)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                                width: 1, color: AppColors.addpropertyfillclr)),
                        // border: OutlineInputBorder(
                        //     borderRadius: BorderRadius.circular(20),
                        //     borderSide: new BorderSide(color: Color(0xffBFBFBF))
                        // )
                      ),
                    ),

                    SizedBox(
                      height: 12,
                    ),
                    Text(TextScreen.rent_price,
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: AppColors.textcolor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        )),
                    SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: rentcontroller,
                      keyboardType: TextInputType.number,
                      // controller: MobileController,
                      //obscureText: true,
                      decoration: InputDecoration(
                        // fillColor: AppColors.addpropertyfillclr,
                        fillColor: Color(0xffEAEDF2),
                        filled: true,
                        hintText: "Rent",
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 22, vertical: 18),
                        hintStyle: GoogleFonts.poppins(
                            color: AppColors.txtgreyclr, fontSize: 15),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                              width: 1, color: AppColors.addpropertyfillclr),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                              width: 1, color: AppColors.addpropertyfillclr),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                              width: 1, color: AppColors.addpropertyfillclr),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              width: 1,
                            )),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                                width: 1, color: AppColors.addpropertyfillclr)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                                width: 1, color: AppColors.addpropertyfillclr)),
                        // border: OutlineInputBorder(
                        //     borderRadius: BorderRadius.circular(20),
                        //     borderSide: new BorderSide(color: Color(0xffBFBFBF))
                        // )
                      ),
                    ),

                    SizedBox(
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
                    //               style: GoogleFonts.poppins(
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
                    Text(TextScreen.City,
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: AppColors.textcolor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        )),
                    SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: citycontroller,
                      // controller: MobileController,
                      //obscureText: true,
                      decoration: InputDecoration(
                        // fillColor: AppColors.addpropertyfillclr,
                        fillColor: Color(0xffEAEDF2),
                        filled: true,
                        hintText: "City",
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 22, vertical: 18),
                        hintStyle: GoogleFonts.poppins(
                            color: AppColors.txtgreyclr, fontSize: 15),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                              width: 1, color: AppColors.addpropertyfillclr),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                              width: 1, color: AppColors.addpropertyfillclr),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                              width: 1, color: AppColors.addpropertyfillclr),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              width: 1,
                            )),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                                width: 1, color: AppColors.addpropertyfillclr)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                                width: 1, color: AppColors.addpropertyfillclr)),
                        // border: OutlineInputBorder(
                        //     borderRadius: BorderRadius.circular(20),
                        //     borderSide: new BorderSide(color: Color(0xffBFBFBF))
                        // )
                      ),
                    ),

                    SizedBox(
                      height: 12,
                    ),
                    Text(TextScreen.room_type,
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: AppColors.textcolor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        )),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(horizontal: 22, vertical: 6),
                      decoration: BoxDecoration(
                        color: Color(0xffEAEDF2),
                        border: Border.all(color: AppColors.addpropertyfillclr, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                            hint: Padding(
                              padding:  EdgeInsets.only(left: 5),
                              child: Text("Room",
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      color: AppColors.txtgreyclr,
                                      fontSize: 15,
                                    ),
                                  )),
                            ),
                            isExpanded: true,
                            value: dropdownvalueOfroom,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: roomtype.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
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
                    SizedBox(
                      height: 12,
                    ),
                    Text(TextScreen.Categories,
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: AppColors.textcolor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        )),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(horizontal: 22, vertical: 6),
                        decoration: BoxDecoration(
                          color: Color(0xffEAEDF2),
                          border: Border.all(color: AppColors.addpropertyfillclr, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child:  DropdownButtonHideUnderline(
                          child: DropdownButton(
                            hint: Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: Text("Category",
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      color: AppColors.txtgreyclr,
                                      fontSize: 15,
                                    ),
                                  )),
                            ),
                            value: selectedOption,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: newMapOfMonths.keys.map((key) {
                              return DropdownMenuItem(
                                value: newMapOfMonths[key],
                                child: Text(
                                  key.toString(),
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 18,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedOption = value.toString();
                                // Find the corresponding key for the selected value
                                selectedKey = newMapOfMonths.keys.firstWhere(
                                      (key) => newMapOfMonths[key] == value,
                                  orElse: () => null, // Handle if no match is found
                                );
                                print("Selectservice============>${selectedKey}");
                                print("serviceid============>${selectedOption}");
                              });
                            },
                          ),
                        )
                      // DropdownButtonHideUnderline(
                      //   child: DropdownButton(
                      //       hint: Padding(
                      //         padding:  EdgeInsets.only(left: 5),
                      //         child: Text("Category",
                      //             style: GoogleFonts.poppins(
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
                    SizedBox(
                      height: 12,
                    ),
                    Text(TextScreen.facilities_add,
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: AppColors.textcolor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        )),
                    SizedBox(
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
                        //       style: GoogleFonts.poppins(
                        //         textStyle: TextStyle(
                        //           color: AppColors.txtgreyclr,
                        //           fontSize: 15,
                        //         ),
                        //       )),
                        // ),
                        Container(
                          width: MediaQuery.of(context).size.width/1.8,
                          child: TextField(
                            controller: facilitiescontroller,
                            onSubmitted:(value) {
                              dispose();
                            },
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(20),
                            ],
                            // controller: MobileController,
                            //obscureText: true,
                            decoration: InputDecoration(
                              // fillColor: AppColors.addpropertyfillclr,
                              fillColor: Color(0xffEAEDF2),
                              filled: true,
                              hintText: "Facilities",
                              contentPadding:
                              EdgeInsets.symmetric(horizontal: 22, vertical: 18),
                              hintStyle: GoogleFonts.poppins(
                                  color: AppColors.txtgreyclr, fontSize: 15),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(
                                    width: 1, color: AppColors.addpropertyfillclr),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(
                                    width: 1, color: AppColors.addpropertyfillclr),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(
                                    width: 1, color: AppColors.addpropertyfillclr),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                    width: 1,
                                  )),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                      width: 1, color: AppColors.addpropertyfillclr)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                      width: 1, color: AppColors.addpropertyfillclr)),
                              // border: OutlineInputBorder(
                              //     borderRadius: BorderRadius.circular(20),
                              //     borderSide: new BorderSide(color: Color(0xffBFBFBF))
                              // )
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            setState(() {
                              facilitiesList.add(facilitiescontroller.text);
                              print("facilitiesList====${facilitiesList}");
                            });
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width/3.2,
                            padding: EdgeInsets.symmetric(horizontal: 22, vertical: 18),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              border: Border.all(color: AppColors.addpropertyfillclr, width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child:  Center(
                              child: Text("Add",
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    facilitiesList.isEmpty ?
                    Container():

                    Container(
                      width:MediaQuery.of(context).size.width ,
                      height: 58,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: facilitiesList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Stack(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 10),
                                  // width: MediaQuery.of(context).size.width/2.5,
                                  width: 220,
                                  height: 58,
                                  padding: EdgeInsets.symmetric(horizontal: 22, vertical: 18),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    border: Border.all(color: AppColors.addpropertyfillclr, width: 1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child:  Center(
                                    child: Text(facilitiesList[index].toString(),
                                        style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
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
                                        onTap: (){
                                          setState(() {
                                            print(facilitiesList.length);
                                            facilitiesList.removeAt(index);
                                            print(facilitiesList.length);
                                          });
                                        },
                                        child: Image.asset(Images.cross,height: 24,width: 24,))),
                              ],
                            );
                          }),
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
                    //                   style: GoogleFonts.poppins(
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
                    SizedBox(height: 12),
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
                    //             style: GoogleFonts.poppins(
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
                    //             style: GoogleFonts.poppins(
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
                    SizedBox(height: 12),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: (){
                            _showPicker(context);
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height*0.15,
                            width: MediaQuery.of(context).size.width/3,
                            padding: EdgeInsets.symmetric(horizontal: 22, vertical: 18),
                            decoration: BoxDecoration(
                              // color: AppColors.primaryColor,
                              border: Border.all(color: AppColors.addpropertyfillclr, width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child:  Center(
                                child: Icon(Icons.add,size: 50,color: AppColors.primaryColor,)
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Add Images of \nyour previous work",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: Color(0xffB2B2B2),
                                  fontSize: 14,fontWeight: FontWeight.w300
                              ),
                            )),


                      ],
                    ),
                    SizedBox(
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
                          return  Stack(
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height*0.18,
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.only(top: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.transparent,
                                ),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child:
                                    Image.file(asset, fit: BoxFit.fill,)
                                ),
                              ),
                              Positioned(
                                  top: 0,
                                  right: 0,
                                  child: InkWell(
                                      onTap: (){
                                        setState(() {
                                          print(_assetImgList.length);
                                          _assetImgList.removeAt(index);
                                          print(_assetImgList.length);
                                        });
                                      },
                                      child: Image.asset(Images.cross,height: 40,))),
                            ],
                          );
                        }),
                    SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: MaterialButton(
                        onPressed: () {
                          Helper.checkInternet(addPropertyApi());
                          // Get.to(OtpScreen());
                          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ServicesTabbar()));

                        },
                        color: AppColors.primaryColor,
                        textColor: Colors.black,
                        minWidth: 320,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        child: Text(
                          'Submit',
                          style: GoogleFonts.roboto(
                            textStyle: Theme.of(context).textTheme.displayLarge,
                            fontSize: 20,
                            color: AppColors.ButtonTextColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
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
      String path = _image.toString();
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
    var user_id=   await prefs.getString('user_id');
    try{
      var res = await http.get(Uri.parse(Api.getPropertyCategory+"?user_id=${user_id}"));
      // var res = await http.post(Uri.parse(Api.getMyServiceList), );
      print("Response ============>"+ res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);

          GetPropertyCategoryModel model = GetPropertyCategoryModel.fromJson(jsonResponse);

          if (model.status == "true") {
            restaurent.addAll(model.categoryList);


            _restaurent.clear();
            for(int i=0; i< restaurent.length; i++){
              _restaurent.add(restaurent[i].category.toString());
              newMapOfMonths[restaurent[i].category] = restaurent[i].categoryId;
              print(newMapOfMonths);

            }
            setState(() {
              getPropertyCategoryModel = model;
              // if(widget.service_name ==""){
              //   selectedOption="3";
              // }else{
              selectedOption =getPropertyCategoryModel!.categoryList[0].categoryId.toString();
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
          }
          else{

            getPropertyCategoryModel = null;
            setProgress(false);
            print("false ============>");
            // ToastMessage.msg(model.message.toString());
          }
        }
        catch (e) {

          print("false ============>");
          ToastMessage.msg(StaticMessages.API_ERROR);
          print('exception ==> '+ e.toString());
        }
      }else {

        print("status code ==> "+res.statusCode.toString());
        ToastMessage.msg(StaticMessages.API_ERROR);
      }
    }catch (e) {

      ToastMessage.msg(StaticMessages.API_ERROR);
      print('Exception ======> '+ e.toString());
    }
    setProgress(false);
  }



  Future<void>addPropertyApi() async {
    print("<=============addPropertyApi =============>");
    setProgress(true);
    final prefs = await SharedPreferences.getInstance();
    var user_id=   await prefs.getString('user_id');


    Map data = {
      'user_id': user_id.toString(),
      'title':titlecontroller.text.tr,
      'description':descriptioncontroller.text.tr,
      'address':addresscontroller.text.toString(),
      'mobile':numbercontroller.text.toString(),
      'rent':rentcontroller.text.toString(),
      'city':citycontroller.text.toString(),
      'roomtype':dropdownvalueOfroom.toString(),
      'category':selectedKey.toString(),
      'facilities':facilitiesList.toString(),
      'image':imageList.toString()
    };

    print("Request =============>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Api.addProperty), body: data);
      print("Response ============>" + res.body);

      if (res.statusCode == 200) {

        try {
          final jsonResponse = jsonDecode(res.body);
          CommonModel model = CommonModel.fromJson(jsonResponse);

          if (model.status == "true") {
            print("Model status true");

            setProgress(false);

            // setState(() {
            //   getPropertyList = model;
            // });
            Helper.moveToScreenwithPushreplaceemt(context, ServicesTabbar());
            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Setting3()));
            // ToastMessage.msg(model.message.toString());
          } else {
            // setState(() {
            //   _hasData = false;
            // });
            setProgress(false);
            print("false ### ============>");
            ToastMessage.msg(model.message.toString());
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


  Future<void> addPropertyImagesApi(filename) async {

    print("<==============addPropertyImagesApi===============>");


    final prefs = await SharedPreferences.getInstance();
    var user_id=   await prefs.getString('user_id');
    setProgress(true);

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

          AddPropertyImagesModel model = AddPropertyImagesModel.fromJson(jsonResponse);

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
}
