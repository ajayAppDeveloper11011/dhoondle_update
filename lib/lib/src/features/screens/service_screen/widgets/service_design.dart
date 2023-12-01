import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


import '../../../controllers/servicelist_controller.dart';
import '../../service_screen.dart';

class ServiceListDesign extends StatelessWidget {
   ServiceListDesign({
    Key? key,
    required this.choices,
  }) : super(key: key);

  final List<Choice> choices;
  final serviceController=Get.put(ServiceListController());
  String service="";

   void initState() {
     // TODO: implement initState
     // super.initState();
     serviceController.serviceApi();
   }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child:Obx(()=> serviceController.isLoading.value
          ? Center(
        child: CircularProgressIndicator(),
      )
          : GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 15,
              childAspectRatio: 2 / 2),
          itemCount:serviceController.serviceListApiModel?.serviceList==null?0: serviceController.serviceListApiModel?.serviceList?.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 10),
              child: InkWell(
                onTap: () => {
                  service=serviceController.serviceListApiModel!.serviceList![index].services.toString(),
                  // Helper.moveToScreenwithPush(context, PlumberScreen(services: serviceController.serviceListApiModel!.serviceList![index].services.toString(),))
                  Get.toNamed('/plumber',arguments: service.toString()),
                  // Get.toNamed('/plumber')
                },
                child: Container(
                  // height: 200.0,
                  // width: 200.0,
                    decoration: const BoxDecoration(
                      color: Color(0xFFffffff),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 4.0, // soften the shadow
                          spreadRadius: 0.0, //extend the shadow
                          offset: Offset(
                            0.0, // Move to right 5  horizontally
                            5.0, // Move to bottom 5 Vertically
                          ),
                        )
                      ],
                    ),

                    // width: MediaQuery.of(context).size.width * 0.5,
                    // height: MediaQuery.of(context).size.height * 0.3,
                    // decoration: BoxDecoration(
                    //     boxShadow: [
                    //       BoxShadow(
                    //         color: Color(0xff000000),
                    //         blurRadius: 4.0, // soften the shadow
                    //         spreadRadius: 0.0, //extend the shadow
                    //         offset: Offset(
                    //           0.0, // Move to right 5  horizontally
                    //           0.0, // Move to bottom 5 Vertically
                    //         ),
                    //       )
                    //     ],
                    //     color: choices[index].color,
                    //     //color: Colors.white,
                    //     border: Border.all(color: Color(0xffEAEDF2)),
                    //     borderRadius: BorderRadius.circular(5)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: CachedNetworkImage(
                            imageUrl:
                            serviceController.serviceListApiModel!.serviceList![index].image.toString(),
                            fit: BoxFit.fill,
                            height: 100,
                            width: 100,
                            placeholder: (context, url) =>
                                LinearProgressIndicator(
                                  color: Colors.white.withOpacity(0.2),
                                  backgroundColor: Colors.white.withOpacity(.5),
                                ),
                            errorWidget: (context, url, error) => Container(
                              height: 100,
                              width: 100,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                                color:Colors.transparent,
                              ),
                              child: Center(
                                  child: Image.asset(
                                    choices[index].image,
                                    height: 100,
                                    width: 100,
                                  )),
                            ),
                          )


                          // Container(
                          //   height: 50,
                          //   width: 50,
                          //   child: Image.asset(
                          //     choices[index].image,
                          //     fit: BoxFit.fill,
                          //     // height: 80,
                          //   ),
                          // ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          serviceController.serviceListApiModel!.serviceList![index].services.toString(),
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    )),
              ),
            );
          }),
    ));
  }
}