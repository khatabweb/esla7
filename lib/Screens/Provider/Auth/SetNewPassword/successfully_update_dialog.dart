import 'dart:async';
import '../Login/View/ProviderLogin_page.dart';
import '../../../Widgets/Custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class SuccessfullyUpdatedDialog extends StatefulWidget {
  @override
  _SuccessfullyUpdatedDialogState createState() => _SuccessfullyUpdatedDialogState();
}

class _SuccessfullyUpdatedDialogState extends State<SuccessfullyUpdatedDialog> {

  @override
  void initState() {
    Timer(
        Duration(seconds: 2),
            () => Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (_) => ProviderLoginPage()), (route) => false));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: "password_updated_successfully".tr(),
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