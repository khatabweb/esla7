import 'package:esla7/Screens/Provider/Create_Ad/ads_packages_apis/controller.dart';
import 'package:esla7/Screens/Provider/Create_Ad/ads_packages_apis/model.dart';
import 'package:esla7/Screens/Widgets/CenterLoading.dart';
import 'package:esla7/Screens/Widgets/Custom_SnackBar.dart';
import 'package:esla7/Theme/color.dart';
import 'package:esla7/Screens/Widgets/AnimatedWidgets.dart';
import 'package:esla7/Screens/Widgets/Custom_Button.dart';
import 'package:esla7/Screens/Widgets/Custom_DrawText.dart';
import 'package:esla7/Screens/Widgets/Custom_TextFieldTap.dart';
import 'package:esla7/Screens/Widgets/Custom_popover.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

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
      label: "${_pickedDate!.day} / ${_pickedDate!.month} / ${_pickedDate!.year}",
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
  bool isLoading = true;
  String? valueChoose;
  AdsPackagesModel packagesModel = AdsPackagesModel();
  AdsPackagesController packagesController = AdsPackagesController();

  void getPackages() async {
    packagesModel = await packagesController.getPackages();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getPackages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final cubit = AdsSubscribeCubit.get(context);
    return isLoading
        ? CenterLoading()
        : CustomPopOver(
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
  }
}


class _TotalPrice extends StatelessWidget {
  final String? price;
  const _TotalPrice({Key? key, this.price}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      margin: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DrawHeaderText(text: "total".tr(), color: ThemeColor.mainGold, fontSize: 14),
          DrawHeaderText(text: "$price ${"sar".tr()}", color: ThemeColor.mainGold, fontSize: 15),
        ],
      ),
    );
  }
}


class _SubscribeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = AdsSubscribeCubit.get(context);
    return BlocConsumer<AdsSubscribeCubit, AdsSubscribeState>(
      listener: (_, state){
        if(state is AdsSubscribeErrorState){
          customSnackBar(_, state.error);
        }else if(state is AdsSubscribeSuccessState){
          Navigator.pop(context);
          showCupertinoDialog(context: context, builder: (context) => AdsSubscriptionDialog());
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