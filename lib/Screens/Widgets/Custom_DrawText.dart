import 'package:flutter/material.dart';

class DrawSingleText extends StatelessWidget {
  final String? text;
  final TextAlign? textAlign;
  final double? fontSize;
  final double? textHeight;
  final Color? color;
  final String? fontFamily;
  final TextDirection? textDirection;

  DrawSingleText({
    required this.text,
    this.textAlign,
    this.fontSize,
    this.color,
    this.fontFamily,
    this.textDirection,
    this.textHeight,
  });

  //

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? "",
      textAlign: textAlign,
      textDirection: textDirection,
      style: TextStyle(
        height: textHeight,
        fontSize: fontSize ?? 14,
        color: color ?? Theme.of(context).primaryColor,
        fontFamily: fontFamily ?? "JannaLT-Regular",
      ),
    );
  }
}

class DrawHeaderText extends StatelessWidget {
  final String? text;
  final Color? color;
  final double? fontSize;
  final TextAlign? textAlign;
  final TextDirection? textDirection;

  DrawHeaderText({
    required this.text,
    this.color,
    this.fontSize,
    this.textAlign,
    this.textDirection,
  });

  //

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? "",
      textAlign: textAlign ?? TextAlign.start,
      textDirection: textDirection,
      style: TextStyle(
        fontSize: fontSize ?? 15,
        color: color ?? Theme.of(context).primaryColor,
        fontFamily: "JannaLT-Bold",
        // fontWeight: FontWeight.bold,
      ),
    );
  }
}
