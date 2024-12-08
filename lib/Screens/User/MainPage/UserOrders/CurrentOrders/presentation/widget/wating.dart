import 'package:esla7/Screens/Widgets/Custom_DrawText.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class WaitingState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: MediaQuery.of(context).size.width / 3.8,
      padding: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: Color(0xFFf8f18c),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: DrawHeaderText(
          text: "waiting".tr(),
          fontSize: 12,
        ),
      ),
    );
  }
}
