import 'package:flutter/material.dart';

class CustomTextFieldTap extends StatelessWidget {
  final String? label;
  final Widget? prefixIcon;
  final void Function()? onTap;
  final Widget? icon;
  final double? horizontalPadding, verticalPadding, height;
  final Color? color;
  final Color? hintColor;
  final double? width;
  final double? labelSize;
  final String? fontFamily;

  const CustomTextFieldTap({
    this.label,
    this.prefixIcon,
    this.onTap,
    this.icon,
    this.horizontalPadding,
    this.verticalPadding,
    this.height,
    this.color,
    this.hintColor,
    this.width,
    this.labelSize,
    this.fontFamily,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height ?? 50,
        width: width ?? MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 0, vertical: verticalPadding ?? 5),
        padding: EdgeInsets.only(right: 10, top: 10.0, bottom: 10.0, left: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color ?? Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 12),
                    child: prefixIcon,
                  ),
                  Expanded(
                    child: Container(
                      child: Text(
                        label ?? "",
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: labelSize ?? 12,
                          color: hintColor ?? Theme.of(context).primaryColor,
                          fontFamily: fontFamily,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            icon ??
                Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                  color: Theme.of(context).primaryColor,
                ),
          ],
        ),
      ),
    );
  }
}