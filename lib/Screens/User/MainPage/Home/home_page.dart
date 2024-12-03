import 'package:esla7/Screens/User/MainPage/Custom_Drawer/Custom_Drawer.dart';
import 'package:esla7/Screens/User/MainPage/Home/main_services/main_services.dart';
import 'package:esla7/Screens/CommonScreen/Slider/slider_view.dart';
import 'package:esla7/Screens/Widgets/AnimatedWidgets.dart';
import 'package:esla7/Screens/Widgets/Custom_AppBar.dart';
import 'package:esla7/Screens/Widgets/Custom_Background.dart';
import 'package:esla7/Screens/Widgets/Custom_DrawText.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class HomePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final String language = translator.activeLanguageCode;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: language == "ar" ? TextDirection.rtl : TextDirection.ltr,
      child: CustomBackground(
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.transparent,
          appBar: customAppBar(
            context: context,
            showSearchIcon: true,
            showDrawerIcon: true,
            centerTitle: true,
            appBarTitle: "home".tr(),
            onPressedDrawer: () => _scaffoldKey.currentState!.openDrawer(),
          ),
          drawer: DrawerView(),
          body: AnimatedWidgets(
            verticalOffset: 150,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: DrawHeaderText(
                        text: "our_offers".tr(),
                        color: Theme.of(context).primaryColor),
                  ),
                  ImageSlider(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: DrawHeaderText(
                        text: "our_services".tr(),
                        color: Theme.of(context).primaryColor),
                  ),
                  OurServices(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
