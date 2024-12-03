import 'package:esla7/Screens/Provider/Auth/Login/View/ProviderLogin_page.dart';
import 'package:esla7/Screens/User/Auth/Login/View/login_page.dart';
import 'package:esla7/Screens/Widgets/Custom_Section.dart';
import 'package:esla7/Screens/Widgets/logo.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserOrProvider extends StatelessWidget {

  final String language = translator.activeLanguageCode;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: language == "ar" ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomLogo(size: 180),
            SizedBox(height: screenWidth / 5),
            Container(
              height: screenHeight / 2.5,
              width: screenWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomSection(
                    title: "provider".tr(),
                    image: "assets/images/provider.png",
                    onTap: () async {
                      SharedPreferences _pref = await SharedPreferences.getInstance();
                      _pref.clear();
                      Navigator.push(context, MaterialPageRoute(builder: (_) => ProviderLoginPage()));
                      FirebaseMessaging.instance.getToken().then((value) async {
                        _pref.setString("owner_google_token", value.toString());
                        print("Provider Token:: $value");
                      });
                    },
                  ),
                  CustomSection(
                    title: "user".tr(),
                    image: "assets/images/user.png",
                    onTap: () async {
                      SharedPreferences _pref = await SharedPreferences.getInstance();
                      _pref.clear();
                      Navigator.push(context, MaterialPageRoute(builder: (_) => LoginPage()));
                      FirebaseMessaging.instance.getToken().then((value) async {
                        _pref.setString("user_google_token", value.toString());
                        print("User Token:: $value");
                      });
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


