import '../../../../Widgets/AnimatedWidgets.dart';
import '../../../../Widgets/Custom_AppBar.dart';
import '../../../../Widgets/Custom_CheckBox.dart';
import '../../../../Widgets/Custom_DrawText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class ChangeLanguage extends StatefulWidget {
  @override
  _ChangeLanguageState createState() => _ChangeLanguageState();
}

class _ChangeLanguageState extends State<ChangeLanguage> {
  String language = translator.activeLanguageCode;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: language == "ar" ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
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
                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                margin: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Color(0xFFEEEEEE),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: _ChooseLanguage(),
              ),


              Expanded(child: SizedBox()),


              Container(
                height: MediaQuery.of(context).size.height/2,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: AssetImage("assets/images/lang.png"),
                      fit: BoxFit.contain,
                    )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _ChooseLanguage extends StatelessWidget {
  final String lang = translator.activeLanguageCode;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            translator.setNewLanguage(
              context,
              newLanguage: "ar",
              remember: lang == "ar" ? false : true,
            );
          },
          child: Container(
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DrawHeaderText(text: "العربية"),
                CustomCheckBox(
                  isChecked: lang == "ar" ? true : false,
                  onTap: () {
                    translator.setNewLanguage(
                      context,
                      newLanguage: "ar",
                      remember: lang == "ar" ? false : true,
                    );
                  },
                )
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            translator.setNewLanguage(
              context,
              newLanguage: "en-gb",
              remember: lang == "en-gb" ? false : true,
            );
          },
          child: Container(
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DrawHeaderText(text: "English"),
                CustomCheckBox(
                  isChecked: lang == "ar" ? false : true,
                  onTap: (){
                    translator.setNewLanguage(
                      context,
                      newLanguage: "en-gb",
                      remember: lang == "en-gb" ? false : true,
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
