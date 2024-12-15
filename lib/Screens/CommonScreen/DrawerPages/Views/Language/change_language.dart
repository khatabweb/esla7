import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../../../Widgets/AnimatedWidgets.dart';
import '../../../../Widgets/Custom_AppBar.dart';

class ChangeLanguage extends StatefulWidget {
  @override
  _ChangeLanguageState createState() => _ChangeLanguageState();
}

class _ChangeLanguageState extends State<ChangeLanguage> {
  // String language = translator.activeLanguageCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        appBarTitle: "language".tr(),
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: AnimatedWidgets(
        verticalOffset: 150,
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Color(0xFFEEEEEE),
                borderRadius: BorderRadius.circular(15),
              ),
              child: _ChooseLanguage(),
            ),
            Expanded(child: SizedBox()),
            Container(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: AssetImage("assets/images/lang.png"),
                    fit: BoxFit.contain,
                  )),
            )
          ],
        ),
      ),
    );
  }
}

class _ChooseLanguage extends StatefulWidget {
  @override
  State<_ChooseLanguage> createState() => _ChooseLanguageState();
}

class _ChooseLanguageState extends State<_ChooseLanguage> {
  @override
  Widget build(BuildContext context) {
    // bool isChecked = true;
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            LocalizeAndTranslate.setLanguageCode('ar');
          },
          child: Text("العربية"),
        ),
        ElevatedButton(
          onPressed: () {
            LocalizeAndTranslate.setLanguageCode('en');
          },
          child: Text("English"),
        ),
        // Container(
        //   color: Colors.transparent,
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       DrawHeaderText(text: "العربية"),

        //       CustomCheckBox(
        //         isChecked: context.locale.languageCode == "ar"
        //             ? isChecked
        //             : !isChecked,
        //         onTap: () {
        //           isChecked = !isChecked;
        //           LocalizeAndTranslate.setLanguageCode('ar');
        //           setState(() {});
        //         },
        //       )
        //     ],
        //   ),
        // ),
        // Container(
        //   color: Colors.transparent,
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       DrawHeaderText(text: "English"),
        //       CustomCheckBox(
        //         isChecked: context.locale.languageCode == "ar"
        //             ? isChecked
        //             : !isChecked,
        //         onTap: () {
        //           LocalizeAndTranslate.setLanguageCode('en');
        //         },
        //       )
        //     ],
        //   ),
        // ),
      ],
    );
  }
}
