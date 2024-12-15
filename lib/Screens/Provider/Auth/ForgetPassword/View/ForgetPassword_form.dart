import '../../ConfirmCode/View/ConfirmCode_View.dart';
import '../bloc/cubit.dart';
import '../bloc/state.dart';
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

class ProviderForgetPasswordForm extends StatefulWidget {
  @override
  State<ProviderForgetPasswordForm> createState() =>
      _ProviderForgetPasswordFormState();
}

class _ProviderForgetPasswordFormState
    extends State<ProviderForgetPasswordForm> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void _checkValidation() {
    final cubit = OwnerResetCubit.get(context);
    if (formKey.currentState!.validate()) {
      cubit.ownerResetPassword();
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
              SizedBox(height: 20),
              _PhoneTextField(),
              BlocConsumer<OwnerResetCubit, OwnerResetState>(
                listener: (_, state) {
                  if (state is OwnerResetErrorState) {
                    customSnackBar(_, state.error);
                  } else if (state is OwnerResetSuccessState) {
                    showCupertinoDialog(
                        context: context,
                        builder: (_) => ConfirmCodeForm(confirmSignUp: false));
                    print("============= success ================");
                  }
                },
                builder: (context, state) {
                  return state is OwnerResetLoadingState
                      ? CenterLoading()
                      : _SendButton(onTap: _checkValidation);
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
    final cubit = OwnerResetCubit.get(context);
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
