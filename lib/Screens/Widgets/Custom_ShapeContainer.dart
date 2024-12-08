import 'Custom_DrawText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ShapeContainer extends StatelessWidget {
  late final Widget? child;
  late final double? height;
  late final String? text;
  ShapeContainer({this.child, this.height, this.text});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth,
      height: height,
      margin: EdgeInsets.only(top: 20),
      // padding: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        )
      ),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            text != null
                ? Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: DrawHeaderText(
                    text: text,
                      color: Theme.of(context).primaryColor,
                    ),
                )
                : SizedBox(),
            child ?? SizedBox(),
          ],
        ),
      ),
    );
  }
}
