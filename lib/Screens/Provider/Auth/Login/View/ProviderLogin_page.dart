import 'ProviderLogin_form.dart';
import '../../../../Widgets/Custom_ShapeContainer.dart';
import '../../../../Widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class ProviderLoginPage extends StatelessWidget {
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
                text: "login_as_provider".tr(),
                child: ProviderLoginForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
