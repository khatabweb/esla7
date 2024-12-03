import 'package:esla7/Screens/User/Auth/ConfirmCode/Bloc/cubit.dart';
import 'package:esla7/Screens/User/Auth/ConfirmCode/Bloc/state.dart';
import 'package:esla7/Screens/User/Auth/SetNewPassword/View/SetNewPassword_page.dart';
import 'package:esla7/Screens/User/MainPage/main_page.dart';
import 'package:esla7/Screens/Widgets/CenterLoading.dart';
import 'package:esla7/Screens/Widgets/Custom_Button.dart';
import 'package:esla7/Screens/Widgets/Custom_SnackBar.dart';
import 'package:esla7/Screens/Widgets/Custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

class ConfirmCodeForm extends StatelessWidget {
  final bool? confirmSignUp;
  ConfirmCodeForm({Key? key, this.confirmSignUp}) : super(key: key);
  final String language = translator.activeLanguageCode;

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
          _PinCode(onDone:(on){confirmSignUpCubit.code = on;}),
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
                    ? print(":::::::::::: congratulations!! Your account is activated now.")
                    : print(":::::::::::: Forget password code confirmed");
              }
            },
            builder: (context, state) {
              return state is ConfirmCodeLoadingState
                  ? CenterLoading()
                  : _ConfirmButtons(
                      onTapConfirm: () {
                        confirmSignUpCubit.confirmCodeCubit();
                      },
                    );
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
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: PinCodeTextField(
        autofocus: false,
        highlight: true,
        pinTextStyle:TextStyle(fontSize:14, color: Theme.of(context).primaryColor),
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
