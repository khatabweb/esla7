import 'package:esla7/Theme/color.dart';
import 'package:esla7/Screens/Widgets/AnimatedWidgets.dart';
import 'package:esla7/Screens/Widgets/CenterLoading.dart';
import 'package:esla7/Screens/Widgets/Custom_DrawText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:esla7/Screens/User/Profile/ProfileView/API/profile_controller.dart';
import 'package:esla7/Screens/User/Profile/ProfileView/API/profile_model.dart';

class ProfileItems extends StatefulWidget {
  @override
  State<ProfileItems> createState() => _ProfileItemsState();
}

class _ProfileItemsState extends State<ProfileItems> {
  final String language = translator.activeLanguageCode;
  ProfileController _profileController = ProfileController();
  ProfileModel _profileModel = ProfileModel();
  bool _isLoading = true;

  void _getProfile() async {
    _profileModel = await _profileController.getUserProfile();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState () {
    _getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: AnimatedWidgets(
        verticalOffset: 150,
        child: _isLoading
            ? CenterLoading()
            : Column(
                children: [
                  _NameItem(name: "${_profileModel.name}"),
                  _PhoneItem(phone: "${_profileModel.phone}"),
                  _EmailItem(email: "${_profileModel.email}"),
                  _PasswordItem(),
                ],
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
                DrawHeaderText(text: title ?? "", color: ThemeColor.mainGold, fontSize: 14),
                DrawSingleText(text: subTitle ?? "", fontSize: 12,textDirection: subTitleDirection),
              ],
            ),
          ],
        ),
      )
    );
  }
}
