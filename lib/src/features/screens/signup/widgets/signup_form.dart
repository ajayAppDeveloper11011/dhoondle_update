import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/helper.dart';
import '../../../../webview.dart';
import '../../../controllers/signup_controller.dart';
import '../../../controllers/splash_controller.dart';

class SignupForm extends StatelessWidget {
   SignupForm({
    Key? key,
    required GlobalKey<FormState> formKey,
  }) : _formKey = formKey, super(key: key);

  final GlobalKey<FormState> _formKey;
  final signUpController=Get.put(SignUpController());
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: TextFormField(
              controller: signUpController.nameController.value,
              textInputAction: TextInputAction.next,
              //obscureText: true,
              decoration: InputDecoration(
                fillColor: AppColors.FillColor,
                filled: true,
                hintText: "Name",
                hintStyle: GoogleFonts.roboto(color: AppColors.HintTextColor),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  borderSide:
                  BorderSide(width: 1, color: Color(0xffBFBFBF)),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  borderSide:
                  BorderSide(width: 1, color: Color(0xffBFBFBF)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  borderSide:
                  BorderSide(width: 1, color: Color(0xffBFBFBF)),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    borderSide: BorderSide(
                      width: 1,
                    )),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    borderSide:
                    BorderSide(width: 1, color: Color(0xffBFBFBF))),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    borderSide:
                    BorderSide(width: 1, color: Color(0xffBFBFBF))),
                // border: OutlineInputBorder(
                //     borderRadius: BorderRadius.circular(20),
                //     borderSide: new BorderSide(color: Color(0xffBFBFBF))
                // )

              ),
              onChanged: (value) {

                signUpController.validatename(value);
              },
              // validator: (name){
              //   if (name!.isEmpty) {
              //     return "Enter name";
              //     // ToastMessage.msg("Please enter phone number");
              //   }
              //   else if (name.length !> 2) {
              //     return "Enter valid name";
              //     // ToastMessage.msg("Mobile Number must be of 10 digit");
              //   }
              // },
            ),
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: TextFormField(
              textInputAction: TextInputAction.next,
               controller: signUpController.addressController.value,
              //obscureText: true,
              decoration: InputDecoration(
                fillColor: AppColors.FillColor,
                filled: true,
                hintText: "Address",
                hintStyle:
                GoogleFonts.roboto(color: AppColors.HintTextColor),

                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  borderSide:
                  BorderSide(width: 1, color: Color(0xffBFBFBF)),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  borderSide:
                  BorderSide(width: 1, color: Color(0xffBFBFBF)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  borderSide:
                  BorderSide(width: 1, color: Color(0xffBFBFBF)),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    borderSide: BorderSide(
                      width: 1,
                    )),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    borderSide:
                    BorderSide(width: 1, color: Color(0xffBFBFBF))),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    borderSide:
                    BorderSide(width: 1, color: Color(0xffBFBFBF))),
                // border: OutlineInputBorder(
                //     borderRadius: BorderRadius.circular(20),
                //     borderSide: new BorderSide(color: Color(0xffBFBFBF))
                // )
              ),

              // onChanged: (value) {
              //
              //   signUpController.validateaddress(value);
              // },
              validator: (value){
                if(value!.isEmpty){ return "Please enter your address";
                }
                else if(value.length < 8){
                  ToastMessage.msg("address must be of 8 digit");
                }
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
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: TextFormField(
               controller: signUpController.emailController.value,
              textInputAction: TextInputAction.next,
              //obscureText: true,
              decoration: InputDecoration(
                fillColor: AppColors.FillColor,
                filled: true,
                hintText: "Email (Optional)",
                hintStyle:
                GoogleFonts.roboto(color: AppColors.HintTextColor),

                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  borderSide:
                  BorderSide(width: 1, color: Color(0xffBFBFBF)),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  borderSide:
                  BorderSide(width: 1, color: Color(0xffBFBFBF)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  borderSide:
                  BorderSide(width: 1, color: Color(0xffBFBFBF)),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    borderSide: BorderSide(
                      width: 1,
                    )),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    borderSide:
                    BorderSide(width: 1, color: Color(0xffBFBFBF))),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    borderSide:
                    BorderSide(width: 1, color: Color(0xffBFBFBF))),
                // border: OutlineInputBorder(
                //     borderRadius: BorderRadius.circular(20),
                //     borderSide: new BorderSide(color: Color(0xffBFBFBF))
                // )
              ),
              validator: (value){
                if(value!.isEmpty){ return "Please enter email";
                }else if(EmailValidator.validate(value.trim())){
                  return null;
                }else{
                  return"Invalid email address";
                }
              },
            ),
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: TextFormField(
               controller: signUpController.mobileController.value,
              textInputAction: TextInputAction.done,
              //obscureText: true,
              decoration: InputDecoration(
                fillColor: AppColors.FillColor,
                filled: true,
                hintText: "Mobile",
                hintStyle:
                GoogleFonts.roboto(color: AppColors.HintTextColor),

                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  borderSide:
                  BorderSide(width: 1, color: Color(0xffBFBFBF)),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  borderSide:
                  BorderSide(width: 1, color: Color(0xffBFBFBF)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  borderSide:
                  BorderSide(width: 1, color: Color(0xffBFBFBF)),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    borderSide: BorderSide(
                      width: 1,
                    )),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    borderSide:
                    BorderSide(width: 1, color: Color(0xffBFBFBF))),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    borderSide:
                    BorderSide(width: 1, color: Color(0xffBFBFBF))),
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
                  }
                  else if (value.length != 10) {
                    return ("Number must be equal to ten digits");
                  }
                }

            ),
          ),
          SizedBox(height: 30,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("By continuing, you agree to the",
                  style: GoogleFonts.roboto(
                      fontSize: 16,
                      color: AppColors.HintTextColor,
                      fontWeight: FontWeight.w400)),
              SizedBox(
                width: 8,
              ),
              InkWell(
                onTap: () => {
                  HelperClass.moveToScreenwithPush(context, Terms())
                },
                child: Text("Privacy Policy",
                    style: GoogleFonts.roboto(
                        fontSize: 16,
                        color: AppColors.RedTextColor,
                        fontWeight: FontWeight.w500)),
              ),
            ],
          ),
          SizedBox(height: 50),
          MaterialButton(
              onPressed: (){
                // if (_formKey.currentState!.validate())
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                signUpController.signUp();
              }

                // print(signUpController.nameController.value.text.toString());
                // Get.toNamed('/otp');
                // Get.to(LogInScreen());
              },
              color:  Color(0xffD70404),textColor: Colors.black,
              minWidth: 320,shape:RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)),
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
              child:
              Text("Sign up", style: GoogleFonts.roboto(
                textStyle: Theme.of(context).textTheme.displayLarge,
                fontSize: 20,
                color: AppColors.ButtonTextColor,
                fontWeight: FontWeight.bold,
              ),)

          ),
          SizedBox(height: 100,),
          Center(
            child:Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account?",
                    style: GoogleFonts.roboto(
                        fontSize: 16,
                        color: AppColors.HintTextColor,
                        fontWeight: FontWeight.w400)),
                SizedBox(
                  width: 8,
                ),
                InkWell(
                  onTap: () => {

                     Get.toNamed('/login')
                  },
                  child: Text("Log In",
                      style: GoogleFonts.roboto(
                          fontSize: 16,
                          color: AppColors.RedTextColor,
                          fontWeight: FontWeight.w500)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}