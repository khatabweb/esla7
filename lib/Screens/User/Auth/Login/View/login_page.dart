import 'package:esla7/Screens/Widgets/Custom_ShapeContainer.dart';
import 'package:esla7/Screens/Widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'view.dart';

class LoginPage extends StatelessWidget {
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
                SizedBox(height: 50),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: width * 0.09),
                    child: CustomLogo(),
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.symmetric(vertical: width / 4),
                //   child: CustomLogo(),
                // ),
                ShapeContainer(
                  // height: MediaQuery.of(context).size.height / 2,
                  text: "log_in".tr(),
                  child: LoginForm(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
