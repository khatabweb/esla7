import 'AnimatedWidgets.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class CustomLogo extends StatelessWidget {
  final double? verticalOffset, horizontalOffset, size;
  final String language = translator.activeLanguageCode;

  CustomLogo({this.verticalOffset, this.horizontalOffset, this.size});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: language == "ar" ? TextDirection.rtl : TextDirection.ltr,
      child: AnimatedWidgets(
        duration: 2,
        horizontalOffset: horizontalOffset ?? 0,
        verticalOffset: verticalOffset ?? -50,
        child: Container(
          height: size ?? 140,
          width: size ?? 140,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/android.png"),
              fit: BoxFit.cover,
            )
          ),
        ),
      ),
    );
  }
}
