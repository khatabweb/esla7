import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
// import '../../../../Theme/color.dart';
import '../../../Widgets/AnimatedWidgets.dart';
import '../../../Widgets/CenterLoading.dart';
import '../../../Widgets/Custom_Button.dart';
import '../../../Widgets/Custom_DrawText.dart';
import '../../../Widgets/Custom_SnackBar.dart';
import '../../../Widgets/Custom_TextFieldTap.dart';
import '../../../Widgets/Custom_popover.dart';
import '../ads_packages_data/cubit/ads_packages_cubit.dart';
import 'Ads_Subscripe_bloc/cubit.dart';
import 'Ads_Subscripe_bloc/state.dart';
import 'ads_subscrib_dialog.dart';

class CreateAdsForm extends StatelessWidget {
  const CreateAdsForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedWidgets(
      duration: 1,
      horizontalOffset: 50,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).primaryColor.withOpacity(0.2),
        ),
        child: Column(
          children: [
            // AdsStartDate(),
            _DurationPopOver(),
            // _TotalPrice(),
            _SubscribeButton(),
          ],
        ),
      ),
    );
  }
}

class AdsStartDate extends StatefulWidget {
  const AdsStartDate({Key? key}) : super(key: key);

  @override
  _AdsStartDateState createState() => _AdsStartDateState();
}

class _AdsStartDateState extends State<AdsStartDate> {
  DateTime? _pickedDate;

  @override
  void initState() {
    _pickedDate = DateTime.now();
    super.initState();
  }

  Future _pickDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: _pickedDate!,
      firstDate: DateTime(DateTime.now().day),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (date != null) {
      setState(() {
        _pickedDate = date;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextFieldTap(
      height: 45,
      color: Colors.white, //Color(0xFFEEEEEE),
      label:
          "${_pickedDate!.day} / ${_pickedDate!.month} / ${_pickedDate!.year}",
      icon: SizedBox(),
      onTap: _pickDate,
    );
  }
}

class _DurationPopOver extends StatefulWidget {
  @override
  State<_DurationPopOver> createState() => _DurationPopOverState();
}

class _DurationPopOverState extends State<_DurationPopOver> {
  String? valueChoose;

  @override
  void initState() {
    context.read<AdsPackagesCubit>().getAdsPackages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final cubit = AdsSubscribeCubit.get(context);
    return BlocBuilder<AdsPackagesCubit, AdsPackagesState>(
      builder: (builder, state) {
        if (state is AdsPackagesLoading) {
          return CenterLoading();
        } else if (state is AdsPackagesError) {
          return Center(child: Text(state.error));
        } else if (state is AdsPackagesSuccess) {
          final packagesModel = state.adsPackagesModel;
          return CustomPopOver(
            text: valueChoose ?? "duration".tr(),
            color: Colors.white,
            width: width,
            dropWidth: width / 1.1,
            dropHeight: packagesModel.packages?.length == 0
                ? 50
                : (packagesModel.packages?.length as num) * 50,
            itemList: packagesModel.packages?.map((item) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      valueChoose = "${item?.period}";
                    });
                    cubit.packageId = item?.id;
                    print("package ID ::::::: ${cubit.packageId}");
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DrawHeaderText(
                        textAlign: TextAlign.center,
                        text: "${item?.period}",
                      ),
                      DrawHeaderText(
                        textAlign: TextAlign.center,
                        text: "${item?.price} ${"sar".tr()}",
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        } else {
          return Text("No Data Found");
        }
      },
    );
  }
}

// class _TotalPrice extends StatelessWidget {
//   final String? price;
//   const _TotalPrice({Key? key, this.price}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 30,
//       margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//       width: MediaQuery.of(context).size.width,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           DrawHeaderText(
//               text: "total".tr(), color: ThemeColor.mainGold, fontSize: 14),
//           DrawHeaderText(
//               text: "$price ${"sar".tr()}",
//               color: ThemeColor.mainGold,
//               fontSize: 15),
//         ],
//       ),
//     );
//   }
// }

class _SubscribeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = AdsSubscribeCubit.get(context);
    return BlocConsumer<AdsSubscribeCubit, AdsSubscribeState>(
      listener: (_, state) {
        if (state is AdsSubscribeErrorState) {
          customSnackBar(_, state.error);
        } else if (state is AdsSubscribeSuccessState) {
          Navigator.pop(context);
          showCupertinoDialog(
              context: context, builder: (context) => AdsSubscriptionDialog());
          print("========== تم الإشتراك بنجاح ========");
        }
      },
      builder: (context, state) {
        return state is AdsSubscribeLoadingState
            ? CenterLoading()
            : CustomButton(
                text: "subscribe".tr(),
                topPadding: 5,
                bottomPadding: 5,
                onTap: () {
                  cubit.packageId == null
                      ? customSnackBar(context, "please_select_package".tr())
                      : cubit.subscribe();
                },
              );
      },
    );
  }
}
