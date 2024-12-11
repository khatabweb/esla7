import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../../../../Theme/color.dart';
import '../../../../CommonScreen/CitiesDropDown/cities_dropdown.dart';
import '../../../../CommonScreen/DrawerPages/Views/TermsAndCondition/TermsAndCondition.dart';
import '../../../../Widgets/AnimatedWidgets.dart';
import '../../../../Widgets/CenterLoading.dart';
import '../../../../Widgets/Custom_Button.dart';
import '../../../../Widgets/Custom_CountryKey.dart';
import '../../../../Widgets/Custom_DrawText.dart';
import '../../../../Widgets/Custom_SnackBar.dart';
import '../../../../Widgets/Custom_TextFormField.dart';
import '../../ConfirmCode/View/ConfirmCode_View.dart';
import '../data/bloc/cubit.dart';
import '../data/bloc/state.dart';
import 'component/ServiceType/service_type.dart';
import 'component/pick_commercial_image.dart';
import 'component/select_address.dart';
import 'component/time_of_work.dart';

class ProviderSignUpForm extends StatefulWidget {
  @override
  State<ProviderSignUpForm> createState() => _ProviderSignUpFormState();
}

class _ProviderSignUpFormState extends State<ProviderSignUpForm> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final String language = translator.activeLanguageCode;
  bool termsChecked = false;

  @override
  void initState() {
    termsChecked = false;
    super.initState();
  }

  void _checkValidation() {
    final cubit = OwnerSignUpCubit.get(context);
    if (formKey.currentState!.validate()) {
      cubit.serviceId == null
          ? customSnackBar(context, "service_type_required".tr())
          : cubit.cityId == null
              ? customSnackBar(context, "please_select_your_city".tr())
              : cubit.address == null
                  ? customSnackBar(context, "please_select_your_location".tr())
                  : cubit.image == null
                      ? customSnackBar(
                          context, "image_of_commercial_required".tr())
                      : (cubit.from == null || cubit.to == null)
                          ? customSnackBar(
                              context, "check_the_time_of_work".tr())
                          : cubit.ownerSignUp();
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = OwnerSignUpCubit.get(context);
    return AnimatedWidgets(
      verticalOffset: 150,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _PhoneTextField(),
                _NameTextField(),
                _EmailTextField(),
                ServiceType(),

                ///from component
                _PasswordTextField(),
                _ConfirmPasswordTextField(),
                CitiesDropdown(
                  color: Color(0xFFEEEEEE),
                  horizontalPadding: 0,
                  ownerRegister: true,
                ),
                AddressTextFieldTap(),

                ///from component
                _MinSalaryTextField(),
                _CommercialNumberTextField(),
                CommercialImageTextField(),

                ///from component
                DrawHeaderText(text: "times_of_work".tr()),
                TimeOfWork(),

                ///from component
                Divider(),
                _BankOwnerNameTextField(),
                _BankNameTextField(),
                _BankAccountNumberTextField(),
                _AcceptTermsCondition(
                  value: termsChecked,
                  onChangeCheckbox: (val) {
                    setState(() {
                      termsChecked = val as bool;
                    });
                  },
                ),
                termsChecked == true
                    ? BlocConsumer<OwnerSignUpCubit, OwnerSignUpState>(
                        listener: (_, state) {
                          if (state is OwnerSignUpErrorState) {
                            customSnackBar(_, state.error);
                          } else if (state is OwnerSignUpSuccessState) {
                            showCupertinoDialog(
                                context: context,
                                builder: (_) =>
                                    ConfirmCodeForm(confirmSignUp: true));
                            cubit.image = null;
                            print(
                                "================ تم التسجيل بنجاح كمؤسسة =============");
                          }
                        },
                        builder: (context, state) {
                          return state is OwnerSignUpLoadingState
                              ? CenterLoading()
                              : _RegisterButton(onTap: _checkValidation);
                        },
                      )
                    : _DisActiveButton(),
                _HaveAccount(),
                SizedBox(height: 5),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Row(
//   mainAxisAlignment: language == "ar"
//       ? MainAxisAlignment.start
//       : MainAxisAlignment.end,
//   children: [
//     language == "ar" ? SizedBox(width: 0) : Container(height: 45, width: 45, color: Colors.transparent),
//     language == "ar" ? _NextButton() : _HaveAccount(),
//     Expanded(child: SizedBox()),
//     language == "ar" ? _HaveAccount() : _NextButton(),
//     language == "ar" ? Container(height: 45, width: 45, color: Colors.transparent) : SizedBox(width: 0),
//   ],
// ),
// SizedBox(height: 15),

class _PhoneTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = OwnerSignUpCubit.get(context);
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
    final cubit = OwnerSignUpCubit.get(context);
    return CustomTextField(
      verticalPadding: 5,
      secureText: false,
      label: "company_name".tr(),
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
    final cubit = OwnerSignUpCubit.get(context);
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
    final cubit = OwnerSignUpCubit.get(context);
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
    final cubit = OwnerSignUpCubit.get(context);
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

class _MinSalaryTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = OwnerSignUpCubit.get(context);
    return CustomTextField(
      verticalPadding: 5,
      secureText: false,
      label: "minimum_cost".tr(),
      hint: "salary_when_service_not_done".tr(),
      suffixIcon: CountryCode(countyCode: "sar".tr()),
      inputType: TextInputType.number,
      validate: (value) {
        if (value!.isEmpty) {
          return "please_enter_min_salary".tr();
        }
        return null;
      },
      onChanged: (value) {
        cubit.minSalary = value;
      },
    );
  }
}

class _CommercialNumberTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = OwnerSignUpCubit.get(context);
    return CustomTextField(
      verticalPadding: 5,
      secureText: false,
      label: "commercial_registration_no".tr(),
      hint: "123456789",
      inputType: TextInputType.number,
      validate: (value) {
        if (value!.isEmpty) {
          return "please_enter_commercial_no".tr();
        }
        return null;
      },
      onChanged: (value) {
        cubit.commercial = value;
      },
    );
  }
}

class _BankOwnerNameTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = OwnerSignUpCubit.get(context);
    return CustomTextField(
      verticalPadding: 5,
      secureText: false,
      label: "bank_account_owner_name".tr(),
      inputType: TextInputType.name,
      validate: (value) {
        if (value!.isEmpty) {
          return "bank_account_owner_name_required".tr();
        }
        return null;
      },
      onChanged: (value) {
        cubit.bankAccountOwner = value;
      },
    );
  }
}

class _BankNameTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = OwnerSignUpCubit.get(context);
    return CustomTextField(
      verticalPadding: 5,
      secureText: false,
      label: "bank_name".tr(),
      hint: "بنك فيصل",
      inputType: TextInputType.name,
      validate: (value) {
        if (value!.isEmpty) {
          return "bank_name_required".tr();
        }
        return null;
      },
      onChanged: (value) {
        cubit.bankName = value;
      },
    );
  }
}

class _BankAccountNumberTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = OwnerSignUpCubit.get(context);
    return CustomTextField(
      verticalPadding: 5,
      secureText: false,
      label: "bank_account_number".tr(),
      hint: "123456789",
      inputType: TextInputType.number,
      validate: (value) {
        if (value!.isEmpty) {
          return "bank_account_num_required".tr();
        }
        return null;
      },
      onChanged: (value) {
        cubit.accountNumber = value;
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

////////////////////////////////////////////////////////////////////////////////
// class _NextButton extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       child: Container(
//         height: 45,
//         width: 45,
//         decoration: BoxDecoration(
//           color: Theme.of(context).primaryColor,
//           borderRadius: BorderRadius.circular(25),
//         ),
//         child: Center(
//           child: Icon(
//             translator.activeLanguageCode == "ar"
//                 ? Icons.arrow_back_rounded
//                 : Icons.arrow_forward_outlined,
//             color: Colors.white,
//             size: 25,
//           ),
//         ),
//       ),
//       onTap: () {
//         showCupertinoDialog(context: context, builder: (_) {
//           return ConfirmCodeForm(
//             // onTapConfirm: () =>
//             //     Navigator.push(context,
//             //         MaterialPageRoute(builder: (_) => CompleteRegisterPage())),
//           );
//         });
//       },
//     );
//   }
// }

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
