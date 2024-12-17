import '../../../../Widgets/Custom_DrawText.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class TotalAccountStatement extends StatelessWidget {
  const TotalAccountStatement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DrawHeaderText(
              text: "total_statement_of_account".tr(),
              color: Colors.black,
              fontSize: 16),
          Container(
            height: 100,
            width: 100,
            margin: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DrawHeaderText(text: "1000", color: Colors.white, fontSize: 16),
                DrawHeaderText(text: "sar".tr(), color: Colors.white),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
