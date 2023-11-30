//
//
// import 'package:flutter/material.dart';
// import 'package:flutter_switch/flutter_switch.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:hwdriver/other/view_acitivity_schedule.dart';
// import 'package:toggle_switch/toggle_switch.dart';
//
// import '../Screens/Tasks/tasks_drawer_tabbar.dart';
// import '../Screens/pricing_pages/pricing_screen.dart';
// import '../Screens/profile/profile_account_screen.dart';
// import '../Screens/promotions/view_coupons.dart';
// import '../Screens/support_chat/support_chat_screen.dart';
// import '../helper/constant.dart';
// import '../helper/image.dart';
//
// class DrawerClass extends StatefulWidget {
//   const DrawerClass({Key? key}) : super(key: key);
//
//   @override
//   State<DrawerClass> createState() => _DrawerClassState();
// }
//
// class _DrawerClassState extends State<DrawerClass> {
//   String _isselect="";
//   bool isSwitchOn = false;
//   @override
//   Widget build(BuildContext context) {
//     return  Drawer(
//       child: Container(
//           padding: EdgeInsets.only(top: 25, left: 10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(left: 20, top: 25),
//                     child: GestureDetector(
//                       onTap: () {
//                         Navigator.pop(context);
//                       },
//                       child: Image.asset(
//                         "assets/icons/cancel.png",
//                         height: 15,
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SizedBox(
//                     height: 15,
//                   ),
//                   InkWell(
//                     onTap: () {
//                       Helper.moveToScreenwithPush(context, ViewActivity());
//                     },
//                     child: Image.asset(
//                      ProjectImage.driverlogo,
//                       height: 90,
//                       width: 90,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 40,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         "Available",
//                         style: GoogleFonts.quicksand(
//                             textStyle: TextStyle(
//                                 fontSize: 19, fontWeight: FontWeight.bold)),
//                       ),
//                       SizedBox(
//                         width: 15,
//                       ),
//
//
//                       Container(
//                         width: 80,
//                         height: 30,
//                         child: FlutterSwitch(
//                           activeTextColor: Colors.white,
//                           activeColor: AppColor.primaryColor,
//                           showOnOff: true,
//                           activeText: "ON",
//                           inactiveText: "OFF",
//                           // activeToggleColor:AppColor.primaryColor ,
//                           value: isSwitchOn,
//                           onToggle: (value) {
//                             setState(() {
//                               isSwitchOn = value;
//                             });
//                           },
//                         ),
//                       ),
//                       //switch button here------
//                     ],
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20),
//                     child: Column(
//                       children: [
//                         SizedBox(
//                           height: 15,
//                         ),
//                         Container(
//                           height: 60,
//                           width: MediaQuery.of(context).size.width,
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(20),
//                               color:_isselect=="1"? AppColor.primaryColor:Colors.transparent
//                           ),
//                           child: MaterialButton(
//                             onPressed: () {
//                               Helper.moveToScreenwithPush(context, ProfileAccountScreen());
//                               setState(() {
//                                 _isselect="1";
//                               });
//                             },
//
//                             padding: EdgeInsets.zero,
//                             child: Container(
//                               padding: EdgeInsets.symmetric(horizontal: 20),
//                               child: Row(
//                                 children: [
//                                   _isselect=="1"? Icon(Icons.person,size: 30,color: Colors.white,):Icon(Icons.person,size: 30,),
//                                   SizedBox(
//                                     width: 20,
//                                   ),
//                                   _isselect=="1"? Text('Profile',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.white),):Text('Profile',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 15,
//                         ),
//                         Container(
//                           height: 60,
//                           width: MediaQuery.of(context).size.width,
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(20),
//                               color:_isselect=="2"? AppColor.primaryColor:Colors.transparent
//                           ),
//                           child: MaterialButton(
//                             onPressed: () {
//                               Helper.moveToScreenwithPush(context, TasksHome());
//                               setState(() {
//                                 _isselect="2";
//                               });
//                             },
//
//                             padding: EdgeInsets.zero,
//                             child: Container(
//                               padding: EdgeInsets.symmetric(horizontal: 20),
//                               child:  Row(
//                                   children: [
//                                    _isselect=="2"? Image.asset(ProjectImage.order_details,height: 30,width: 30,color: Colors.white,):Image.asset(ProjectImage.order_details,height: 30,width: 30,),
//                                     SizedBox(
//                                       width: 20,
//                                     ),
//                                _isselect=="2"?Text('Order details',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.white),):Text('Order details',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
//                                   ],
//                                 ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 15,
//                         ),
//                         Container(
//                           height: 60,
//                           width: MediaQuery.of(context).size.width,
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(20),
//                               color:_isselect=="3"? AppColor.primaryColor:Colors.transparent
//                           ),
//                           child: MaterialButton(
//                             onPressed: () {
//                               Helper.moveToScreenwithPush(context, PricingByPiece());
//                               setState(() {
//                                 _isselect="3";
//                               });
//                             },
//
//                             padding: EdgeInsets.zero,
//                             child: Container(
//                               padding: EdgeInsets.symmetric(horizontal: 20),
//                               child:  Row(
//                                   children: [
//                                     _isselect=="3"? Image.asset(ProjectImage.offernew,height: 30,width: 30,color: Colors.white,):Image.asset(ProjectImage.offernew,height: 30,width: 30,),
//                                     SizedBox(
//                                       width: 20,
//                                     ),
//                                     _isselect=="3"?Text('Pricing page',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.white),):Text('Pricing page',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),)
//                                   ],
//                                 ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 15,
//                         ),
//                         Container(
//                           height: 60,
//                           width: MediaQuery.of(context).size.width,
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(20),
//                               color:_isselect=="4"? AppColor.primaryColor:Colors.transparent
//                           ),
//                           child: MaterialButton(
//                             onPressed: () {
//                               Helper.moveToScreenwithPush(context, ViewCouponsScreen());
//                               setState(() {
//                                 _isselect="4";
//                               });
//                             },
//
//                             padding: EdgeInsets.zero,
//                             child: Container(
//                               padding: EdgeInsets.symmetric(horizontal: 20),
//                               child:  Row(
//                                 children: [
//                                   _isselect=="4"?Image.asset(ProjectImage.offernew,height: 30,width: 30,color: Colors.white,):Image.asset(ProjectImage.offernew,height: 30,width: 30,),
//                                   SizedBox(
//                                     width: 20,
//                                   ),
//                                   _isselect=="4"? Text('Promotions',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.white),):Text('Promotions',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),)
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 15,
//                         ),
//                         Container(
//                           height: 60,
//                           width: MediaQuery.of(context).size.width,
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(20),
//                               color:_isselect=="5"? AppColor.primaryColor:Colors.transparent
//                           ),
//                           child: MaterialButton(
//                             onPressed: () {
//                               Helper.moveToScreenwithPush(context, SupportChatScreen());
//                               setState(() {
//                                 _isselect="5";
//                               });
//                             },
//
//                             padding: EdgeInsets.zero,
//                             child: Container(
//                               padding: EdgeInsets.symmetric(horizontal: 20),
//                               child: Row(
//                                 children: [
//                                   _isselect=="5"? Image.asset(ProjectImage.support,height: 30,width: 30,color: Colors.white,): Image.asset(ProjectImage.support,height: 30,width: 30,),
//                                   SizedBox(
//                                     width: 20,
//                                   ),
//                                   _isselect=="5"? Text('Support/Chat',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.white),): Text('Support/Chat',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   )
//
//                   // Center(
//                   //   child: ListTile(
//                   //     leading: Icon(Icons.person, size: 27),
//                   //     title:
//                   //     onTap: () {
//                   //       Navigator.push(
//                   //           context,
//                   //           MaterialPageRoute(
//                   //               builder: (context) =>
//                   //                   const ProfileAccountScreen()));
//                   //     },
//                   //   ),
//                   // ),
//                   // ListTile(
//                   //   leading:
//                   //   title: Text('Order details',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
//                   //   onTap: () {
//                   //     Navigator.push(
//                   //         context,
//                   //         MaterialPageRoute(
//                   //             builder: (context) => const TasksHome()));
//                   //   },
//                   // ),
//
//                   // ListTile(
//                   //   leading: Image.asset(
//                   //     "assets/icons/document.png",
//                   //     height: 27,
//                   //   ),
//                   //   title: Text('Additional details'),
//                   //   onTap: () {
//                   //   },
//                   // ),
//                 ],
//               ),
//             ],
//           )),
//     );
//   }
// }
