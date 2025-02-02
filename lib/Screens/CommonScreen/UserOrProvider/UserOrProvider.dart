import '../../../core/local_storge/cache_helper.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../Provider/Auth/Login/View/ProviderLogin_page.dart';
import '../../User/Auth/Login/View/login_page.dart';
import '../../Widgets/Custom_Section.dart';

import '../../Widgets/logo.dart';

class UserOrProvider extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomLogo(size: 180),
          SizedBox(height: MediaQuery.of(context).size.width / 5),
          Container(
            height: MediaQuery.of(context).size.height / 2.5,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomSection(
                  title: "provider".tr(),
                  image: "assets/images/provider.png",
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => ProviderLoginPage()));
                    FirebaseMessaging.instance.getToken().then((value) async {
                      CacheHelper.instance!.setData("owner_google_token",
                          value: value.toString());
                      print("Provider Token:: $value");
                    });
                  },
                ),
                CustomSection(
                  title: "user".tr(),
                  image: "assets/images/user.png",
                  onTap: () {
                    CacheHelper.instance!.clear();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => LoginPage()));
                    FirebaseMessaging.instance.getToken().then((value) async {
                      
                      CacheHelper.instance!.setData("user_google_token",
                          value: value.toString());
                      print("user_google_token this is fcm Token:: $value");
                    });
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
