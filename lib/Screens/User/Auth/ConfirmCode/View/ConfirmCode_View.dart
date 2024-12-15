import '../Bloc/cubit.dart';
import '../Bloc/state.dart';
import '../../SetNewPassword/View/SetNewPassword_page.dart';
import '../../../MainPage/main_page.dart';
import '../../../../Widgets/CenterLoading.dart';
import '../../../../Widgets/Custom_Button.dart';
import '../../../../Widgets/Custom_SnackBar.dart';
import '../../../../Widgets/Custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

class ConfirmCodeForm extends StatelessWidget {
  final bool? confirmSignUp;
  ConfirmCodeForm({Key? key, this.confirmSignUp}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final confirmSignUpCubit = ConfirmCodeCubit.get(context);
    return CustomDialog(
      title: "sms_code".tr(),
      contact: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(confirmSignUpCubit.code ?? "null"),
          _PinCode(onDone: (on) {
            confirmSignUpCubit.code = on;
          }),
          BlocConsumer<ConfirmCodeCubit, ConfirmCodeState>(
            listener: (_, state) {
              if (state is ConfirmCodeErrorState) {
                customSnackBar(context, state.error);
              } else if (state is ConfirmCodeSuccessState) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => confirmSignUp == true
                        ? MainPage()
                        : SetNewPasswordPage(),
                  ),
                );
                confirmSignUp == true
                    ? print(
                        ":::::::::::: congratulations!! Your account is activated now.")
                    : print(":::::::::::: Forget password code confirmed");
              }
            },
            builder: (context, state) {
              if (state is ConfirmCodeLoadingState) {
                return CenterLoading();
              } else {
                return _ConfirmButtons(
                  onTapConfirm: () {
                    confirmSignUpCubit.confirmCodeCubit();
                  },
                );
              }
            },
          )
        ],
      ),
    );
  }
}

class _PinCode extends StatelessWidget {
  final void Function(String)? onDone;
  const _PinCode({Key? key, this.onDone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: PinCodeTextField(
        controller:
            TextEditingController(text: ConfirmCodeCubit.get(context).code),
        autofocus: false,
        highlight: true,
        pinTextStyle:
            TextStyle(fontSize: 14, color: Theme.of(context).primaryColor),
        pinBoxHeight: screenHeight * .08,
        pinBoxWidth: screenHeight * .075,
        pinBoxRadius: 12,
        pinBoxBorderWidth: 1,
        errorBorderColor: Colors.red,
        pinBoxColor: Color(0xFFEEEEEE),
        highlightColor: Theme.of(context).primaryColor,
        hasTextBorderColor: Theme.of(context).primaryColor,
        pinBoxOuterPadding: EdgeInsets.symmetric(horizontal: 5),
        defaultBorderColor: Colors.white,
        onDone: onDone,
      ),
    );
  }
}

class _ConfirmButtons extends StatelessWidget {
  final void Function()? onTapConfirm;

  const _ConfirmButtons({this.onTapConfirm});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: CustomButton(
        rightPadding: 5,
        leftPadding: 5,
        text: "confirm".tr(),
        width: MediaQuery.of(context).size.width,
        onTap: onTapConfirm,
      ),
      // child: Row(
      //   children: [
      //     CustomButton(
      //       rightPadding: 5,
      //       leftPadding: 5,
      //       text: "confirm".tr(),
      //       width: MediaQuery.of(context).size.width / 4,
      //       onTap: onTapConfirm,
      //     ),
      //
      //     Expanded(
      //       child: CustomButton(
      //         rightPadding: 5,
      //         leftPadding: 5,
      //         text: "resend_code".tr(),
      //         isFrame: true,
      //         onTap: onTapResend,
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
