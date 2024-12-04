import 'package:esla7/Screens/Widgets/CenterMessage.dart';
import 'package:esla7/Screens/Widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class NoOrdersContainer extends StatelessWidget {
  const NoOrdersContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Container(
      height: height / 4,
      width: width,
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).primaryColor,
          image: DecorationImage(
            image: AssetImage("assets/images/a5.jpg"),
            fit: BoxFit.cover,
          )),
      child: Container(
        height: height / 4,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [
              Theme.of(context).primaryColor.withOpacity(1),
              Theme.of(context).primaryColor.withOpacity(1),
              Theme.of(context).primaryColor.withOpacity(0.9),
              Theme.of(context).primaryColor.withOpacity(0.9),
              Theme.of(context).primaryColor.withOpacity(0.8),
              Theme.of(context).primaryColor.withOpacity(0.8),
              Theme.of(context).primaryColor.withOpacity(0.7),
              Theme.of(context).primaryColor.withOpacity(0.5),
              Theme.of(context).primaryColor.withOpacity(0.5),
              Theme.of(context).primaryColor.withOpacity(0.3),
              Theme.of(context).primaryColor.withOpacity(0.2),
              Theme.of(context).primaryColor.withOpacity(0.1),
              Theme.of(context).primaryColor.withOpacity(0.05),
              Theme.of(context).primaryColor.withOpacity(0.025),
            ],
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomLogo(verticalOffset: 0, size: 100),
            SizedBox(height: 10),
            CenterMessage("there_are_no_ads_banners_now".tr(),
                textColor: Colors.white),
          ],
        ),
      ),
    );
  }
}
