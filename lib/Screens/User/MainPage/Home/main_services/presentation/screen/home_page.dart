import '../../../../Custom_Drawer/Custom_Drawer.dart';
import '../widget/main_services.dart';
import '../../../../../../CommonScreen/Slider/presentation/slider_view.dart';
import '../../../../../../Widgets/AnimatedWidgets.dart';
import '../../../../../../Widgets/Custom_AppBar.dart';
import '../../../../../../Widgets/Custom_Background.dart';
import '../../../../../../Widgets/Custom_DrawText.dart';
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
