import 'package:esla7/Screens/Widgets/CenterLoading.dart';
import 'package:esla7/Screens/Widgets/CenterMessage.dart';
import 'package:esla7/Screens/Widgets/login_dialog/custom_login_dialog.dart';
import 'package:esla7/Theme/color.dart';
import 'package:esla7/Screens/User/MainPage/Custom_Drawer/Custom_Drawer.dart';
import 'package:esla7/Screens/Widgets/AnimatedWidgets.dart';
import 'package:esla7/Screens/Widgets/Custom_AppBar.dart';
import 'package:esla7/Screens/Widgets/Custom_Background.dart';
import 'package:esla7/Screens/Widgets/Custom_DrawText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'API/controller.dart';
import 'API/model.dart';

class NotificationPage extends StatefulWidget {
  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String language = translator.activeLanguageCode;
  bool isLoading = true;
  UserNotificationModel model = UserNotificationModel();
  UserNotificationController controller = UserNotificationController();
  bool? skip;

  void getNotification() async {
    model = await controller.getNotification();
    setState(() {
      isLoading = false;
    });
  }

  void skipCase() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setState(() {
      skip = _pref.getBool("skip");
    });
    print("skip case ::::::::::: $skip");
  }

  @override
  void initState() {
    getNotification();
    skipCase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: language == "ar" ? TextDirection.rtl : TextDirection.ltr,
      child: CustomBackground(
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.transparent,
          appBar: customAppBar(
            context: context,
            appBarTitle: "notifications".tr(),
            showDrawerIcon: true,
            onPressedDrawer: () => _scaffoldKey.currentState!.openDrawer(),
          ),
          drawer: DrawerView(),
          body: skip == true ? LoginAlert() : isLoading
              ? CenterLoading()
              : model.notification?.length == 0
                  ? CenterMessage("no_notification_yet".tr())
                  : Container(
                      height: MediaQuery.of(context).size.height,
                      margin: EdgeInsets.only(right: 15, left: 15),
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.symmetric(vertical: 5),
                        itemCount: model.notification?.length,
                        itemBuilder: (context, index) {
                          return _NotificationItem(
                            titles: language == "ar"
                                ? "${model.notification?[index]?.body}"
                                : "${model.notification?[index]?.bodyEn}",
                            orderNumber: model.notification?[index]?.orderId,
                          );
                        },
                      ),
                    ),
        ),
      ),
    );
  }
}


class _NotificationItem extends StatelessWidget {
  final int? orderNumber;
  final String? titles;

  _NotificationItem({this.orderNumber, this.titles});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return AnimatedWidgets(
      verticalOffset: 150,
      child: Container(
        height: screenWidth / 5,
        width: screenWidth,
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(CupertinoIcons.bell_solid, color: Theme.of(context).primaryColor,size: 25),
            SizedBox(width: 10),
            Expanded(
              child: Container(
                child: DrawSingleText(
                  text: titles,
                  color: Theme.of(context).primaryColor,
                  fontSize: 14,
                ),
              ),
            ),

            orderNumber == null
                ? SizedBox()
                : Container(
                    height: 35,
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: Color(0xFFdce6f2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DrawSingleText(text: "order_number".tr(), fontSize: 12),
                        DrawSingleText(text: "$orderNumber", color: ThemeColor.mainGold, fontSize: 12),
                      ],
                    ),
                  )
          ],
        ),
      ),
    );
  }
}

