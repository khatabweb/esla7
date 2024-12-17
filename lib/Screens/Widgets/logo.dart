import 'package:flutter/material.dart';
import 'AnimatedWidgets.dart';

class CustomLogo extends StatelessWidget {
  final double? verticalOffset, horizontalOffset, size;

  CustomLogo({this.verticalOffset, this.horizontalOffset, this.size});

  @override
  Widget build(BuildContext context) {
    return AnimatedWidgets(
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
          ),
        ),
      ),
    );
  }
}
