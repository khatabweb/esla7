import 'package:esla7/Screens/Provider/Create_Ad/Ad_features_terms/API/ad_terms_controller.dart';
import 'package:esla7/Screens/Provider/Create_Ad/Ad_features_terms/API/ad_terms_model.dart';
import 'package:esla7/Screens/Widgets/AnimatedWidgets.dart';
import 'package:esla7/Screens/Widgets/CenterLoading.dart';
import 'package:esla7/Screens/Widgets/Custom_AppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class AdFeaturesAndTerms extends StatefulWidget {
  AdFeaturesAndTerms({Key? key}) : super(key: key);

  @override
  State<AdFeaturesAndTerms> createState() => _AdFeaturesAndTermsState();
}

class _AdFeaturesAndTermsState extends State<AdFeaturesAndTerms> {
  final String language = translator.activeLanguageCode;
  AdFeaturesTermsModel _adFeaturesTermsModel = AdFeaturesTermsModel();
  AdFeaturesTermsController _adFeaturesTermsController = AdFeaturesTermsController();
  bool _isLoading = true;

  void _getAdFeatures() async {
    _adFeaturesTermsModel = await _adFeaturesTermsController.getAdFeatures();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    _getAdFeatures();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: language == "ar" ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: customAppBar(
          context: context,
          appBarTitle: "ad_features_terms".tr(),
          backgroundColor: Colors.white,
          elevation: 0.5,
        ),
        body: _isLoading
            ? CenterLoading()
            : AnimatedWidgets(
                verticalOffset: 150,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        margin: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Color(0xFFEEEEEE),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          language == "ar"
                              ? "${_adFeaturesTermsModel.propagandasAr}"
                              : "${_adFeaturesTermsModel.propagandasEn}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            height: 1.8,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}