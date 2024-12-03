import 'package:esla7/Screens/Widgets/AnimatedWidgets.dart';
import 'package:esla7/Screens/Widgets/Custom_DrawText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class CustomDialog extends StatelessWidget {
  late final String? title;
  late final Widget? contact;
  late final Widget? titleWidget;
  // late final List<Widget>? actions;

  CustomDialog({this.title,this.contact, this.titleWidget});

  String language = translator.activeLanguageCode;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: language == "ar" ? TextDirection.rtl : TextDirection.ltr,
      child: AnimatedWidgets(
        duration: 1,
        horizontalOffset: 0.0,
        verticalOffset: 150.0,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
          ),
          contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 10),
          elevation: 30,
          titleTextStyle: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          title: titleWidget ?? DrawHeaderText(text: title??"", textAlign: TextAlign.center),
          content: contact,
          // actions: actions as List<Widget>,
        ),
      ),
    );
  }
}