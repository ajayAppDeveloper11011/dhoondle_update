import 'dart:convert';
import 'dart:io';
import 'package:dhoondle/src/features/screens/services_tabbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../api_model/add_service_images_model.dart';
import '../../api_model/edit_service_model.dart';
import '../../api_model/service_list_api.dart';
import '../../constants/Api.dart';
import '../../constants/colors.dart';
import '../../constants/helper.dart';
import '../../constants/images.dart';
import '../../constants/text.dart';
import '../controllers/common_model.dart';

class EditServiceScreen extends StatefulWidget {
  String service_id = "";
  String service_name = "";
  String service_des = "";
  String number = "";
  String address = "";
  String serviceImage;
  String serviceCategory;
  String whichscreen;
  String experience;
  EditServiceScreen({
    required this.service_id,
    required this.serviceCategory,
    required this.service_name,
    required this.service_des,
    required this.number,
    required this.address,
    required this.serviceImage,
    required this.experience,
    required this.whichscreen,
  });

  @override
  State<EditServiceScreen> createState() => _EditServiceScreenState();
}

class _EditServiceScreenState extends State<EditServiceScreen> {
  var chooseservice = [
    "Plumbing",
    "Carpainting",
    "Cleaning",
  ];

  String? dropdownvalueOfChooseService = null;
  String? dropdownvalueOfroom = null;
  String? dropdownvalueOfCatagory = null;
  bool _isVisible = false;
  bool _hasData = true;
  String restaurentText = '';
  List<ServiceList> restaurent = [];
  List<String> _restaurent = [];
  Map newMapOfMonths = {};
  ServiceListApiModel? serviceListApiModel;
  EditServiceModel? _editServiceModel;
  TextEditingController descriptioncontroller = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();
  TextEditingController numbercontroller = TextEditingController();
  TextEditingController experienceController = TextEditingController();

  String serviceid = "";
  final _formKey = GlobalKey<FormState>();
  String selectedKey = "";
  String selectedOption = "";
  File? _image;
  final _picker = ImagePicker();
  List imageList = [];
  String getImage = "";
  List<File> _assetImgList = <File>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dataGet();
    Helper.checkInternet(getservices());
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
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        centerTitle: true,
        elevation: 0,
        title: widget.whichscreen == "Add Service"
            ? Text(TextScreen.add_service,
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ))
            : Text("Edit Service",
                style: GoogleFonts.lato(
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
          serviceListApiModel == null
              ? Container()
              : Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 10),
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Add Service",
                                style: GoogleFonts.lato(
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
                                padding: EdgeInsets.symmetric(
                                    horizontal: 22, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Color(0xffEAEDF2),
                                  border: Border.all(
                                      color: AppColors.addpropertyfillclr,
                                      width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child:
                                    // DropdownButtonHideUnderline(
                                    //   child: DropdownButton(
                                    //       hint: Padding(
                                    //         padding:  EdgeInsets.only(left: 5),
                                    //         child: Text("Choose Service",
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
                                    //           serviceid=value.toString();
                                    //           print("serviceid============>${serviceid.toString()}");
                                    //           print("selectedOption============>${selectedOption.toString()}");
                                    //
                                    //         });
                                    //
                                    //       },
                                    //        ),
                                    // ),
                                    DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    hint: Padding(
                                      padding: EdgeInsets.only(left: 5),
                                      child: Text("Choose Service",
                                          style: GoogleFonts.lato(
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
                                )),
                            SizedBox(
                              height: 12,
                            ),
                            Text(TextScreen.description,
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                      color: AppColors.textcolor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                )),
                            SizedBox(
                              height: 5,
                            ),
                            TextFormField(
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(250),
                              ],
                              controller: descriptioncontroller,
                              maxLines: 2,
                              //obscureText: true,
                              decoration: InputDecoration(
                                // fillColor: AppColors.addpropertyfillclr,
                                fillColor: Color(0xffEAEDF2),
                                filled: true,
                                hintText: "Description",
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 22, vertical: 18),
                                hintStyle: GoogleFonts.lato(
                                    color: AppColors.txtgreyclr, fontSize: 15),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: AppColors.addpropertyfillclr),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: AppColors.addpropertyfillclr),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: AppColors.addpropertyfillclr),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                      width: 1,
                                    )),
                                errorBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                        width: 1,
                                        color: AppColors.addpropertyfillclr)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                        width: 1,
                                        color: AppColors.addpropertyfillclr)),
                                // border: OutlineInputBorder(
                                //     borderRadius: BorderRadius.circular(20),
                                //     borderSide: new BorderSide(color: Color(0xffBFBFBF))
                                // )
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter your password";
                                } else if (value.length < 8) {
                                  ToastMessage.msg(
                                      "password must be of 8 digit");
                                }
                              },
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Text(TextScreen.phone,
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                      color: AppColors.textcolor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                )),
                            SizedBox(
                              height: 5,
                            ),
                            TextFormField(
                                controller: numbercontroller,
                                //obscureText: true,
                                enabled: true,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(11)
                                ],
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
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 22, vertical: 18),
                                  hintStyle: GoogleFonts.lato(
                                      color: AppColors.txtgreyclr,
                                      fontSize: 15),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                        width: 1,
                                        color: AppColors.addpropertyfillclr),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                        width: 1,
                                        color: AppColors.addpropertyfillclr),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                        width: 1,
                                        color: AppColors.addpropertyfillclr),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                        width: 1,
                                      )),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                          width: 1,
                                          color: AppColors.addpropertyfillclr)),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                          width: 1,
                                          color: AppColors.addpropertyfillclr)),

                                  // border: OutlineInputBorder(
                                  //     borderRadius: BorderRadius.circular(20),
                                  //     borderSide: new BorderSide(color: Color(0xffBFBFBF))
                                  // )
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return ("Please enter your number");
                                  } else if (value.length != 10) {
                                    return ("Number must be equal to ten digits");
                                  }
                                }),
                            SizedBox(
                              height: 12,
                            ),
                            Text(TextScreen.address,
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                      color: AppColors.textcolor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                )),
                            SizedBox(
                              height: 5,
                            ),
                            TextFormField(
                              controller: addresscontroller,
                              //obscureText: true,
                              decoration: InputDecoration(
                                // fillColor: AppColors.addpropertyfillclr,
                                fillColor: Color(0xffEAEDF2),
                                filled: true,
                                hintText: "Address",
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 22, vertical: 18),
                                hintStyle: GoogleFonts.lato(
                                    color: AppColors.txtgreyclr, fontSize: 15),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: AppColors.addpropertyfillclr),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: AppColors.addpropertyfillclr),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: AppColors.addpropertyfillclr),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                      width: 1,
                                    )),
                                errorBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                        width: 1,
                                        color: AppColors.addpropertyfillclr)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                        width: 1,
                                        color: AppColors.addpropertyfillclr)),
                                // border: OutlineInputBorder(
                                //     borderRadius: BorderRadius.circular(20),
                                //     borderSide: new BorderSide(color: Color(0xffBFBFBF))
                                // )
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter your address";
                                } else if (value.length < 8) {
                                  ToastMessage.msg(
                                      "password must be of 8 digit");
                                }
                              },
                            ),

                            SizedBox(
                              height: 12,
                            ),
                            Text("Years of Experience",
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                      color: AppColors.textcolor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                )),
                            SizedBox(
                              height: 5,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              controller: experienceController,
                              //obscureText: true,
                              decoration: InputDecoration(
                                // fillColor: AppColors.addpropertyfillclr,
                                fillColor: Color(0xffEAEDF2),
                                filled: true,
                                hintText: "Experience",
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 22, vertical: 18),
                                hintStyle: GoogleFonts.lato(
                                    color: AppColors.txtgreyclr, fontSize: 15),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: AppColors.addpropertyfillclr),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: AppColors.addpropertyfillclr),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: AppColors.addpropertyfillclr),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                      width: 1,
                                    )),
                                errorBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                        width: 1,
                                        color: AppColors.addpropertyfillclr)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                        width: 1,
                                        color: AppColors.addpropertyfillclr)),
                                // border: OutlineInputBorder(
                                //     borderRadius: BorderRadius.circular(20),
                                //     borderSide: new BorderSide(color: Color(0xffBFBFBF))
                                // )
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter your address";
                                } else if (value.length < 8) {
                                  ToastMessage.msg(
                                      "password must be of 8 digit");
                                }
                              },
                            ),

                            // images  addd

                            // Row(
                            //   // mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     InkWell(
                            //       onTap: (){
                            //         _showPicker(context);
                            //       },
                            //       child: Container(
                            //         height: MediaQuery.of(context).size.height*0.15,
                            //         width: MediaQuery.of(context).size.width/3,
                            //         padding: EdgeInsets.symmetric(horizontal: 22, vertical: 18),
                            //         decoration: BoxDecoration(
                            //           // color: AppColors.primaryColor,
                            //           border: Border.all(color: AppColors.addpropertyfillclr, width: 1),
                            //           borderRadius: BorderRadius.circular(10),
                            //         ),
                            //         child:  Center(
                            //             child: Icon(Icons.add,size: 50,color: AppColors.primaryColor,)
                            //         ),
                            //       ),
                            //     ),
                            //     SizedBox(
                            //       width: 12,
                            //     ),
                            //     Text("Add Images of \nyour previous work",
                            //         style: GoogleFonts.lato(
                            //           textStyle: TextStyle(
                            //               color: Color(0xffB2B2B2),
                            //               fontSize: 14,fontWeight: FontWeight.w300
                            //           ),
                            //         )),
                            //
                            //   ],
                            // ),
                            SizedBox(
                              height: 12,
                            ),
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
                                        width:
                                            MediaQuery.of(context).size.width,
                                        margin: EdgeInsets.only(top: 10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                            // Container(
                            //   height: MediaQuery.of(context).size.height*0.18,
                            //   width: MediaQuery.of(context).size.width,
                            //   decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(10),
                            //     color: Colors.transparent,
                            //   ),
                            //   child: ClipRRect(
                            //   borderRadius: BorderRadius.circular(10),
                            //   child:
                            //   Image.asset(
                            //     // _image==null?Images.room_img:
                            //     //   imageList[].toString(),
                            //     Images.room_img,
                            //     fit: BoxFit.fill,)),
                            // ),
                            SizedBox(
                              height: 12,
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Center(
                              child: MaterialButton(
                                onPressed: () {
                                  // Get.to(OtpScreen());
                                  // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Setting3()));
                                  // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ServicesTabbar()));
                                  if (widget.service_name == "") {
                                    Helper.checkInternet(addService());
                                  } else {
                                    Helper.checkInternet(editServiceApi());
                                  }
                                },
                                color: AppColors.ButtonColor,
                                textColor: Colors.black,
                                minWidth: 320,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 15),
                                child: Text(
                                  'Submit',
                                  style: GoogleFonts.lato(
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .displayLarge,
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
                ),
          Positioned(child: Helper.getProgressBar(context, _isVisible))
        ],
      ),
    );
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
      Helper.checkInternet(addServiceImagesApi(image.path));
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
      Helper.checkInternet(addServiceImagesApi(image.path));
    });

    // Helper.checkInternet(uploadImage(_image!.path));
  }

  setProgress(bool show) {
    if (mounted)
      setState(() {
        _isVisible = show;
      });
  }

  Future<void> getservices() async {
    print("<=============getservices api=============>");

    setProgress(true);

    final prefs = await SharedPreferences.getInstance();
    var user_id = await prefs.getString('user_id');
    try {
      var res =
          await http.get(Uri.parse(Api.getServiceList + "?user_id=${user_id}"));
      // var res = await http.post(Uri.parse(Api.getMyServiceList), );
      print("Response ============>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);

          ServiceListApiModel model =
              ServiceListApiModel.fromJson(jsonResponse);

          if (model.status == "true") {
            restaurent.addAll(model.serviceList!);

            _restaurent.clear();
            for (int i = 0; i < restaurent.length; i++) {
              _restaurent.add(restaurent[i].services.toString());
              newMapOfMonths[restaurent[i].services] = restaurent[i].serviceId;
              print(newMapOfMonths);
            }
            setState(() {
              serviceListApiModel = model;
              selectedOption =
                  serviceListApiModel!.serviceList![0].serviceId.toString();
              selectedKey =
                  serviceListApiModel!.serviceList![0].services.toString();
              // if(widget.service_name ==""){
              //   selectedOption=serviceListApiModel!.serviceList![0].serviceId.toString();
              //
              //   selectedKey=serviceListApiModel!.serviceList![0].services.toString();
              // }else{
              //   // selectedOption = widget.service_id.toString();
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
            serviceListApiModel = null;
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

  Future<void> addService() async {
    print("<=============addServiceApi =============>");
    setProgress(true);
    final prefs = await SharedPreferences.getInstance();
    var user_id = await prefs.getString('user_id');

    Map data = {
      'user_id': user_id.toString(),
      'service_id': selectedOption,
      'service': selectedKey.toString(),
      'description': descriptioncontroller.text.toString(),
      'number': numbercontroller.text.toString(),
      'amount': "500",
      'address': addresscontroller.text.toString(),
      'yearsOfExperience': experienceController.text.toString(),
      'image': imageList.toString()
    };

    print("Request =============>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Api.addService), body: data);
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
          _hasData = false;
          print("false ============>");
          ToastMessage.msg(StaticMessages.API_ERROR);
          print('exception ==> ' + e.toString());
        }
      } else {
        print("status code ==> " + res.statusCode.toString());
        ToastMessage.msg(StaticMessages.API_ERROR);
      }
    } catch (e) {
      _hasData = false;
      ToastMessage.msg(StaticMessages.API_ERROR);
      print('Exception ======> ' + e.toString());
    }
    setProgress(false);
  }

  Future<void> addServiceImagesApi(filename) async {
    print("<==============uploadImagesApi===============>");

    final prefs = await SharedPreferences.getInstance();
    var user_id = await prefs.getString('user_id');
    setProgress(true);

    var request =
        http.MultipartRequest('POST', Uri.parse(Api.addServiceImages));

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

          AddServiceImagesModel model =
              AddServiceImagesModel.fromJson(jsonResponse);

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

  Future<void> editServiceApi() async {
    print("<=============editServiceApi =============>");
    setProgress(true);
    final prefs = await SharedPreferences.getInstance();
    var user_id = await prefs.getString('user_id');

    Map data = {
      'user_id': user_id.toString(),
      'id': widget.serviceCategory.toString(),
      'service_id': selectedOption,
      'service': selectedKey.toString(),
      'description': descriptioncontroller.text.toString(),
      'number': numbercontroller.text.toString(),
      'amount': "500",
      'address': addresscontroller.text.toString(),
      'yearsOfExperience': experienceController.text.toString(),
      'image': imageList.toString()
    };

    print("Request =============>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Api.editService), body: data);
      print("Response ============>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          EditServiceModel model = EditServiceModel.fromJson(jsonResponse);

          if (model.status == "true") {
            print("Model status true");

            setProgress(false);

            setState(() {
              _editServiceModel = model;
            });
            // Helper.moveToScreenwithRoutClear(context, ServicesTabbar());
            Helper.moveToScreenwithPushreplaceemt(context, ServicesTabbar());
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
          _hasData = false;
          print("false ============>");
          ToastMessage.msg(StaticMessages.API_ERROR);
          print('exception ==> ' + e.toString());
        }
      } else {
        print("status code ==> " + res.statusCode.toString());
        ToastMessage.msg(StaticMessages.API_ERROR);
      }
    } catch (e) {
      _hasData = false;
      ToastMessage.msg(StaticMessages.API_ERROR);
      print('Exception ======> ' + e.toString());
    }
    setProgress(false);
  }

  void dataGet() {
    print("=============dataGet===============");

    setState(() {
      descriptioncontroller.text = widget.service_des.toString();
      experienceController.text = widget.experience.toString();
      numbercontroller.text = widget.number.toString();
      addresscontroller.text = widget.address.toString();
      selectedOption = widget.service_id.toString();
      selectedKey = widget.service_name.toString();
      getImage = widget.serviceImage.toString();

      print("selectedOption====${selectedOption.toString()}");
      print("selectedKey====${selectedKey.toString()}");
      print("number===========${widget.number}");
    });
  }
}
