import '../../ConfirmCode/View/ConfirmCode_View.dart';
import '../Bloc/cubit.dart';
import '../Bloc/state.dart';
import '../../../../Widgets/AnimatedWidgets.dart';
import '../../../../Widgets/CenterLoading.dart';
import '../../../../Widgets/Custom_Button.dart';
import '../../../../Widgets/Custom_CountryKey.dart';
import '../../../../Widgets/Custom_SnackBar.dart';
import '../../../../Widgets/Custom_TextFormField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class ForgetPasswordForm extends StatefulWidget {
  @override
  State<ForgetPasswordForm> createState() => _ForgetPasswordFormState();
}

class _ForgetPasswordFormState extends State<ForgetPasswordForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cubit = UserResetCubit.get(context);
    return Form(
      key: _formKey,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: AnimatedWidgets(
          verticalOffset: 150,
          child: Column(
            children: [
              SizedBox(height: 20),
              _PhoneTextField(),

              ///Reset Password button bloc
              BlocConsumer<UserResetCubit, ForgetState>(
                listener: (_, state) {
                  if (state is ForgetErrorState) {
                    customSnackBar(_, state.error);
                  } else if (state is ForgetSuccessState) {
                    showCupertinoDialog(
                        context: context,
                        builder: (_) => ConfirmCodeForm(confirmSignUp: false));
                    print("============= success ================");
                  }
                },
                builder: (context, state) {
                  return state is ForgetLoadingState
                      ? CenterLoading()
                      : _SendButton(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              cubit.userResetPassword();
                            }
                          },
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PhoneTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = UserResetCubit.get(context);
    return CustomTextField(
      verticalPadding: 5,
      secureText: false,
      label: "phone_number".tr(),
      inputType: TextInputType.phone,
      suffixIcon: CountryCode(),
      validate: (value) {
        if (value!.isEmpty) {
          return "enter_phone".tr();
        } else if (value.length < 9 || value.length > 9) {
          return "phone_must_be_nine_numbers".tr();
        }
        return null;
      },
      onChanged: (value) {
        cubit.phone = "$value";
        print("::::phone number::::$value");
      },
    );
  }
}

class _SendButton extends StatelessWidget {
  final VoidCallback? onTap;
  const _SendButton({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: "send".tr(),
      topPadding: 25,
      bottomPadding: 20,
      onTap: onTap,
    );
  }
}
