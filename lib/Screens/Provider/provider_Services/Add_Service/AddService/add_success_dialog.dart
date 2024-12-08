import 'dart:async';
import '../../../../Widgets/Custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class AddSuccessDialog extends StatefulWidget {
  @override
  _AddSuccessDialogState createState() => _AddSuccessDialogState();
}

class _AddSuccessDialogState extends State<AddSuccessDialog> {

  @override
  void initState() {
    Timer(
        Duration(seconds: 2),
            () => Navigator.pop(context));
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: "service_added_successfully".tr(),
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