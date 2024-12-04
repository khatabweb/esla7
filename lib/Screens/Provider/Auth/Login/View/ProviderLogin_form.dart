import 'package:esla7/Screens/Provider/Auth/Login/bloc/cubit.dart';
import 'package:esla7/Screens/Provider/Auth/Login/bloc/state.dart';
import 'package:esla7/Screens/Widgets/CenterLoading.dart';
import 'package:esla7/Screens/Widgets/Custom_SnackBar.dart';
import 'package:esla7/Theme/color.dart';
import 'package:esla7/Screens/Provider/Auth/ForgetPassword/View/ForgetPassword_page.dart';
import 'package:esla7/Screens/Provider/Auth/SignUp/View/ProviderSignUp_page.dart';
import 'package:esla7/Screens/Provider/ProviderMainPage/main_page.dart';
import 'package:esla7/Screens/Widgets/AnimatedWidgets.dart';
import 'package:esla7/Screens/Widgets/Custom_Button.dart';
import 'package:esla7/Screens/Widgets/Custom_CountryKey.dart';
import 'package:esla7/Screens/Widgets/Custom_DrawText.dart';
import 'package:esla7/Screens/Widgets/Custom_TextFormField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class ProviderLoginForm extends StatefulWidget {
  @override
  State<ProviderLoginForm> createState() => _ProviderLoginFormState();
}

class _ProviderLoginFormState extends State<ProviderLoginForm> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final String language = translator.activeLanguageCode;

  void _checkValidation() {
    final cubit = OwnerLoginCubit.get(context);
    if (formKey.currentState!.validate()) {
      cubit.ownerLogin();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedWidgets(
      verticalOffset: 150,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                _PhoneTextField(),
                _PasswordTextField(),
                _ForgetPasswordButton(),

                BlocConsumer<OwnerLoginCubit, OwnerLoginState>(
                  listener: (_, state) {
                    if (state is OwnerLoginErrorState) {
                      customSnackBar(_, state.error);
                    } else if (state is OwnerLoginSuccessState) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => ProviderMainPage()),
                          (route) => false);
                      print("========== تم تسجيل الدخول كمؤسسة بنجاح ========");
                    }
                  },
                  builder: (context, state) {
                    return state is OwnerLoginLoadingState
                        ? CenterLoading()
                        : _LoginButton(onTap: _checkValidation);
                  },
                ),

                _HaveAccount(),
                // _SkipButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PhoneTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = OwnerLoginCubit.get(context);
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
        cubit.phone = value;
      },
    );
  }
}

class _PasswordTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = OwnerLoginCubit.get(context);
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
        cubit.password = value;
      },
    );
  }
}

class _ForgetPasswordButton extends StatelessWidget {
  final String language = translator.activeLanguageCode;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment:
          language == "ar" ? Alignment.centerLeft : Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => ProviderForgetPasswordPage()));
        },
        child: Text(
          "forget_password".tr(),
          style: TextStyle(
            color: ThemeColor.mainGold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  final VoidCallback? onTap;
  const _LoginButton({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: "log_in".tr(),
      onTap: onTap,
    );
  }
}

class _HaveAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "dont_have_account".tr(),
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => ProviderSignUpPage()));
          },
          child: Text(
            "create_new_account".tr(),
            style: TextStyle(
              color: ThemeColor.mainGold,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}

class _SkipButton extends StatelessWidget {
  final String language = translator.activeLanguageCode;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5, bottom: 10),
      child: InkWell(
        onTap: () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => ProviderMainPage())),
        child: Row(
          mainAxisAlignment: language == "ar"
              ? MainAxisAlignment.start
              : MainAxisAlignment.end,
          children: [
            language == "ar"
                ? skipButton(context)
                : DrawHeaderText(text: "skip".tr()),
            SizedBox(width: 8),
            language == "ar"
                ? DrawHeaderText(text: "skip".tr())
                : skipButton(context),
          ],
        ),
      ),
    );
  }

  Widget skipButton(BuildContext context) {
    return Container(
      height: 25,
      width: 28,
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.3),
          borderRadius: BorderRadius.circular(5)),
      child: Center(
        child: Icon(
          language == "ar"
              ? Icons.arrow_back_rounded
              : Icons.arrow_forward_outlined,
          color: Theme.of(context).primaryColor,
          size: 20,
        ),
      ),
    );
  }
}
