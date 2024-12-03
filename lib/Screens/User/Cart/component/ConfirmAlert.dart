import 'package:esla7/Theme/color.dart';
import 'package:esla7/Screens/Widgets/Custom_Button.dart';
import 'package:esla7/Screens/Widgets/Custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class ConfirmOrderAlert extends StatelessWidget {
  final void Function()? onTapHomePage;
  final void Function()? onTapOrderPage;

  ConfirmOrderAlert({this.onTapHomePage, this.onTapOrderPage});

  final String language = translator.activeLanguageCode;


  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      titleWidget: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            children: [
              TextSpan(
                text: "we_have_sent_your_order_to_provider".tr(),
                style: TextStyle(fontSize: 15, color: Theme.of(context).primaryColor, fontFamily: "JannaLT-Bold"),
              ),
              // TextSpan(
              //   text: "355",
              //   style: TextStyle(fontSize: 15, color: ThemeColor.mainGold, fontFamily: "JannaLT-Bold"),
              // ),
            ]
        ),
      ),
      contact: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          _ConfirmButtons(
            onTapHomePage: onTapHomePage,
            onTapOrderPage: onTapOrderPage,
          ),
        ],
      ),
    );
  }
}

class _ConfirmButtons extends StatelessWidget {
  final void Function()? onTapHomePage;
  final void Function()? onTapOrderPage;

  const _ConfirmButtons({this.onTapHomePage, this.onTapOrderPage});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomButton(
          width: MediaQuery.of(context).size.width / 3,
          rightPadding: 5,
          leftPadding: 5,
          text: "home_page".tr(),
          isFrame: true,
          onTap: onTapHomePage,
        ),

        CustomButton(
          width: MediaQuery.of(context).size.width / 3,
          rightPadding: 5,
          leftPadding: 5,
          text: "orders_page".tr(),
          isFrame: true,
          onTap: onTapOrderPage,
        ),
      ],
    );
  }
}
