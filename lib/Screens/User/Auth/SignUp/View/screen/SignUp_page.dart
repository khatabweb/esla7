import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../../../../Widgets/Custom_ShapeContainer.dart';
import '../../../../../Widgets/logo.dart';
import '../widget/SignUp_form.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: width * 0.09),
                  child: CustomLogo(),
                ),
              ),
              ShapeContainer(
                text: "create_new_account".tr(),
                child: SignUpForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
