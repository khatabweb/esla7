import 'ForgetPassword_form.dart';
import '../../../../Widgets/Custom_ShapeContainer.dart';
import '../../../../Widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class ForgetPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: width / 4),
                child: CustomLogo(),
              ),
              ShapeContainer(
                height: MediaQuery.of(context).size.height / 2,
                text: "please_enter_phone".tr(),
                child: ForgetPasswordForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
