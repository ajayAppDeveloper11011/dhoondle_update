import 'dart:convert';

import 'package:dhoondle/src/constants/helper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;

import '../../api_model/get_property_model.dart';
import '../../constants/Api.dart';




class TabbarTextNew extends StatefulWidget {
  const TabbarTextNew({super.key});

  @override
  TabbarTextNewState createState() => TabbarTextNewState();
}

class TabbarTextNewState extends State<TabbarTextNew> {

  int initPosition = 1;
  GetPropertyCategoryModel?_getPropertyCategoryModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Helper.checkInternet(categoryapi());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomTabView(
          initPosition: initPosition,
          itemCount: _getPropertyCategoryModel!.categoryList.length,
          tabBuilder: (context, index) => Tab(text: _getPropertyCategoryModel!.categoryList[index].category.toString()),
          pageBuilder: (context, index) => Center(child: Text(_getPropertyCategoryModel!.categoryList[index].category.toString())),
          onPositionChange: (index) {
            print('current position: $index');
            initPosition = index;
          },
          onScroll: (position) => print('$position'),
        ),
      ),

    );
  }
  Future<void>categoryapi() async {
    print("<=============categoryapi =============>");

    final prefs = await SharedPreferences.getInstance();
    var user_id=   await prefs.getString('user_id');

    // setProgress(true);

    try {
      var res = await http.get(Uri.parse(Api.getPropertyCategory+"?user_id=${user_id}"),);
      print("Response ============>" + res.body);

      if (res.statusCode == 200) {
        print("urvashi ============>");
        try {
          final jsonResponse = jsonDecode(res.body);
          GetPropertyCategoryModel model = GetPropertyCategoryModel.fromJson(jsonResponse);

          if (model.status == "true") {
            print("Model status true");
            setState(() {
              _getPropertyCategoryModel=model;
            });

            // setProgress(false);

            // setState(() {
            //   _getprofileApi = model;
            //   fullNameController.text= _getprofileApi!.data.name.toString();
            //   addressController.text= _getprofileApi!.data.address.toString();
            //   emailController.text= _getprofileApi!.data.email.toString();
            //   mobileController.text= _getprofileApi!.data.mobile.toString();
            //
            // });

            // ToastMessage.msg(model.message.toString());
          } else {
            setState(() {
              // _hasData = false;
            });
            // setProgress(false);
            print("false ### ============>");
            // ToastMessage.msg(model.message.toString());
          }
        } catch (e) {
          // _hasData = false;
          // print("false ============>");
          // ToastMessage.msg(StaticMessages.API_ERROR);
          print('exception ==> ' + e.toString());
        }
      } else {
        print("status code ==> " + res.statusCode.toString());
        // ToastMessage.msg(StaticMessages.API_ERROR);
      }
    } catch (e) {
      // _hasData = false;
      // ToastMessage.msg(StaticMessages.API_ERROR);
      print('Exception ======> ' + e.toString());
    }
    // setProgress(false);
  }
}

class CustomTabView extends StatefulWidget {
  const CustomTabView({
    super.key,
    required this.itemCount,
    required this.tabBuilder,
    required this.pageBuilder,
    this.stub,
    this.onPositionChange,
    this.onScroll,
    this.initPosition,
  });

  final int itemCount;
  final IndexedWidgetBuilder tabBuilder;
  final IndexedWidgetBuilder pageBuilder;
  final Widget? stub;
  final ValueChanged<int>? onPositionChange;
  final ValueChanged<double>? onScroll;
  final int? initPosition;

  @override
  CustomTabsState createState() => CustomTabsState();
}

class CustomTabsState extends State<CustomTabView>
    with TickerProviderStateMixin {
  late TabController controller;
  late int _currentCount;
  late int _currentPosition;

  @override
  void initState() {
    _currentPosition = widget.initPosition ?? 0;
    controller = TabController(
      length: widget.itemCount,
      vsync: this,
      initialIndex: _currentPosition,
    );
    controller.addListener(onPositionChange);
    controller.animation!.addListener(onScroll);
    _currentCount = widget.itemCount;
    super.initState();
  }

  @override
  void didUpdateWidget(CustomTabView oldWidget) {
    if (_currentCount != widget.itemCount) {
      controller.animation!.removeListener(onScroll);
      controller.removeListener(onPositionChange);
      controller.dispose();

      if (widget.initPosition != null) {
        _currentPosition = widget.initPosition!;
      }

      if (_currentPosition > widget.itemCount - 1) {
        _currentPosition = widget.itemCount - 1;
        _currentPosition = _currentPosition < 0 ? 0 : _currentPosition;
        if (widget.onPositionChange is ValueChanged<int>) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted && widget.onPositionChange != null) {
              widget.onPositionChange!(_currentPosition);
            }
          });
        }
      }

      _currentCount = widget.itemCount;
      setState(() {
        controller = TabController(
          length: widget.itemCount,
          vsync: this,
          initialIndex: _currentPosition,
        );
        controller.addListener(onPositionChange);
        controller.animation!.addListener(onScroll);
      });
    } else if (widget.initPosition != null) {
      controller.animateTo(widget.initPosition!);
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    controller.animation!.removeListener(onScroll);
    controller.removeListener(onPositionChange);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.itemCount < 1) return widget.stub ?? Container();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          child: TabBar(
            isScrollable: true,
            controller: controller,
            labelColor: Theme.of(context).primaryColor,
            unselectedLabelColor: Theme.of(context).hintColor,
            indicator: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 2,
                ),
              ),
            ),
            tabs: List.generate(
              widget.itemCount,
                  (index) => widget.tabBuilder(context, index),
            ),
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: controller,
            children: List.generate(
              widget.itemCount,
                  (index) => widget.pageBuilder(context, index),
            ),
          ),
        ),
      ],
    );
  }

  void onPositionChange() {
    if (!controller.indexIsChanging) {
      _currentPosition = controller.index;
      if (widget.onPositionChange is ValueChanged<int>) {
        widget.onPositionChange!(_currentPosition);
      }
    }
  }

  void onScroll() {
    if (widget.onScroll is ValueChanged<double>) {
      widget.onScroll!(controller.animation!.value);
    }
  }
}
