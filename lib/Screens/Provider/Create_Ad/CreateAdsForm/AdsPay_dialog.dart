import '../../../Widgets/Custom_Button.dart';
import '../../../Widgets/Custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class AdsPayDialog extends StatelessWidget {
  final void Function()? onTapBalance;
  final void Function()? onTapEWallet;

  const AdsPayDialog({Key? key, this.onTapBalance, this.onTapEWallet}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: "please_choose_payment_type".tr(),
      contact: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          _ConfirmButtons(
            onTapBalance: onTapBalance,
            onTapEWallet: onTapEWallet,
          ),
        ],
      ),
    );
  }
}


class _ConfirmButtons extends StatelessWidget {
  final void Function()? onTapBalance;
  final void Function()? onTapEWallet;

  const _ConfirmButtons({Key? key, this.onTapBalance, this.onTapEWallet}) : super(key: key);
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
            text: "balance".tr(),
            fontSize: context.locale.languageCode == "ar" ? 13 : 15,
            isFrame: true,
            onTap: (){},
          ),

          CustomButton(
            width: MediaQuery.of(context).size.width / 3,
            height: 40,
            rightPadding: 5,
            leftPadding: 5,
            text: "e_wallet".tr(),
            fontSize: context.locale.languageCode == "ar" ? 13 : 15,
            isFrame: true,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}