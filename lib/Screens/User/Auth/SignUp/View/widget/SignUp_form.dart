import '../../../ConfirmCode/Bloc/cubit.dart';

import '../../../../../../Theme/color.dart';
import '../../../../../CommonScreen/DrawerPages/Views/TermsAndCondition/TermsAndCondition.dart';
import '../../../ConfirmCode/View/ConfirmCode_View.dart';
import '../../Bloc/cubit.dart';
import '../../Bloc/state.dart';
import '../../../../../Widgets/AnimatedWidgets.dart';
import '../../../../../Widgets/CenterLoading.dart';
import '../../../../../Widgets/Custom_Button.dart';
import '../../../../../Widgets/Custom_CountryKey.dart';
import '../../../../../Widgets/Custom_SnackBar.dart';
import '../../../../../Widgets/Custom_TextFormField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class SignUpForm extends StatefulWidget {
  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final String language = translator.activeLanguageCode;
  bool termsChecked = false;

  @override
  void initState() {
    termsChecked = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = SignUpCubit.get(context);
    return AnimatedWidgets(
      verticalOffset: 150,
      child: Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _PhoneTextField(),
                _NameTextField(),
                _EmailTextField(),
                _PasswordTextField(),
                _ConfirmPasswordTextField(),
                _AcceptTermsCondition(
                  value: termsChecked,
                  onChangeCheckbox: (val) {
                    setState(() {
                      termsChecked = val as bool;
                    });
                  },
                ),
                termsChecked
                    ? BlocConsumer<SignUpCubit, SignUpState>(
                        listener: (_, state) {
                          if (state is SignUpErrorState) {
                            customSnackBar(_, state.error);
                          } else if (state is SignUpSuccessState) {
                            ConfirmCodeCubit.get(context).code=cubit.code;
                            print("code : ${cubit.code}");
                            showCupertinoDialog(
                              context: context,
                              builder: (_) {
                                return ConfirmCodeForm(confirmSignUp: true);
                              },
                            );
                          }
                        },
                        builder: (context, state) {
                          if (state is SignUpLoadingState) {
                            return CenterLoading();
                          } else {
                            return _RegisterButton(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  cubit.userSignUp();
                                }
                              },
                            );
                          }
                        },
                      )
                    : _DisActiveButton(),
                _HaveAccount(),
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
    final cubit = SignUpCubit.get(context);
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

class _NameTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = SignUpCubit.get(context);
    return CustomTextField(
      verticalPadding: 5,
      secureText: false,
      label: "name".tr(),
      inputType: TextInputType.name,
      validate: (value) {
        if (value!.isEmpty) {
          return "enter_name".tr();
        }
        return null;
      },
      onChanged: (value) {
        cubit.name = value;
      },
    );
  }
}

class _EmailTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = SignUpCubit.get(context);
    return CustomTextField(
      verticalPadding: 5,
      secureText: false,
      label: "email".tr(),
      inputType: TextInputType.emailAddress,
      validate: (value) {
        if (value!.isEmpty) {
          return "enter_email".tr();
        } else if (value.contains("@") == false) {
          return "incorrect_email".tr();
        }
        return null;
      },
      onChanged: (value) {
        cubit.email = value;
      },
    );
  }
}

class _PasswordTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = SignUpCubit.get(context);
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

class _ConfirmPasswordTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = SignUpCubit.get(context);
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
        cubit.confirmPassword = value;
      },
    );
  }
}

class _AcceptTermsCondition extends StatelessWidget {
  final bool? value;
  final Function(bool?)? onChangeCheckbox;
  const _AcceptTermsCondition({Key? key, this.value, this.onChangeCheckbox})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: onChangeCheckbox,
          activeColor: ThemeColor.mainGold,
          side: BorderSide(
            color: ThemeColor.mainGold,
            width: 1,
          ),
          splashRadius: 25,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        Text(
          "accept_for".tr(),
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        TextButton(
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (_) => TermsAndCondition())),
          child: Text(
            "terms_and_condition".tr(),
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

class _RegisterButton extends StatelessWidget {
  final VoidCallback? onTap;

  const _RegisterButton({Key? key, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: "register".tr(),
      topPadding: 5,
      bottomPadding: 5,
      onTap: onTap,
    );
  }
}

class _DisActiveButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: "register".tr(),
      topPadding: 5,
      bottomPadding: 5,
      textColor: Colors.grey,
      color: Colors.grey.withOpacity(0.5),
      borderColor: Colors.transparent,
      onTap: () {
        customSnackBar(context, "please_agree_terms".tr());
      },
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
          "have_account".tr(),
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            "log_in".tr(),
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
