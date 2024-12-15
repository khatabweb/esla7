import '../../../../Widgets/Custom_Button.dart';
import '../../../../Widgets/Custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class CancelAlert extends StatelessWidget {
  final void Function()? onTapConfirm;
  final void Function()? onTapDelete;

  CancelAlert({this.onTapConfirm, this.onTapDelete});

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: "will_remove_your_services_from_cart".tr(),
      contact: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          _ConfirmButtons(
            onTapConfirm: onTapConfirm,
            onTapResend: onTapDelete,
          ),
        ],
      ),
    );
  }
}

class _ConfirmButtons extends StatelessWidget {
  final void Function()? onTapConfirm;
  final void Function()? onTapResend;

  const _ConfirmButtons({this.onTapConfirm, this.onTapResend});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomButton(
          rightPadding: 5,
          leftPadding: 5,
          text: "complete_order".tr(),
          isFrame: true,
          width: MediaQuery.of(context).size.width / 3,
          onTap: onTapConfirm,
        ),
        CustomButton(
          width: MediaQuery.of(context).size.width / 3,
          rightPadding: 5,
          leftPadding: 5,
          text: "remove".tr(),
          isFrame: true,
          borderColor: Color(0xFFFF3040),
          textColor: Color(0xFFFF3040),
          onTap: onTapResend,
        ),
      ],
    );
  }
}
