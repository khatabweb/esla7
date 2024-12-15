import '../data/Bloc/cubit.dart';
import '../data/Bloc/state.dart';
import '../password_update_success.dart';
import '../../../../Widgets/AnimatedWidgets.dart';
import '../../../../Widgets/CenterLoading.dart';
import '../../../../Widgets/Custom_Button.dart';
import '../../../../Widgets/Custom_SnackBar.dart';
import '../../../../Widgets/Custom_TextFormField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class SetNewPasswordForm extends StatefulWidget {
  @override
  State<SetNewPasswordForm> createState() => _SetNewPasswordFormState();
}

class _SetNewPasswordFormState extends State<SetNewPasswordForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cubit = UpdatePasswordCubit.get(context);
    return Form(
      key: _formKey,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: AnimatedWidgets(
          verticalOffset: 150,
          child: Column(
            children: [
              SizedBox(height: 25),
              _PasswordTextField(),
              _ConfirmPasswordTextField(),
              SizedBox(height: 25),

              /// set button bloc consumer ==============
              BlocConsumer<UpdatePasswordCubit, UpdatePasswordState>(
                listener: (_, state) {
                  if (state is UpdatePasswordErrorState) {
                    customSnackBar(_, state.error);
                  } else if (state is UpdatePasswordSuccessState) {
                    showCupertinoDialog(
                        context: context,
                        builder: (_) {
                          return UpdatedSuccessfullyDialog();
                        });
                    print(
                        "============================= تم تغيير كلمة المرور بنجاح =========================");
                  }
                },
                builder: (context, state) {
                  return state is UpdatePasswordLoadingState
                      ? CenterLoading()
                      : CustomButton(
                          text: "set".tr(),
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              cubit.userUpdatePassword();
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

class _PasswordTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = UpdatePasswordCubit.get(context);
    return CustomTextField(
      verticalPadding: 5,
      secureText: true,
      label: "password".tr(),
      inputType: TextInputType.text,
      validate: (value) {
        if (value!.isEmpty) {
          return "enter_password".tr();
        } else if (value.length < 8) {
          return "password_must_be_eight_characters".tr();
        }
        return null;
      },
      onChanged: (value) {
        cubit.password = "$value";
      },
    );
  }
}

class _ConfirmPasswordTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = UpdatePasswordCubit.get(context);
    return CustomTextField(
      verticalPadding: 5,
      secureText: true,
      label: "confirm_password".tr(),
      inputType: TextInputType.text,
      validate: (value) {
        if (value!.isEmpty) {
          return "enter_confirm_password".tr();
        } else if (value != cubit.password) {
          return "password_does_not_match".tr();
        }
        return null;
      },
      onChanged: (value) {
        cubit.confirmPassword = "$value";
      },
    );
  }
}
