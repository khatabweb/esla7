import '../buttons_bloc/data/refuse/cubit.dart';
import '../buttons_bloc/data/refuse/state.dart';
import '../../../../../Widgets/CenterLoading.dart';
import '../../../../../Widgets/Custom_Button.dart';
import '../../../../../Widgets/Custom_SnackBar.dart';
import '../../../../../Widgets/Custom_TextFormField.dart';
import '../../../../../Widgets/Custom_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import 'endingOrder_dialog.dart';

class RejectedAlert extends StatelessWidget {
  final int? orderId;
  const RejectedAlert({Key? key, this.orderId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: "order_refused".tr(),
      contact: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          _RefusedReasonTextField(),
          _ConfirmButtons(orderId: orderId),
        ],
      ),
    );
  }
}

class _RefusedReasonTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      verticalPadding: 5,
      secureText: false,
      lines: 3,
      label: "the_reason_of_refuse".tr(),
      inputType: TextInputType.name,
    );
  }
}


class _ConfirmButtons extends StatelessWidget {
  final int? orderId;

  const _ConfirmButtons({Key? key, this.orderId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final refuseCubit = RefuseCubit.get(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: BlocConsumer<RefuseCubit, RefuseState>(
        listener: (_, state) {
          if (state is RefuseErrorState) {
            customSnackBar(_, state.error);
          } else if (state is RefuseSuccessState) {
            Navigator.pop(context);
            showCupertinoDialog(context: context, builder: (_) => EndingOrderDialog());
            print("========== done ==========");
          }
        },
        builder: (context, state) {
          return state is RefuseLoadingState
              ? CenterLoading()
              : Row(
                  children: [
                    CustomButton(
                      width: MediaQuery.of(context).size.width / 3,
                      height: 40,
                      rightPadding: 5,
                      leftPadding: 5,
                      text: "reject".tr(),
                      onTap: () => refuseCubit.refuseOrder(orderId),
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
                );
        },
      ),
    );
  }
}