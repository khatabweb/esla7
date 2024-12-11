import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../../Widgets/Custom_Button.dart';
import '../../../Widgets/Custom_CountryKey.dart';
import '../../../Widgets/Custom_DrawText.dart';
import '../../../Widgets/Custom_TextFormField.dart';
import '../../../Widgets/Custom_dialog.dart';
import '../../../Widgets/Custom_popover.dart';

class EditServiceDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: "edit_service".tr(),
      contact: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          _SubServiceType(),
          _ServiceName(),
          _ServicePriceTextField(),
          _ServiceDescTextField(),
          _ConfirmButtons(),
        ],
      ),
    );
  }
}


class _SubServiceType extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    List<String> subServiceList = [
      "مصاعد الامل",
      "مصاعد الصفا",
      "مصاعد المروة",
      "مصاعد الاسراء",
    ];

    final double length = subServiceList.length.toDouble();

    return CustomPopOver(
      width: width,
      dropWidth: width / 1.1,
      text: "sub_service".tr(),
      color: Color(0xFFEEEEEE),
      dropHeight: length * 38,
      itemList: subServiceList.map((item) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: InkWell(
            onTap: (){},
            child: DrawSingleText(
              textAlign: TextAlign.center,
              text: item,
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _ServiceName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    List<String> serviceNameList = [
      "صيانة سلوك",
      "صيانة سيور",
      "صيانة كهرباء",
      "صيانة أرضية",
      "صيانة كاميرات",
      "صيانة جهاز الإنظار",
    ];

    final double length = serviceNameList.length.toDouble();
    return CustomPopOver(
      width: width,
      dropWidth: width / 1.1,
      dropHeight: length * 38,
      text: "service_name".tr(),
      color: Color(0xFFEEEEEE),
      itemList: serviceNameList.map((item) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: InkWell(
            onTap: (){},
            child: DrawSingleText(
              textAlign: TextAlign.center,
              text: item,
            ),
          ),
        );
      }).toList(),
    );
  }
}


class _ServicePriceTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      verticalPadding: 5,
      secureText: false,
      label: "service_price".tr(),
      hint: "20 ${"sar".tr()}",
      suffixIcon: CountryCode(countyCode: "sar".tr()),
      inputType: TextInputType.number,
    );
  }
}


class _ServiceDescTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      verticalPadding: 5,
      secureText: false,
      lines: 2,
      label: "service_desc".tr(),
      inputType: TextInputType.text,
    );
  }
}


class _ConfirmButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          CustomButton(
            width: MediaQuery.of(context).size.width / 3,
            height: 40,
            rightPadding: 5,
            leftPadding: 5,
            text: "save".tr(),
            onTap: (){},
          ),

          CustomButton(
            width: MediaQuery.of(context).size.width / 3,
            height: 40,
            rightPadding: 5,
            leftPadding: 5,
            text: "back".tr(),
            isFrame: true,
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}