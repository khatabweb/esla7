import 'dart:async';
import 'package:esla7/API/api_utility.dart';
import 'package:esla7/Screens/User/ProviderProfile/SubService/SubService.dart';
import 'package:esla7/Screens/Widgets/CenterLoading.dart';
import 'package:esla7/Screens/Widgets/login_dialog/custom_login_dialog.dart';
import 'package:esla7/Theme/color.dart';
import 'package:esla7/Screens/Widgets/AnimatedWidgets.dart';
import 'package:esla7/Screens/Widgets/Custom_AppBar.dart';
import 'package:esla7/Screens/Widgets/Custom_Background.dart';
import 'package:esla7/Screens/Widgets/Custom_Button.dart';
import 'package:esla7/Screens/Widgets/Custom_DrawText.dart';
import 'package:esla7/Screens/Widgets/Custom_RoundedPhoto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Bloc/cubit.dart';
import 'api/model.dart';

class ProviderProfile extends StatefulWidget {
  final int? mainServiceId;
  final bool? isGolden;
  final int? ownerId;

  ProviderProfile({this.isGolden, this.ownerId, this.mainServiceId});

  @override
  State<ProviderProfile> createState() => _ProviderProfileState();
}

class _ProviderProfileState extends State<ProviderProfile> {
  final String language = translator.activeLanguageCode;
  TimeOfDay? time;
  OwnerDetailsModel ownerDetailsModel = OwnerDetailsModel();
  bool isLoading = true;


  Future ownerData() async {
    print("in Service ..........................");
    final cubit = OwnerDetailsCubit.get(context);
    cubit.ownerId = widget.ownerId;
    print("idddddddddddddddddddddd ::::::::::::::::::::::: ${cubit.ownerId}");
    return cubit.ownerDetails();
  }

  @override
  void initState() {
    ownerData().then((value){
      setState(() {
        isLoading = false;
      });
    });
    time = TimeOfDay.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = OwnerDetailsCubit.get(context);
    return Directionality(
      textDirection: language == "ar" ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: customAppBar(
          context: context,
          appBarTitle: "",
          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.5),
        ),
        body: CustomBackground(
          child: isLoading
              ? CenterLoading()
              : AnimatedWidgets(
                  verticalOffset: 150,
                  child: Column(
                    children: [
                      SizedBox(height: 25),
                      _InformationCard(
                        isGolden: widget.isGolden,
                        time: time,
                        image: "${ApiUtl.main_image_url}${cubit.ownerDetailsModel.ownerImage}",
                        ownerName: "${cubit.ownerDetailsModel.ownerName}",
                        rate: cubit.ownerDetailsModel.rate,
                        serviceName: language == "ar"
                            ? "${cubit.ownerDetailsModel.ownerService?.nameAr}"
                            : "${cubit.ownerDetailsModel.ownerService?.nameEn}",
                        city: language == "ar"
                            ? "${cubit.ownerDetailsModel.ownerCity?.nameAr}"
                            : "${cubit.ownerDetailsModel.ownerCity?.nameEn}",
                        minSalary: "${cubit.ownerDetailsModel.minSalary}",
                        from: "${cubit.ownerDetailsModel.avilableFrom}",
                        to: "${cubit.ownerDetailsModel.avilableTo}",
                      ),
                      Expanded(child: Container()),
                      _AddServiceButton(ownerId: cubit.ownerDetailsModel.ownerId),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}


class _InformationCard extends StatelessWidget {
  final bool? isGolden;
  final String? image;
  final String? ownerName;
  final int? rate;
  final String? serviceName;
  final String? city;
  final String? minSalary;
  final String? from, to;
  final TimeOfDay? time;

  _InformationCard({
    Key? key,
    this.isGolden,
    this.ownerName,
    this.serviceName,
    this.city,
    this.minSalary,
    this.from,
    this.to,
    this.image,
    this.rate,
    this.time,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    final cubit = OwnerDetailsCubit.get(context);
    return Container(
      height: MediaQuery.of(context).size.height / 1.8,
      width: MediaQuery.of(context).size.width,
      color: Colors.transparent,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height / 2.2,
              margin: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, -1),
                    color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                    spreadRadius: 0.2,
                    blurRadius: 15,
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Stack(
                  children: [
                    CustomRoundedPhoto(
                      image: "$image",
                      borderColor: isGolden == true ? ThemeColor.mainGold : Colors.white,
                    ),
                    Positioned(
                      bottom: 8,
                      right: 16,
                      child:
                      CircleAvatar(
                        radius: 8,
                        backgroundColor: Colors.green,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),

                isGolden == true
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          DrawHeaderText(fontSize: 16, text: "$ownerName", color: ThemeColor.mainGold),
                          SizedBox(width: 5),
                          Image.asset(
                            "assets/icons/premium.png",
                              color: ThemeColor.mainGold,
                              height: 20, width: 20, fit: BoxFit.cover),
                        ],
                      )
                    : DrawHeaderText(
                        fontSize: 16,
                        text: "$ownerName",
                        color: Theme.of(context).primaryColor,
                      ),


                RatingBar.builder(
                  initialRating: rate?.toDouble() ?? 0,
                  itemSize: 22,
                  minRating: 0,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  ignoreGestures: true,
                  unratedColor: Colors.grey[300],
                  itemCount: 5,
                  itemPadding:
                  EdgeInsets.symmetric(horizontal: 1),
                  itemBuilder: (context, _) {
                    return Image.asset("assets/icons/star.png", color: ThemeColor.mainGold);
                  },
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),

                _ProviderInformation(
                  serviceName: serviceName,
                  city: city,
                  minSalary: minSalary,
                  from: from,
                  to: to,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class _ProviderInformation extends StatelessWidget {
  final String? serviceName;
  final String? city;
  final String? minSalary;
  final String? from, to;

  const _ProviderInformation({
    Key? key,
    this.serviceName,
    this.city,
    this.minSalary,
    this.from,
    this.to,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.25,
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CustomListTile(
            image: "assets/icons/elevator.png",
            text: "$serviceName",
          ),
          _CustomListTile(
            image: "assets/icons/location.png",
            text: "$city",
          ),
          _CustomListTile(
            image: "assets/icons/money.png",
            text: "${"minimum".tr()} $minSalary ${"sar".tr()}", // الحد الادنى 5 ريال
          ),
          _CustomListTile(
            image: "assets/icons/time.png",
            text: "${"times_of_work".tr()} ${"from".tr()} $from ${"to".tr()} $to",
          ),
        ],
      ),
    );
  }
}


class _AddServiceButton extends StatelessWidget {
  final int? ownerId;
  const _AddServiceButton({Key? key, this.ownerId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedWidgets(
      verticalOffset: 150,
      child: CustomButton(
        leftPadding: 15,
        rightPadding: 15,
        bottomPadding: 20,
        topPadding: 20,
        text: "add_service".tr(),
        onTap: () async {
          SharedPreferences _pref = await SharedPreferences.getInstance();
          if(_pref.getBool("skip") == true){
            showCupertinoDialog(context: context, builder: (_) => LoginAlert());
          }else{
            Navigator.push(context, MaterialPageRoute(builder: (_) => SubService(ownerId: ownerId)));
          }
        },
      ),
    );
  }
}


class _CustomListTile extends StatelessWidget {
  final String text, image;
  const _CustomListTile({Key? key, required this.text, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Image.asset(image, height: 22, width: 22, fit: BoxFit.contain, color: Theme.of(context).primaryColor),
          SizedBox(width: 15),
          DrawSingleText(text: text, fontSize: 14),
        ],
      ),
    );
  }
}