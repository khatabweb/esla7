import '../../controllers/common_controller.dart';
import '../../models/terms_model.dart';
import '../../../../Widgets/AnimatedWidgets.dart';
import '../../../../Widgets/CenterLoading.dart';
import '../../../../Widgets/Custom_AppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class TermsAndCondition extends StatefulWidget {
  @override
  _TermsAndConditionState createState() => _TermsAndConditionState();
}

class _TermsAndConditionState extends State<TermsAndCondition> {
  // String language = translator.activeLanguageCode;
  TermsController _termsController = TermsController();
  TermsModel _termsModel = TermsModel();
  bool isLoading = true;

  void _getTerms() async {
    _termsModel = await _termsController.getTerms();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    _getTerms();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        appBarTitle: "terms_and_condition".tr(),
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
    
      body: isLoading
          ? CenterLoading()
          : AnimatedWidgets(
              verticalOffset: 150,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    _TermsText(
                      text: context.locale.languageCode == "ar"
                          ? _termsModel.termsAr
                          : _termsModel.termsEn,
                    ),
                    _TermsImage(image: "assets/images/tterms.png"),
                  ],
                ),
              ),
            ),
    );
  }
}


class _TermsText extends StatelessWidget {
  final String? text;
  const _TermsText({Key? key,required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Color(0xFFEEEEEE),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        "$text",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          height: 1.8,
          fontSize: 15,
        ),
      ),
    );
  }
}


class _TermsImage extends StatelessWidget {
  final String image;
  const _TermsImage({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height/2,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(vertical: 15,horizontal: 20),
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.contain,
          )
      ),
    );
  }
}

