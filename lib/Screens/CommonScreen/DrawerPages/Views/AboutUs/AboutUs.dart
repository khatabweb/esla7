import '../../controllers/common_controller.dart';
import '../../models/aboutus_model.dart';
import '../../../../Widgets/AnimatedWidgets.dart';
import '../../../../Widgets/CenterLoading.dart';
import '../../../../Widgets/Custom_AppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class AboutUs extends StatefulWidget {
  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  String language = translator.activeLanguageCode;
  AboutusController _aboutusController = AboutusController();
  AboutusModel _aboutusModel = AboutusModel();
  bool _isLoading = true;

  void getAboutUs() async {
    _aboutusModel = await _aboutusController.getAboutUs();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    getAboutUs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: language == "ar" ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: customAppBar(
          context: context,
          appBarTitle: "about_us".tr(),
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        margin: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Color(0xFFEEEEEE),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          language == "ar"
                              ? "${_aboutusModel.aboutusesAr}"
                              : "${_aboutusModel.aboutusesEn}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            height: 1.8,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height / 2,
                        width: MediaQuery.of(context).size.width,
                        margin:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: AssetImage("assets/images/aboutus.png"),
                              fit: BoxFit.contain,
                            )),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
