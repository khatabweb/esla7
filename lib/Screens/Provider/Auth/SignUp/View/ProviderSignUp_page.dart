import 'ProviderSignUp_form.dart';
import '../../../../Widgets/Custom_ShapeContainer.dart';
import '../../../../Widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class ProviderSignUpPage extends StatelessWidget {
  final String language = translator.activeLanguageCode;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: language == "ar" ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
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
                  text: "create_new_account_as_provider".tr(),
                  child: ProviderSignUpForm(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
