import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../../Widgets/CenterLoading.dart';
import '../../../Widgets/Custom_AppBar.dart';
import '../../../Widgets/Custom_RoundedPhoto.dart';
import '../../../Widgets/Custom_ShapeContainer.dart';
import '../EditProfile/view/EditProfile.dart';
import 'data/cubit/profile_cubit.dart';
import 'profile_items.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    context.read<ProfileCubit>().getUserProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
