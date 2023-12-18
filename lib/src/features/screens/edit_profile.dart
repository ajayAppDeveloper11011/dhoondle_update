import 'dart:convert';
import 'dart:io';

// import 'package:aheadly_owner/Reg/login.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../api_model/edit_profile_model.dart';
import '../../api_model/profile_model_api.dart';
import '../../constants/Api.dart';
import '../../constants/colors.dart';
import '../../constants/helper.dart';
import '../../constants/images.dart';
import '../../constants/text.dart';
import 'bottomNavigation.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

String dropdownvalue2 = 'Select Services';

var items2 = [
  'Select Services',
  'Service1',
  'Service2',
  'Service3',
  'Service4',
  'Service5',
];

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  EditProfileModel? profileModel;
  File? _image;
  String imagesource = "";
  final _picker = ImagePicker();
  ProfileApiModel? _getprofileApi;
  bool _hasData = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Helper.checkInternet(profileapi());
    // getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          toolbarHeight: 80,
          leading: InkWell(
            onTap: () {
              // Helper.popScreen(context);

              Get.toNamed('/bottom');
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
          title: Text(TextScreen.Home,
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
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
            _getprofileApi == null
                ? Container(
                    height: MediaQuery.of(context).size.height,
                    child: Center(child: Text("No property found")),
                  )
                :
            Container(
                    // color: Colors.black,
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Stack(
                              children: [
                                Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black54, width: 2),
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.transparent,
                                  ),
                                  child: _image == null
                                      ? ClipOval(
                                          child: CachedNetworkImage(
                                            imageUrl:'assets/images/img1.png',
                                            // _getprofileApi!.data.image
                                            //     .toString(),
                                            fit: BoxFit.fill,
                                            width: 100,
                                            height: 100,
                                            placeholder: (context, url) =>
                                                LinearProgressIndicator(
                                              color:
                                                  Colors.white.withOpacity(0.2),
                                              backgroundColor:
                                                  Colors.white.withOpacity(.5),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    ClipOval(
                                              child: Container(
                                                width: 100,
                                                height: 100,
                                                // padding: EdgeInsets.symmetric(vertical: 25.0),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(20),
                                                  ),
                                                  // color:Color(0xFFD9D9D9)
                                                ),
                                                child: Center(
                                                  child: Icon(
                                                    Icons.person,
                                                    size: 40,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : ClipOval(
                                          child: Image.file(_image!,
                                              height: 120,
                                              width: 120,
                                              fit: BoxFit.fill),
                                        ),
                                ),
                                Positioned(
                                  left: 70,
                                  top: 70,
                                  child: InkWell(
                                    onTap: () {
                                      _showPicker(context);
                                    },
                                    child: Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white),
                                        child: Icon(
                                          Icons.camera_alt,
                                        )),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            child: Form(
                              key: _formKey,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(0.0),
                                      child: TextFormField(
                                        controller: fullNameController,
                                        textInputAction: TextInputAction.next,
                                        //obscureText: true,
                                        decoration: InputDecoration(
                                          fillColor: AppColors.FillColor,
                                          filled: true,
                                          hintText: "Name",
                                          hintStyle: GoogleFonts.lato(
                                              color: AppColors.HintTextColor),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15)),
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: Color(0xffBFBFBF)),
                                          ),
                                          disabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15)),
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: Color(0xffBFBFBF)),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15)),
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: Color(0xffBFBFBF)),
                                          ),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15)),
                                              borderSide: BorderSide(
                                                width: 1,
                                              )),
                                          errorBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15)),
                                              borderSide: BorderSide(
                                                  width: 1,
                                                  color: Color(0xffBFBFBF))),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(15)),
                                                  borderSide:
                                                      BorderSide(
                                                          width: 1,
                                                          color: Color(
                                                              0xffBFBFBF))),
                                          // border: OutlineInputBorder(
                                          //     borderRadius: BorderRadius.circular(20),
                                          //     borderSide: new BorderSide(color: Color(0xffBFBFBF))
                                          // )
                                        ),

                                        validator: (name) {
                                          if (name!.isEmpty) {
                                            return "Enter name";
                                            // ToastMessage.msg("Please enter phone number");
                                          }
                                          // else if (name.length !> 2) {
                                          //   return "Enter valid name";
                                          //   // ToastMessage.msg("Mobile Number must be of 10 digit");
                                          // }
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(0.0),
                                      child: TextFormField(
                                        textInputAction: TextInputAction.next,
                                        controller: addressController,
                                        //obscureText: true,
                                        decoration: InputDecoration(
                                          fillColor: AppColors.FillColor,
                                          filled: true,
                                          hintText: "Address",
                                          hintStyle: GoogleFonts.lato(
                                              color: AppColors.HintTextColor),

                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15)),
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: Color(0xffBFBFBF)),
                                          ),
                                          disabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15)),
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: Color(0xffBFBFBF)),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15)),
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: Color(0xffBFBFBF)),
                                          ),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15)),
                                              borderSide: BorderSide(
                                                width: 1,
                                              )),
                                          errorBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15)),
                                              borderSide: BorderSide(
                                                  width: 1,
                                                  color: Color(0xffBFBFBF))),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(15)),
                                                  borderSide:
                                                      BorderSide(
                                                          width: 1,
                                                          color: Color(
                                                              0xffBFBFBF))),
                                          // border: OutlineInputBorder(
                                          //     borderRadius: BorderRadius.circular(20),
                                          //     borderSide: new BorderSide(color: Color(0xffBFBFBF))
                                          // )
                                        ),

                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Please enter your address";
                                          }
                                          // else if(value.length < 8){
                                          //   return "Enter valid address";
                                          // }
                                        },

                                        // validator: (address){
                                        //   if (address!.isEmpty) {
                                        //     return "Enter address";
                                        //     // ToastMessage.msg("Please enter phone number");
                                        //   }
                                        //   else if (address.length !> 2) {
                                        //     return "Enter valid address";
                                        //     // ToastMessage.msg("Mobile Number must be of 10 digit");
                                        //   }
                                        // },
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(0.0),
                                      child: TextFormField(
                                        controller: emailController,
                                        textInputAction: TextInputAction.next,
                                        //obscureText: true,
                                        decoration: InputDecoration(
                                          fillColor: AppColors.FillColor,
                                          filled: true,
                                          hintText: "Email",
                                          hintStyle: GoogleFonts.lato(
                                              color: AppColors.HintTextColor),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15)),
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: Color(0xffBFBFBF)),
                                          ),
                                          disabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15)),
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: Color(0xffBFBFBF)),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15)),
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: Color(0xffBFBFBF)),
                                          ),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15)),
                                              borderSide: BorderSide(
                                                width: 1,
                                              )),
                                          errorBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15)),
                                              borderSide: BorderSide(
                                                  width: 1,
                                                  color: Color(0xffBFBFBF))),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(15)),
                                                  borderSide:
                                                      BorderSide(
                                                          width: 1,
                                                          color: Color(
                                                              0xffBFBFBF))),
                                          // border: OutlineInputBorder(
                                          //     borderRadius: BorderRadius.circular(20),
                                          //     borderSide: new BorderSide(color: Color(0xffBFBFBF))
                                          // )
                                        ),

                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return null; // Return null if the field is empty (optional)
                                          } else if (EmailValidator.validate(
                                              value.trim())) {
                                            return null; // Return null if the email is valid
                                          } else {
                                            return "Invalid email address"; // Return an error message for invalid email
                                          }
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(0.0),
                                      child: TextFormField(
                                          controller: mobileController,
                                          enabled: false,
                                          textInputAction: TextInputAction.done,
                                          keyboardType: TextInputType.phone,
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(
                                                10),
                                          ],
                                          //obscureText: true,
                                          decoration: InputDecoration(
                                            fillColor: AppColors.FillColor,
                                            filled: true,
                                            hintText: "Mobile",
                                            hintStyle: GoogleFonts.lato(
                                                color: AppColors.HintTextColor),

                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15)),
                                              borderSide: BorderSide(
                                                  width: 1,
                                                  color: Color(0xffBFBFBF)),
                                            ),
                                            disabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15)),
                                              borderSide: BorderSide(
                                                  width: 1,
                                                  color: Color(0xffBFBFBF)),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15)),
                                              borderSide: BorderSide(
                                                  width: 1,
                                                  color: Color(0xffBFBFBF)),
                                            ),
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15)),
                                                borderSide: BorderSide(
                                                  width: 1,
                                                )),
                                            errorBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15)),
                                                borderSide: BorderSide(
                                                    width: 1,
                                                    color: Color(0xffBFBFBF))),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(Radius
                                                            .circular(15)),
                                                    borderSide: BorderSide(
                                                        width: 1,
                                                        color:
                                                            Color(0xffBFBFBF))),
                                            // border: OutlineInputBorder(
                                            //     borderRadius: BorderRadius.circular(20),
                                            //     borderSide: new BorderSide(color: Color(0xffBFBFBF))
                                            // )
                                          ),
                                          // onChanged: (value) {
                                          //
                                          //   signUpController.validatePhoneNumber(value);
                                          // },
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return ("Please enter your number");
                                            } else if (value.length != 10) {
                                              return ("Number must be equal to ten digits");
                                            }
                                          }),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.05,
                                    ),
                                    Center(
                                      child: MaterialButton(
                                        color: AppColors.primaryColor,
                                        minWidth: 340,
                                        height: 50,
                                        textColor: Colors.white,
                                        child: Text(
                                          "Save",
                                          style: (GoogleFonts.lato(
                                            textStyle: TextStyle(
                                                fontSize: 22,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600),
                                          )),
                                        ),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        onPressed: () {
                                          // if (_formkey.currentState!.validate()) {
                                          //   _formkey.currentState!.save();
                                          _buttonSubmit();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    )),
            Positioned(
              child: Align(
                alignment: Alignment.center,
                child: HelperClass.getProgressBar(context, _isVisible),
              ),
            )
          ],
        ));
  }

  _imgFromCamera() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );
    if (image != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
        compressQuality: 100,
        maxHeight: 1000,
        maxWidth: 1000,
        compressFormat: ImageCompressFormat.jpg,
      );

      setState(() {
        _image = File(croppedFile!.path);
        String path = _image.toString();
        print("path" + _image!.path);
      });
    }
    // setState(() {
    //   _image = File(image!.path);
    // });
  }

  _imgFromGallery() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    // _image=_cropImage(image);
    // setState(() {
    //   _image = File(image!.path);
    //   String path = _image.toString();
    //   print("path" + _image!.path);
    // });

    if (image != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
        compressQuality: 100,
        maxHeight: 1000,
        maxWidth: 1000,
        compressFormat: ImageCompressFormat.jpg,
      );

      setState(() {
        _image = File(croppedFile!.path);
        String path = _image.toString();
        print("path" + _image!.path);
      });
    }

    // Helper.checkInternet(uploadImage(_image!.path));
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

  _buttonSubmit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (_image == null) {
        print("Api called without Image");
        Helper.checkInternet(apieditProfileWithoutImage());
      } else {
        print("Api called with Image");
        Helper.checkInternet(apieditProfileWithImage(_image!.path));
      }
      //  print("==========>>>>>>>>>>>>Image PAth" + _image!.path);
      // Helper.checkInternet(apieditProfileWithoutImage());
    }
  }

  bool _isVisible = false;

  setProgress(bool show) {
    if (mounted)
      setState(() {
        _isVisible = show;
      });
  }

  Future<void> profileapi() async {
    print("<=============profileapi =============>");

    final prefs = await SharedPreferences.getInstance();
    var user_id = await prefs.getString('user_id');

    setProgress(true);

    try {
      var res = await http.get(
        Uri.parse(Api.getprofile + "?user_id=${user_id}"),
      );
      print("Response ============>" + res.body);

      if (res.statusCode == 200) {
        print("urvashi ============>");
        try {
          final jsonResponse = jsonDecode(res.body);
          ProfileApiModel model = ProfileApiModel.fromJson(jsonResponse);

          if (model.status == "true") {
            print("Model status true");

            setProgress(false);

            setState(() {
              _getprofileApi = model;
              fullNameController.text = _getprofileApi!.data.name.toString();
              addressController.text = _getprofileApi!.data.address.toString();
              emailController.text = _getprofileApi!.data.email.toString();
              mobileController.text = _getprofileApi!.data.mobile.toString();
            });
            SharedPreferences preferences = await SharedPreferences.getInstance();
            preferences.setString('user_name', fullNameController.text);
            preferences.setString('user_mobile', mobileController.text);
            preferences.setString('user_email', emailController.text);
            preferences.setString('user_address', addressController.text);
            // ToastMessage.msg(model.message.toString());
          } else {
            setState(() {
              _hasData = false;
            });
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

  Future<void> apieditProfileWithoutImage() async {
    print("<============= editOwnerProfile Api =============>");
    setProgress(true);

    final prefs = await SharedPreferences.getInstance();
    var user_id = await prefs.getString('user_id');

    print("===============${user_id}============");
    // String shopid = session.get(SessionHelper.SHOP_ID) ?? "0";

    Map data = {
      'user_id': user_id,
      'name': fullNameController.text.toString(),
      'address': addressController.text.toString(),
      'email': emailController.text.toString(),
    };

    print("Request =============>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Api.editProfile), body: data);

      print("Response ============>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          EditProfileModel model = EditProfileModel.fromJson(jsonResponse);

          setState(() {
            profileModel = model;
          });

          if (model.status == "true") {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString(
                'user_id', profileModel!.data!.userId.toString());
            await prefs.setString('name', profileModel!.data!.name.toString());
            await prefs.setString(
                'address', profileModel!.data!.address.toString());
            await prefs.setString(
                'mobile', profileModel!.data!.mobile.toString());
            await prefs.setString(
                'email', profileModel!.data!.email.toString());

            // print(model.data!.username.toString());
            // sessionHelper.put(SessionHelper.PERCENTAGE,model.data!.cancellation.toString());
            // Helper.moveToScreenwithPush(context, Shopdetails());

            setProgress(false);
            ToastMessage.msg(model.message.toString());
            Helper.moveToScreenwithPushreplaceemt(context, BottomNaigation());
            // Helper.moveToScreenwithPushreplaceemt(context, BottomNavBar());
          } else {
            setProgress(false);
            ToastMessage.msg(model.message.toString());
          }
        } catch (e) {
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

  Future<void> apieditProfileWithImage(filename) async {
    final prefs = await SharedPreferences.getInstance();
    var user_id = await prefs.getString('user_id');
    // String shopid = session.get(SessionHelper.SHOP_ID) ?? "0";

    setProgress(true);
    var request = http.MultipartRequest('POST', Uri.parse(Api.editProfile));

    request.fields['name'] = fullNameController.text;
    request.fields['user_id'] = user_id!;
    request.fields['email'] = emailController.text;
    request.fields['phone'] = mobileController.text;
    request.fields['address'] = addressController.text;

    request.files.add(await http.MultipartFile.fromPath('image', filename));

    print(request.fields);
    print(request.files);

    var res = await request.send();
    if (res.statusCode == 200) {
      setProgress(false);
      try {
        res.stream.transform(utf8.decoder).listen((value) async {
          final jsonResponse = jsonDecode(value);
          EditProfileModel model = EditProfileModel.fromJson(jsonResponse);
          if (model.status == "true") {
            setState(() {
              profileModel = model;
              print(
                  "imagesource--------------${profileModel!.data!.image.toString()}");
            });
            ToastMessage.msg("Image uploaded successfully");

            final prefs = await SharedPreferences.getInstance();
            await prefs.setString(
                'user_id', profileModel!.data!.userId.toString());
            await prefs.setString('name', profileModel!.data!.name.toString());
            await prefs.setString(
                'address', profileModel!.data!.address.toString());
            await prefs.setString(
                'mobile', profileModel!.data!.mobile.toString());
            await prefs.setString(
                'email', profileModel!.data!.email.toString());

            ToastMessage.msg(profileModel!.message.toString());
            Helper.moveToScreenwithPushreplaceemt(context, BottomNaigation());
          } else {
            ToastMessage.msg(profileModel!.message.toString());
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
