import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../../../Widgets/Custom_ShapeContainer.dart';
import '../../../../Widgets/logo.dart';
import 'SetNewPassword_form.dart';

class SetNewPasswordPage extends StatelessWidget {
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
                padding: EdgeInsets.symmetric(vertical: width / 5),
                child: CustomLogo(),
              ),
              ShapeContainer(
                height: MediaQuery.of(context).size.height / 1.8,
                text: "set_new_password".tr(),
                child: SetProviderNewPasswordForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
