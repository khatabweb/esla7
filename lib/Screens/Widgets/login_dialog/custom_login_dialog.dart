import 'package:esla7/Screens/CommonScreen/UserOrProvider/UserOrProvider.dart';
import 'package:esla7/Screens/Widgets/Custom_Button.dart';
// import 'package:esla7/Screens/Widgets/Custom_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../AnimatedWidgets.dart';
import '../Custom_DrawText.dart';

// class LoginAlert extends StatelessWidget {
//   final String language = translator.activeLanguageCode;
//
//   @override
//   Widget build(BuildContext context) {
//     return CustomDialog(
//       titleWidget: Column(
//         children: [
//           Image.asset("assets/icons/danger.png", color: Theme.of(context).primaryColor, height: 80, width: 80),
//           DrawHeaderText(text: "you_should_login_first".tr(), textAlign: TextAlign.center),
//         ],
//       ),
//       contact: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         mainAxisSize: MainAxisSize.min,
//         children: [_ConfirmButtons()],
//       ),
//     );
//   }
// }

class _ConfirmButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomButton(
          rightPadding: 5,
          leftPadding: 5,
          text: "log_in".tr(),
          width: MediaQuery.of(context).size.width / 3,
          onTap: () async {
            SharedPreferences _pref = await SharedPreferences.getInstance();
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => UserOrProvider()), (route) => false);
            _pref.setBool("skip", false);
            print("skip case :::: ${_pref.getBool("skip")}");
          },
        ),

        CustomButton(
          width: MediaQuery.of(context).size.width / 3,
          rightPadding: 5,
          leftPadding: 5,
          text: "cancel".tr(),
          isFrame: true,
          borderColor: Colors.red,
          textColor: Colors.red,
          onTap: () => Navigator.pop(context),
        ),
      ],
    );
  }
}


class LoginAlert extends StatelessWidget {
  final language = translator.activeLanguageCode;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: language == "ar" ? TextDirection.rtl : TextDirection.ltr,
      child: AnimatedWidgets(
        verticalOffset: 150.0,
        child: CupertinoAlertDialog(
          // title: Image.asset("assets/icons/danger.png",color: Theme.of(context).accentColor, height: 60, width: 60),
          content: Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: DrawHeaderText(text: "you_should_login_first".tr(), textAlign: TextAlign.center),
          ),

          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: DrawSingleText(text: "cancel".tr(), textAlign: TextAlign.center),
            ),
            TextButton(
              onPressed: () async {
                SharedPreferences _pref = await SharedPreferences.getInstance();
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => UserOrProvider()), (route) => false);
                _pref.setBool("skip", false);
                print("skip case :::: ${_pref.getBool("skip")}");
              },
              child: DrawSingleText(text: "log_in".tr(), textAlign: TextAlign.center),
            ),
          ],
        ),
      ),
    );
  }
}