import 'package:esla7/Screens/Widgets/CenterLoading.dart';
import 'package:esla7/Screens/Widgets/CenterMessage.dart';
import 'package:esla7/Theme/color.dart';
import 'package:esla7/Screens/Provider/ProviderMainPage/ProviderDrawer/ProviderDrawer.dart';
import 'package:esla7/Screens/Widgets/AnimatedWidgets.dart';
import 'package:esla7/Screens/Widgets/Custom_AppBar.dart';
import 'package:esla7/Screens/Widgets/Custom_Background.dart';
import 'package:esla7/Screens/Widgets/Custom_DrawText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import 'api/controller.dart';
import 'api/model.dart';


class ProviderNotification extends StatefulWidget {
  @override
  State<ProviderNotification> createState() => _ProviderNotificationState();
}

class _ProviderNotificationState extends State<ProviderNotification> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String language = translator.activeLanguageCode;
  OwnerNotificationController _controller = OwnerNotificationController();
  OwnerNotificationModel _model = OwnerNotificationModel();
  bool _isLoading = true;

  void getNotification() async {
    _model = await _controller.getNotification();
    setState(() => _isLoading = false);
  }

  @override
  void initState() {
    getNotification();
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
          drawer: ProviderDrawerView(),
          body: _isLoading
              ? CenterLoading()
              : _model.notification?.length == 0
                  ? CenterMessage("no_notification_yet".tr())
                  : Container(
                      height: MediaQuery.of(context).size.height,
                      margin: EdgeInsets.only(right: 15, left: 15),
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.symmetric(vertical: 5),
                        itemCount: _model.notification?.length,
                        itemBuilder: (context, index) {
                          var item = _model.notification?[index];
                          return _NotificationItem(
                            titles: language == "ar"
                                ? "${item?.body}"
                                : "${item?.bodyEn}",
                            orderNumber: item?.orderId,
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

