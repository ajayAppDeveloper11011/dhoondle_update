
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../main.dart';
import 'colors.dart';
import 'helper/session.dart';

class ChangeLanguageScreen extends StatefulWidget {
  bool? back;
  ChangeLanguageScreen({this.back});


  @override
  _ChangeLanguageScreenState createState() => _ChangeLanguageScreenState();
}

class _ChangeLanguageScreenState extends State<ChangeLanguageScreen> {

  int? selectLan;
  bool isSelect =false;

  @override
  void initState() {
     Future.delayed(Duration.zero, () {
      languageList = [
        getTranslated(context, 'ENGLISH_LAN'),
        getTranslated(context, 'HINDI_LAN'),
      ];
    });
    super.initState();
    //  getProfile();
  }


  List<String> langCode = ["en", "hi"];
  List<String?> languageList = [];
  List<Widget> getLngList(BuildContext ctx, StateSetter setModalState) {
    return languageList
        .asMap()
        .map(
          (index, element) => MapEntry(
          index,
          InkWell(
            onTap: () {
              if (mounted)
                setState(() {
                  selectLan = index;
                  _changeLan(langCode[index], ctx);
                });
              setModalState((){});
            },
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 25.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: selectLan == index
                                ? Colors.grey
                                : Colors.white,
                            border: Border.all(color: Colors.grey)),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: selectLan == index
                              ? Icon(
                            Icons.check,
                            size: 17.0,
                            color: Colors.black,
                          )
                              : Icon(
                              Icons.check_box_outline_blank,
                              size: 15.0,
                              color:Colors.white
                          ),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsetsDirectional.only(
                            start: 15.0,
                          ),
                          child: Text(
                            languageList[index].toString(),
                            style: Theme.of(this.context)
                                .textTheme
                                .subtitle1!
                                .copyWith(
                                color: Colors.black),
                          ))
                    ],
                  ),
                  // index == languageList.length - 1
                  //     ? Container(
                  //         margin: EdgeInsetsDirectional.only(
                  //           bottom: 10,
                  //         ),
                  //       )
                  //     : Divider(
                  //         color: Theme.of(context).colorScheme.lightBlack,
                  //       ),
                ],
              ),
            ),
          )),
    )
        .values
        .toList();
  }

  void _changeLan(String language, BuildContext ctx) async {
    Locale _locale = await setLocale(language);

    MyApp.setLocale(ctx, _locale);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left:20.0,right: 20),
          child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 50,),
              Padding(
                padding: const EdgeInsets.only(left:30.0),
                child: Text(getTranslated(context, 'Language'),style: TextStyle(fontWeight: FontWeight.w500,fontSize: 22),),
              ),
              SizedBox(height:10,),
              InkWell(
                onTap: () {
                  setState(() {
                    selectLan = 1; // Hindi index
                    _changeLan(langCode[1], context);
                    isSelect = !isSelect;
                  });
                },
                child: Container(
                  height:140,
                  width:MediaQuery.of(context).size.width/1.1,
                  child: Card(
                    elevation:2,
                    color: isSelect == true?AppColors.primaryColor:Colors.white,

                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height:50,),
                        Text('हिंदी',style: TextStyle(fontSize: 17,fontWeight:FontWeight.bold),),
                        SizedBox(height: 5,),
                        Text(getTranslated(context, 'HINDI_LAN'),style: TextStyle(fontWeight: FontWeight.w400)),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height:15,),
              InkWell(
                onTap: () {
                  setState(() {
                    selectLan = 0; // English index
                    _changeLan(langCode[0], context);
                    isSelect = !isSelect;
                  });
                },
                child: Container(
                  height:140,
                  width:MediaQuery.of(context).size.width/1.1,
                  child: Card(
                    elevation:2,
                    color: isSelect==false?AppColors.primaryColor:Colors.white,

                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 50,),
                        Text('English',style: TextStyle(fontSize: 17,fontWeight:FontWeight.bold),),
                        SizedBox(height:5,),
                        Text( getTranslated(context, 'ENGLISH_LAN'),style: TextStyle(fontWeight: FontWeight.w400),),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height:220,),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: 60,
                  width: MediaQuery.of(context).size.width/1.1,
                  child: ElevatedButton(onPressed: (){
                    Get.toNamed('/bottom');
                  },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                      child:Text('Continue',style: TextStyle(color: Colors.white),)),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }

}