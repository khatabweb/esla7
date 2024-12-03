import 'package:esla7/Screens/Widgets/AnimatedWidgets.dart';
import 'package:esla7/Screens/Widgets/Custom_DrawText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class NoServicesAlert extends StatelessWidget {
  final language = translator.activeLanguageCode;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: language == "ar" ? TextDirection.rtl : TextDirection.ltr,
      child: AnimatedWidgets(
        verticalOffset: 150.0,
        child: CupertinoAlertDialog(
          content: Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: DrawHeaderText(text: "please_select_one_or_more_services_to_complete_the_order".tr(), textAlign: TextAlign.center),
          ),

          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: DrawSingleText(text: "back".tr(), textAlign: TextAlign.center),
            ),
          ],
        ),
      ),
    );
  }
}