import '../../../../../core/local_storge/cache_helper.dart';
import '../../../../../core/Theme/color.dart';
import '../../ForgetPassword/View/ForgetPassword_page.dart';
import '../Bloc/cubit.dart';
import '../Bloc/state.dart';
import '../../SignUp/View/screen/SignUp_page.dart';
import '../../../MainPage/main_page.dart';
import '../../../../Widgets/AnimatedWidgets.dart';
import '../../../../Widgets/CenterLoading.dart';
import '../../../../Widgets/Custom_Button.dart';
import '../../../../Widgets/Custom_CountryKey.dart';
import '../../../../Widgets/Custom_DrawText.dart';
import '../../../../Widgets/Custom_SnackBar.dart';
import '../../../../Widgets/Custom_TextFormField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cubit = LoginCubit.get(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: AnimatedWidgets(
        verticalOffset: 150,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _PhoneTextField(),
              _PasswordTextField(),
              _ForgetPasswordButton(),

              ///login button bloc
              BlocConsumer<LoginCubit, LoginState>(
                listener: (_, state) {
                  if (state is LoginErrorState) {
                    customSnackBar(_, state.error);
                  } else if (state is LoginSuccessState) {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => MainPage()));
                    print(
                        "============================= تم تسجيل الدخول بنجاح =========================");
                  }
                },
                builder: (context, state) {
                  return state is LoginLoadingState
                      ? CenterLoading()
                      : _LoginButton(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              cubit.userLogin();
                            }
                          },
                        );
                },
              ),

              _HaveAccount(),
              _SkipButton(),
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
    final cubit = LoginCubit.get(context);
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
    final cubit = LoginCubit.get(context);
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
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: context.locale.languageCode == "ar"
          ? Alignment.centerLeft
          : Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => ForgetPasswordPage()));
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
      //     () {
      //   Navigator.push(context, MaterialPageRoute(builder: (_) => MainPage()));
      // },
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
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => SignUpPage()));
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
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5, bottom: 10),
      child: InkWell(
        onTap: () {
          CacheHelper.instance!.setData("skip", value: true);
          print(
              "skip case :::::::::::: ${CacheHelper.instance!.getData(key: "skip", valueType: ValueType.bool)}");
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => MainPage()));
        },
        child: Row(
          mainAxisAlignment: context.locale.languageCode == "ar"
              ? MainAxisAlignment.start
              : MainAxisAlignment.end,
          children: [
            context.locale.languageCode == "ar"
                ? skipButton(context)
                : DrawHeaderText(text: "skip".tr()),
            SizedBox(width: 8),
            context.locale.languageCode == "ar"
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
          context.locale.languageCode == "ar"
              ? Icons.arrow_back_rounded
              : Icons.arrow_forward_outlined,
          color: Theme.of(context).primaryColor,
          size: 20,
        ),
      ),
    );
  }
}
