import 'package:esla7/Screens/Widgets/Custom_Button.dart';
import 'package:esla7/Screens/Widgets/Custom_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class PayDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: "${"total_order_price".tr()} 150 ${"sar".tr()}",
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
            text: "pay".tr(),
            // onTap: () {
            //   showCupertinoDialog(context: context, builder: (_){
            //     return SuccessDialog();
            //   });
            // },
          ),

          CustomButton(
            width: MediaQuery.of(context).size.width / 3,
            height: 40,
            rightPadding: 5,
            leftPadding: 5,
            text: "cancel".tr(),
            isFrame: true,
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}