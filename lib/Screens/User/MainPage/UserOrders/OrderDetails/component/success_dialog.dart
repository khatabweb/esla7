import 'dart:async';
import 'package:esla7/Screens/Widgets/Custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class SuccessDialog extends StatefulWidget {
  @override
  _SuccessDialogState createState() => _SuccessDialogState();
}

class _SuccessDialogState extends State<SuccessDialog> {

  @override
  void initState() {
    Timer(
        Duration(seconds: 3),
            () => Navigator.pop(context));
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: "your_rate_send_successfully".tr(),
      contact: Container(
        width: 50,
        height: 50,
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/icons/success.png"),
            fit: BoxFit.contain,
          )
        ),
      ),
    );
  }
}