import 'data/cubit/owner_profile_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Widgets/CenterLoading.dart';
import '../../../../Theme/color.dart';
import '../../../Widgets/AnimatedWidgets.dart';
import '../../../Widgets/Custom_DrawText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class ProviderProfileItems extends StatefulWidget {
  @override
  State<ProviderProfileItems> createState() => _ProviderProfileItemsState();
}

class _ProviderProfileItemsState extends State<ProviderProfileItems> {
  @override
  void initState() {
    context.read<OwnerProfileCubit>().getOwnerProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: AnimatedWidgets(
        verticalOffset: 150,
        child: BlocBuilder<OwnerProfileCubit, OwnerProfileState>(
          builder: (context, state) {
            if (state is OwnerProfileLoading) {
              return CenterLoading();
            } else if (state is OwnerProfileSuccess) {
              final profileModel = state.ownerProfileModel;
              return Column(
                children: [
                  _CompanyName(name: profileModel.companyName),
                  _PhoneNumber(phone: profileModel.companyPhone),
                  _Email(email: profileModel.companyEmail),
                  _Password(),
                  _ServiceType(
                    service: context.locale.languageCode == "ar"
                        ? profileModel.serviceNameAr
                        : profileModel.serviceNameEn,
                  ),
                  _MinimumCost(minSalary: profileModel.companyMinSalary),
                  _CommercialRegistrationNo(
                      commercialNo: profileModel.companyCommerical),
                  // _CommercialRegistrationImage(),
                  _TimeOfWork(from: profileModel.from, to: profileModel.to),
                  Divider(
                      color: Theme.of(context).colorScheme.secondary,
                      thickness: 0.5),
                  _BankAccountOwnerName(
                      bankAccountOwner: profileModel.bankAccountOwner),
                  _BankName(bankName: profileModel.bankName),
                  _BankAccountNumber(accountNum: profileModel.accountNumber),
                  SizedBox(height: 20),
                ],
              );
            } else if (state is OwnerProfileError) {
              return Center(
                child: Text(
                  state.message,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                  ),
                ),
              );
            } else {
              return Center(
                child: Text(
                  "not found data",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class _CompanyName extends StatelessWidget {
  final String? name;
  const _CompanyName({Key? key, this.name}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return _SingleItem(
      title: "company_name".tr(),
      subTitle: "$name",
      icon: "assets/icons/user.png",
    );
  }
}

class _PhoneNumber extends StatelessWidget {
  final String? phone;
  const _PhoneNumber({Key? key, this.phone}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return _SingleItem(
      title: "phone_number".tr(),
      subTitle: "$phone",
      subTitleDirection: TextDirection.ltr,
      icon: "assets/icons/phone.png",
    );
  }
}

class _Email extends StatelessWidget {
  final String? email;
  const _Email({Key? key, this.email}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return _SingleItem(
      title: "email".tr(),
      subTitle: "$email",
      icon: "assets/icons/email.png",
    );
  }
}

class _Password extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _SingleItem(
      title: "password".tr(),
      subTitle: "********",
      icon: "assets/icons/lock.png",
    );
  }
}

class _ServiceType extends StatelessWidget {
  final String? service;
  const _ServiceType({Key? key, this.service}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return _SingleItem(
      title: "service_type".tr(),
      subTitle: "$service",
      icon: "assets/icons/elevator.png",
    );
  }
}

class _MinimumCost extends StatelessWidget {
  final String? minSalary;
  const _MinimumCost({Key? key, this.minSalary}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return _SingleItem(
      title: "minimum_cost".tr(),
      subTitle: "$minSalary ${"sar".tr()}",
      icon: "assets/icons/money.png",
    );
  }
}

class _CommercialRegistrationNo extends StatelessWidget {
  final String? commercialNo;
  const _CommercialRegistrationNo({Key? key, this.commercialNo})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return _SingleItem(
      title: "commercial_registration_no".tr(),
      subTitle: "$commercialNo",
      icon: "assets/icons/code.png",
    );
  }
}

// class _CommercialRegistrationImage extends StatelessWidget {
//   final String? commercialPhoto;
//   const _CommercialRegistrationImage({Key? key, this.commercialPhoto})
//       : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return _SingleItem(
//       title: "commercial_registration_image".tr(),
//       subTitle: "$commercialPhoto",
//       icon: "assets/icons/image.png",
//     );
//   }
// }

class _TimeOfWork extends StatelessWidget {
  final String? from, to;
  const _TimeOfWork({
    Key? key,
    this.from,
    this.to,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return _SingleItem(
      title: "times_of_work".tr(),
      subTitle: "${"from".tr()} $from ${"to".tr()} $to",
      icon: "assets/icons/time.png",
    );
  }
}

class _BankAccountOwnerName extends StatelessWidget {
  final String? bankAccountOwner;
  const _BankAccountOwnerName({Key? key, this.bankAccountOwner})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return _SingleItem(
      title: "bank_account_owner_name".tr(),
      subTitle: "$bankAccountOwner",
      icon: "assets/icons/user.png",
    );
  }
}

class _BankName extends StatelessWidget {
  final String? bankName;
  const _BankName({Key? key, this.bankName}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return _SingleItem(
      title: "bank_name".tr(),
      subTitle: "$bankName",
      icon: "assets/icons/bank.png",
    );
  }
}

class _BankAccountNumber extends StatelessWidget {
  final String? accountNum;
  const _BankAccountNumber({Key? key, this.accountNum}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return _SingleItem(
      title: "bank_account_number".tr(),
      subTitle: "$accountNum",
      icon: "assets/icons/code.png",
    );
  }
}

class _SingleItem extends StatelessWidget {
  final String? icon, title, subTitle;
  final TextDirection? subTitleDirection;
  // final Widget? deleteIcon;

  const _SingleItem({
    this.icon,
    this.title,
    this.subTitle,
    this.subTitleDirection,
    // this.deleteIcon,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedWidgets(
        verticalOffset: 50,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(icon!, height: 20, width: 20, fit: BoxFit.contain),
              SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DrawHeaderText(
                      text: title ?? "",
                      color: ThemeColor.mainGold,
                      fontSize: 14),
                  DrawSingleText(
                      text: subTitle ?? "",
                      fontSize: 12,
                      textDirection: subTitleDirection),
                ],
              ),
            ],
          ),
        ));
  }
}
