import 'success_dialog.dart';
import '../../../../../Widgets/Custom_Button.dart';
import '../../../../../Widgets/Custom_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class DeleteOrderAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: "sure_to_remove_order".tr(),
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
            onTap: () {
              showCupertinoDialog(context: context, builder: (_){
                return SuccessDialog();
              });
            },
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