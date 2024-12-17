import '../../../../../../Widgets/Custom_DrawText.dart';
import '../../../../../../../core/Theme/color.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class OrderNumber extends StatelessWidget {
  final int? number;
  const OrderNumber({this.number});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      padding: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: Color(0xFFdce6f2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DrawHeaderText(text: "order_number".tr(), fontSize: 12),
          DrawHeaderText(
              text: "$number", color: ThemeColor.mainGold, fontSize: 12),
        ],
      ),
    );
  }
}
