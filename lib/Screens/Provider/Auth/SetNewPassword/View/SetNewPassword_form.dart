import 'package:esla7/Screens/Provider/Auth/SetNewPassword/bloc/cubit.dart';
import 'package:esla7/Screens/Provider/Auth/SetNewPassword/bloc/state.dart';
import 'package:esla7/Screens/Widgets/AnimatedWidgets.dart';
import 'package:esla7/Screens/Widgets/CenterLoading.dart';
import 'package:esla7/Screens/Widgets/Custom_Button.dart';
import 'package:esla7/Screens/Widgets/Custom_SnackBar.dart';
import 'package:esla7/Screens/Widgets/Custom_TextFormField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../successfully_update_dialog.dart';

class SetProviderNewPasswordForm extends StatefulWidget {
  @override
  State<SetProviderNewPasswordForm> createState() => _SetProviderNewPasswordFormState();
}

class _SetProviderNewPasswordFormState extends State<SetProviderNewPasswordForm> {
  final formKey = GlobalKey<FormState>();
  final String language = translator.activeLanguageCode;

  void _checkValidation() {
    final cubit = OwnerUpdatePassCubit.get(context);
    if(formKey.currentState!.validate()){
      cubit.ownerUpdatePassword();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: AnimatedWidgets(
        verticalOffset: 150,
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(height: 25),
              _PasswordTextField(),
              _ConfirmPasswordTextField(),
              SizedBox(height: 25),

              BlocConsumer<OwnerUpdatePassCubit, OwnerUpdatePassState>(
                listener: (_, state){
                  if(state is OwnerUpdatePassErrorState){
                    customSnackBar(_, state.error);
                  }else if(state is OwnerUpdatePassSuccessState){
                    showCupertinoDialog(context: context, builder: (_) {
                      return SuccessfullyUpdatedDialog();
                    });
                    print("=========== تم تغيير كلمة المرور بنجاح ========");
                  }
                },
                builder: (context, state){
                  return state is OwnerUpdatePassLoadingState
                      ? CenterLoading()
                      : CustomButton(text: "set".tr(), onTap: _checkValidation);
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
    final cubit = OwnerUpdatePassCubit.get(context);
    return CustomTextField(
      verticalPadding: 5,
      secureText: true,
      label: "password".tr(),
      inputType: TextInputType.text,
      validate: (value){
        if(value!.isEmpty) {
          return "enter_password".tr();
        }else if(value.length < 8){
          return "password_must_be_eight_characters".tr();
        }
      },
      onChanged: (value){
        cubit.password = "$value";
      },
    );
  }
}

class _ConfirmPasswordTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = OwnerUpdatePassCubit.get(context);
    return CustomTextField(
      verticalPadding: 5,
      secureText: true,
      label: "confirm_password".tr(),
      inputType: TextInputType.text,
      validate: (value){
        if(value!.isEmpty) {
          return "enter_confirm_password".tr();
        }else if(value != cubit.password){
          return "password_does_not_match".tr();
        }
      },
      onChanged: (value){
        cubit.confirmPassword = "$value";
      },
    );
  }
}

