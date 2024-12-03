import 'package:esla7/Screens/Provider/Create_Ad/Ad_features_terms/ad_terms_view.dart';
import 'package:esla7/Screens/Provider/Create_Ad/CreateAdsForm/CreateAds_form.dart';
import 'package:esla7/Screens/Widgets/AnimatedWidgets.dart';
import 'package:esla7/Screens/Widgets/CenterLoading.dart';
import 'package:esla7/Screens/Widgets/Custom_AppBar.dart';
import 'package:esla7/Screens/Widgets/Custom_Button.dart';
import 'package:esla7/Screens/Widgets/Custom_DrawText.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import 'ads_packages_apis/controller.dart';
import 'ads_packages_apis/model.dart';

class CreateAdvertising extends StatefulWidget {
  CreateAdvertising({Key? key}) : super(key: key);

  @override
  _CreateAdvertisingState createState() => _CreateAdvertisingState();
}

class _CreateAdvertisingState extends State<CreateAdvertising> {
  final String language = translator.activeLanguageCode;
  bool createAds = false;
  bool isLoading = true;
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
    return Directionality(
      textDirection: language == "ar" ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: customAppBar(
          context: context,
          appBarTitle: "create_an_ad".tr(),
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: AnimatedWidgets(
            verticalOffset: 150,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _AdsImage(),
                  SizedBox(height: 15),
                  DrawHeaderText(text: "advertising_prices".tr()),
                  isLoading
                      ? CenterLoading()
                      : Container(
                          height: 40 *
                              (packagesModel.packages?.length as num)
                                  .toDouble(),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          margin: EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            color: Color(0xFFEEEEEE),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: packagesModel.packages?.length,
                            itemBuilder: (context, index) {
                              return _SingleAdsPrices(
                                duration:
                                    "${packagesModel.packages?[index]?.period}",
                                price:
                                    "${packagesModel.packages?[index]?.price}",
                              );
                            },
                          )),
                  SizedBox(height: 5),
                  _CreateAdsButton(
                    onTap: () => setState(() => createAds = true),
                  ),
                  createAds == true ? CreateAdsForm() : SizedBox(),
                  _AdsFeaturesButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AdsImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: height / 4,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/ads.png"),
        ),
      ),
    );
  }
}

class _SingleAdsPrices extends StatelessWidget {
  final String? duration;
  final String? price;
  const _SingleAdsPrices({Key? key, this.duration, this.price})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      margin: EdgeInsets.symmetric(vertical: 5),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DrawHeaderText(
              text: duration,
              color: Theme.of(context).colorScheme.secondary,
              fontSize: 14),
          DrawHeaderText(
              text: "$price ${"sar".tr()}",
              color: Theme.of(context).colorScheme.secondary,
              fontSize: 14),
        ],
      ),
    );
  }
}

class _CreateAdsButton extends StatelessWidget {
  final void Function()? onTap;
  const _CreateAdsButton({this.onTap});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: "create_an_ad".tr(),
      topPadding: 5,
      bottomPadding: 5,
      onTap: onTap,
    );
  }
}

class _AdsFeaturesButton extends StatelessWidget {
  const _AdsFeaturesButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.push(
          context, MaterialPageRoute(builder: (_) => AdFeaturesAndTerms())),
      child: Text(
        "ad_features_terms".tr(),
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 16,
          fontFamily: "JannaLT-Bold",
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
