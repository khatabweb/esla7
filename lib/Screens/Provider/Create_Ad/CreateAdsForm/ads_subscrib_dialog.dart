import 'dart:async';
import 'package:esla7/Screens/Widgets/Custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class AdsSubscriptionDialog extends StatefulWidget {
  @override
  _AdsSubscriptionDialogState createState() => _AdsSubscriptionDialogState();
}

class _AdsSubscriptionDialogState extends State<AdsSubscriptionDialog> {

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
      title: "your_request_sent_to_app_admin".tr(),
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