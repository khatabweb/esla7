import '../../../../../Widgets/CenterLoading.dart';
import '../../../../../Widgets/Custom_SnackBar.dart';
import '../../../../../../Theme/color.dart';
import '../component/success_dialog.dart';
import '../../../../../Widgets/Custom_Button.dart';
import '../../../../../Widgets/Custom_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import 'data/bloc/cubit.dart';
import 'data/bloc/state.dart';

class RateProviderDialog extends StatelessWidget {
  final int? ownerId;
  const RateProviderDialog({Key? key, this.ownerId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = RateCubit.get(context);
    cubit.ownerId = ownerId;
    print("owner id ::::::::::::: ${cubit.ownerId}");
    return CustomDialog(
      title: "rate_the_provider".tr(),
      contact: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          RatingBar.builder(
            initialRating: 0,
            itemSize: 32,
            minRating: 0,
            direction: Axis.horizontal,
            allowHalfRating: false,
            ignoreGestures: false,
            unratedColor: Colors.grey[300],
            itemCount: 5,
            itemPadding:
            EdgeInsets.symmetric(horizontal: 2),
            itemBuilder: (context, _) {
              return Image.asset("assets/icons/star.png", color: ThemeColor.mainGold);
            },
            onRatingUpdate: (rating) {
              cubit.rate = rating.toInt();
              print(cubit.rate);
            },
          ),
          SizedBox(height: 10),

          BlocConsumer<RateCubit, RateState>(
            listener: (_, state){
              if(state is RateErrorState){
                customSnackBar(_, state.error);
              }else if(state is RateSuccessState){
                Navigator.pop(context);
                showCupertinoDialog(context: context, builder: (_) => SuccessDialog());
                print("============= rate successfully ==============");
              }
            },
            builder: (context, state) {
              return state is RateLoadingState
                  ? CenterLoading()
                  : _ConfirmButtons(onTapSend: cubit.rateOwner);
            },
          ),
        ],
      ),
    );
  }
}



class _ConfirmButtons extends StatelessWidget {
  final VoidCallback? onTapSend;
  const _ConfirmButtons({Key? key, this.onTapSend}) : super(key: key);

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
            text: "send".tr(),
            onTap: onTapSend,
          ),

          CustomButton(
            width: MediaQuery.of(context).size.width / 3,
            height: 40,
            rightPadding: 5,
            leftPadding: 5,
            text: "cancel".tr(),
            isFrame: true,
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}