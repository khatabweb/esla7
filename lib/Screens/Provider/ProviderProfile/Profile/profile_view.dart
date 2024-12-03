import 'package:esla7/Screens/Provider/ProviderProfile/EditProfile/EditProfile_view.dart';
import 'package:esla7/Screens/Provider/ProviderProfile/Profile/profile_items.dart';
import 'package:esla7/Screens/Widgets/CenterLoading.dart';
import 'package:esla7/Screens/Widgets/Custom_AppBar.dart';
import 'package:esla7/Screens/Widgets/Custom_RoundedPhoto.dart';
import 'package:esla7/Screens/Widgets/Custom_ShapeContainer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import 'Api/controller.dart';
import 'Api/model.dart';

class ProviderProfile extends StatefulWidget {
  @override
  _ProviderProfileState createState() => _ProviderProfileState();
}

class _ProviderProfileState extends State<ProviderProfile> {
  final String language = translator.activeLanguageCode;
  OwnerProfileModel profileModel = OwnerProfileModel();
  OwnerProfileController profileController = OwnerProfileController();
  bool isLoading = true;

  void getOwnerProfile() async {
    profileModel = await profileController.getOwnerProfile();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getOwnerProfile();
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
          otherIconWidget: _EditButton(profileModel: profileModel),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        body: Align(
          alignment: Alignment.bottomCenter,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: isLoading
                      ? CenterLoading(color: Colors.white)
                      : CustomRoundedPhoto(
                          image: "http://www.repaairsa.com/${profileModel.companyImage}",
                          radius: 70,
                        ),
                ),
                ShapeContainer(
                  height: MediaQuery.of(context).size.height / 1.5,
                  child: ProviderProfileItems(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class _EditButton extends StatelessWidget {
  final OwnerProfileModel profileModel;
  const _EditButton({Key? key, required this.profileModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => EditProfileView(ownerProfileModel: profileModel))),
      child: Container(
        height: 40,
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
        child: Center(child: Image.asset("assets/icons/editwhite.png", height: 25, width: 25, fit: BoxFit.contain)),
      ),
    );
  }
}
