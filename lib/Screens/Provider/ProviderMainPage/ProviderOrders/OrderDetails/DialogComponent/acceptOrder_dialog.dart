import 'dart:async';
import 'package:esla7/Screens/Widgets/Custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class AcceptOrderDialog extends StatefulWidget {
  @override
  _AcceptOrderDialogState createState() => _AcceptOrderDialogState();
}

class _AcceptOrderDialogState extends State<AcceptOrderDialog> {

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
      title: "your_order_has_been_moved_to_accepted_orders".tr(),
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