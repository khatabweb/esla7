import 'package:esla7/Theme/color.dart';
import 'package:flutter/material.dart';

class CustomRichText extends StatelessWidget {
  final String? title;
  final String? subTitle;
  final double? fontSize;

  const CustomRichText({Key? key, this.title, this.subTitle, this.fontSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "$title : ",
            style: TextStyle(
              color: ThemeColor.mainGold,
              fontSize: fontSize ?? 12,
              letterSpacing: 1,
              height: 2,
              fontWeight: FontWeight.bold,
              fontFamily: "JannaLT-Regular",
            ),
          ),
          TextSpan(
            text: subTitle,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: fontSize ?? 12,
              letterSpacing: 1,
              height: 2,
              fontWeight: FontWeight.bold,
              fontFamily: "JannaLT-Regular",
            ),
          ),
        ],
      ),
    );
    ;
  }
}
