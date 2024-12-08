import '../../../Widgets/CenterLoading.dart';
import '../../../Widgets/Custom_Button.dart';
import '../../../Widgets/Custom_SnackBar.dart';
import '../../../Widgets/Custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import 'delete_bloc/cubit.dart';
import 'delete_bloc/state.dart';

class DeleteServiceAlert extends StatelessWidget {
  final int? endServiceId;
  const DeleteServiceAlert({Key? key, this.endServiceId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = DeleteServiceCubit.get(context);
    return CustomDialog(
      title: "service_will_be_removed".tr(),
      contact: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          BlocConsumer<DeleteServiceCubit, DeleteServiceState>(
            listener: (_, state){
              if(state is DeleteServiceErrorState){
                customSnackBar(_, state.error);
              }else if(state is DeleteServiceSuccessState){
                Navigator.pop(context);
                print("========== تم المسح بنجاح ========");
              }
            },
            builder: (context, state){
              return state is DeleteServiceLoadingState
                  ? CenterLoading()
                  : _ConfirmButtons(onTapDelete: () => cubit.deleteService(endServiceId));
            },
          ),
        ],
      ),
    );
  }
}


class _ConfirmButtons extends StatelessWidget {
  final VoidCallback? onTapDelete;
  const _ConfirmButtons({Key? key, this.onTapDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          CustomButton(
            width: MediaQuery.of(context).size.width / 3,
            height: 40,
            rightPadding: 5,
            leftPadding: 5,
            text: "remove".tr(),
            onTap: onTapDelete,
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
      ),
    );
  }
}