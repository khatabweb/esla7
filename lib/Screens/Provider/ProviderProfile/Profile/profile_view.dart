import 'data/cubit/owner_profile_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../EditProfile/EditProfile_view.dart';
import 'profile_items.dart';
import '../../../Widgets/CenterLoading.dart';
import '../../../Widgets/Custom_AppBar.dart';
import '../../../Widgets/Custom_RoundedPhoto.dart';
import '../../../Widgets/Custom_ShapeContainer.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class ProviderProfile extends StatefulWidget {
  @override
  _ProviderProfileState createState() => _ProviderProfileState();
}

class _ProviderProfileState extends State<ProviderProfile> {
  final String language = translator.activeLanguageCode;

  @override
  void initState() {
    context.read<OwnerProfileCubit>().getOwnerProfile();

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
          otherIconWidget: _EditButton(),
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
                  child: BlocBuilder<OwnerProfileCubit, OwnerProfileState>(
                      builder: (context, state) {
                    if (state is OwnerProfileLoading) {
                      return CenterLoading(color: Colors.white);
                    } else if (state is OwnerProfileSuccess) {
                      final model = state.ownerProfileModel;
                      return CustomRoundedPhoto(
                        image: "http://www.repaairsa.com/${model.companyImage}",
                        radius: 70,
                      );
                    } else {
                      return Container();
                    }
                  }),
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
  const _EditButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => EditProfileView(
            ownerProfileModel: context.read<OwnerProfileCubit>().profileModel,
          ),
        ),
      ),
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
