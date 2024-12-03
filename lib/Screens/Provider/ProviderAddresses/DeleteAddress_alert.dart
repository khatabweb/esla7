import 'package:esla7/Screens/Widgets/Custom_Button.dart';
import 'package:esla7/Screens/Widgets/Custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';


class RemoveAddressAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: "the_address_will_be_deleted_from_your_account".tr(),
      contact: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          _ConfirmButtons(),
        ],
      ),
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
            text: "remove".tr(),
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