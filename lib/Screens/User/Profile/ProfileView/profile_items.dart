import 'data/cubit/profile_cubit.dart';
import '../../../../Theme/color.dart';
import '../../../Widgets/AnimatedWidgets.dart';
import '../../../Widgets/CenterLoading.dart';
import '../../../Widgets/Custom_DrawText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import 'data/model/profile_model.dart';

class ProfileItems extends StatelessWidget {
  ProfileItems({super.key});

  final String language = translator.activeLanguageCode;

  @override
  Widget build(BuildContext context) {
    final ProfileModel profileModel =
        BlocProvider.of<ProfileCubit>(context).profileModel;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: AnimatedWidgets(
        verticalOffset: 150,
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileSuccess) {
              return Column(
                children: [
                  _NameItem(name: "${profileModel.name}"),
                  _PhoneItem(phone: "${profileModel.phone}"),
                  _EmailItem(email: "${profileModel.email}"),
                  _PasswordItem(),
                ],
              );
            } else if (state is ProfileLoading) {
              return CenterLoading();
            } else if (state is ProfileError) {
              return Center(child: Text(state.error));
            } else {
              return Center(
                child: Text("data not found "),
              );
            }
          },
        ),
      ),
    );
  }
}

class _NameItem extends StatelessWidget {
  final String name;
  const _NameItem({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _SingleItem(
      title: "name".tr(),
      subTitle: name,
      icon: "assets/icons/user.png",
    );
  }
}

class _PhoneItem extends StatelessWidget {
  final String phone;
  const _PhoneItem({Key? key, required this.phone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _SingleItem(
      title: "phone_number".tr(),
      subTitle: phone,
      subTitleDirection: TextDirection.ltr,
      icon: "assets/icons/phone.png",
    );
  }
}

class _EmailItem extends StatelessWidget {
  final String email;
  const _EmailItem({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _SingleItem(
      title: "email".tr(),
      subTitle: email,
      icon: "assets/icons/email.png",
    );
  }
}

class _PasswordItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _SingleItem(
      title: "password".tr(),
      subTitle: "********",
      icon: "assets/icons/lock.png",
    );
  }
}

// class _Addresses extends StatelessWidget {
//   List<String> addresses = ["العمل", "المنزل"];
//   @override
//   Widget build(BuildContext context) {
//     double listHeight = addresses.length.toDouble();
//     return Container(
//       height: MediaQuery.of(context).size.width / 6 * listHeight,
//       child: ListView.builder(
//         physics: NeverScrollableScrollPhysics(),
//         itemCount: addresses.length,
//         itemBuilder: (context, item) {
//           return _SingleItem(
//             title: "address_name".tr(),
//             subTitle: addresses[item],
//             icon: "assets/icons/locationblue.png",
//             showEditIcon: true,
//             onTapEdit: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AddAddressView())),
//             deleteIcon: InkWell(
//               onTap: () {
//                 showCupertinoDialog(
//                     context: context,
//                     builder: (_) {
//                       return RemoveAlert();
//                     });
//               },
//               child: Image.asset(
//                 "assets/icons/delete.png",
//                 height: 20,
//                 width: 20,
//                 fit: BoxFit.contain,
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//
// class _AddAddressButton extends StatelessWidget {
//   const _AddAddressButton({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return CustomButton(
//       width: MediaQuery.of(context).size.width / 2.5,
//       height: 40,
//       rightPadding: 5,
//       leftPadding: 5,
//       fontSize: 14,
//       text: "add_new_address".tr(),
//       isFrame: true,
//       onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AddAddressView())),
//     );
//   }
// }

class _SingleItem extends StatelessWidget {
  final String? icon, title, subTitle;
  final TextDirection? subTitleDirection;

  const _SingleItem({
    this.icon,
    this.title,
    this.subTitle,
    this.subTitleDirection,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedWidgets(
        verticalOffset: 50,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
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
