import 'package:esla7/Screens/User/Profile/EditProfile/bloc/cubit.dart';
import 'package:esla7/Screens/User/Profile/EditProfile/bloc/state.dart';
import 'package:esla7/Screens/User/Profile/ProfileView/profile_view.dart';
import 'package:esla7/Screens/Widgets/CenterLoading.dart';
import 'package:esla7/Screens/Widgets/Custom_Button.dart';
import 'package:esla7/Screens/Widgets/Custom_SnackBar.dart';
import 'package:esla7/Screens/Widgets/Custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class SaveDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: "sure_to_edit_data".tr(),
      contact: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          _ConfirmButtons(),
        ],
      ),
    );
  }
}


class _ConfirmButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = UserUpdateCubit.get(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: BlocConsumer<UserUpdateCubit, UserUpdateState>(
        listener: (_, state){

          if(state is UserUpdateErrorState){
            customSnackBar(_, state.error);
          }else if(state is UserUpdateSuccessState){
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => Profile()), (route) => false);
            print("============================= تم تعديل البيانات بنجااح =========================");
          }

        },

        builder: (context, state) {
          return state is UserUpdateLoadingState
              ? CenterLoading()
              : Row(
                  children: [
                    CustomButton(
                      width: MediaQuery.of(context).size.width / 3,
                      height: 40,
                      rightPadding: 5,
                      leftPadding: 5,
                      text: "save".tr(),
                      onTap: () {
                        cubit.userUpdate();
                      },
                    ),
                    CustomButton(
                      width: MediaQuery.of(context).size.width / 3,
                      height: 40,
                      rightPadding: 5,
                      leftPadding: 5,
                      text: "back".tr(),
                      isFrame: true,
                      onTap: () => Navigator.pop(context),
                    ),
                  ],
                );
        },
      ),
    );
  }
}