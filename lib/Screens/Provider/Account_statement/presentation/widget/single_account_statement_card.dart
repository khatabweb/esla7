import '../../../../Widgets/Custom_DrawText.dart';
import '../../../../../core/Theme/color.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class SingleAccountStatementCard extends StatelessWidget {
  const SingleAccountStatementCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 2),
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
            spreadRadius: 0.2,
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2),
            child: Image.asset(
              "assets/icons/time.png",
              width: 20,
              height: 20,
              fit: BoxFit.cover,
              color: ThemeColor.mainGold,
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Container(
              // color: Colors.greenAccent,
              // margin: EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DrawHeaderText(
                    text: "2021/9/10",
                    color: ThemeColor.mainGold,
                    fontSize: 14,
                  ),
                  DrawSingleText(
                    text:
                        "هذا النص هو مثال لنص يمكن ان يستبدل في نفس المساحة لقد تم توليد النص",
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 13,
                  ),
                ],
              ),
            ),
          ),
          DrawHeaderText(
            text: "120 ${"sar".tr()}",
            fontSize: 14,
          )
        ],
      ),
    );
  }
}
