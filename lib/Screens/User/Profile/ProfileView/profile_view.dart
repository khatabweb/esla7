import 'package:esla7/Screens/User/Profile/EditProfile/view/EditProfile.dart';
import 'package:esla7/Screens/User/Profile/ProfileView/data/cubit/profile_cubit.dart';
import 'package:esla7/Screens/User/Profile/ProfileView/profile_items.dart';
import 'package:esla7/Screens/Widgets/CenterLoading.dart';
import 'package:esla7/Screens/Widgets/Custom_AppBar.dart';
import 'package:esla7/Screens/Widgets/Custom_RoundedPhoto.dart';
import 'package:esla7/Screens/Widgets/Custom_ShapeContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final String language = translator.activeLanguageCode;

  @override
  void initState() {
    context.read<ProfileCubit>().getUserProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: language == "ar" ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: customAppBar(
          context: context,
          appBarTitle: "profile".tr(),
          backgroundColor: Theme.of(context).primaryColor,
          otherIconWidget: _EditButton(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EditProfile(
                    profileModel:
                        BlocProvider.of<ProfileCubit>(context).profileModel,
                  ),
                ),
              );
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
                  child: Center(child: BlocBuilder<ProfileCubit, ProfileState>(
                      builder: (context, state) {
                    if (state is ProfileLoading) {
                      return CenterLoading(color: Colors.white);
                    } else if (state is ProfileSuccess) {
                      return CustomRoundedPhoto(
                        image:
                            "http://www.repaairsa.com/${state.profileModel.image}",
                        radius: 70,
                      );
                    } else {
                      return Center(
                        child: Text("data not found"),
                      );
                    }
                  })),
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
