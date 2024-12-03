import 'package:esla7/Screens/User/Profile/EditProfile/view/EditProfile.dart';
import 'package:esla7/Screens/User/Profile/ProfileView/profile_items.dart';
import 'package:esla7/Screens/Widgets/CenterLoading.dart';
import 'package:esla7/Screens/Widgets/Custom_AppBar.dart';
import 'package:esla7/Screens/Widgets/Custom_RoundedPhoto.dart';
import 'package:esla7/Screens/Widgets/Custom_ShapeContainer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:esla7/Screens/User/Profile/ProfileView/API/profile_controller.dart';
import 'package:esla7/Screens/User/Profile/ProfileView/API/profile_model.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
  void initState() {
    _getProfile();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: language == "ar" ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: customAppBar(
          context: context,
          appBarTitle: "profile".tr(),
          backgroundColor: Theme.of(context).primaryColor,
          otherIconWidget: _EditButton(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (_) => EditProfile(profileModel: _profileModel,)));
            },
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        body: Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Container(
                  child: Center(
                    child: _isLoading
                        ? CenterLoading(color: Colors.white)
                        : CustomRoundedPhoto(
                            image: "http://www.repaairsa.com/${_profileModel.image}",
                            radius: 70,
                          ),
                  ),
                ),
              ),
              ShapeContainer(
                height: MediaQuery.of(context).size.height / 1.8,
                child: ProfileItems(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class _EditButton extends StatelessWidget {
  final VoidCallback? onTap;
  const _EditButton({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
        child: Center(
            child: Image.asset("assets/icons/editwhite.png",
                height: 25, width: 25, fit: BoxFit.contain)),
      ),
    );
  }
}
