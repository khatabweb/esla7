import 'dart:async';

import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../../../Widgets/Custom_dialog.dart';

class CheckoutSuccessDialog extends StatefulWidget {
  @override
  _CheckoutSuccessDialogState createState() => _CheckoutSuccessDialogState();
}

class _CheckoutSuccessDialogState extends State<CheckoutSuccessDialog> {

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
      title: "payment_completed".tr(),
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