import '../../../../../Widgets/AnimatedWidgets.dart';
import '../../../../../Widgets/Custom_DrawText.dart';
import '../../../../../../Theme/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class NotificationItem extends StatelessWidget {
  final int? orderNumber;
  final String? titles;

  NotificationItem({this.orderNumber, this.titles});

  @override
  Widget build(BuildContext context) {
    // final double screenHeight = MediaQuery.of(context).size.height;
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
            Icon(CupertinoIcons.bell_solid,
                color: Theme.of(context).primaryColor, size: 25),
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
                        DrawSingleText(
                            text: "$orderNumber",
                            color: ThemeColor.mainGold,
                            fontSize: 12),
                      ],
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
