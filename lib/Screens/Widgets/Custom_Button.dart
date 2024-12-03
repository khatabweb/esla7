import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final double? width, height, opacity, radius, topPadding, bottomPadding, rightPadding, leftPadding, horizontalPadding, fontSize;
  final String? text;
  final Color? color, textColor, borderColor;
  final FontWeight? fontWeight;
  final Widget? title;
  final void Function()? onTap;
  final bool? isFrame;
  const CustomButton(
      {this.width,
      this.height,
      this.text,
      this.opacity,
      this.radius,
      this.topPadding,
      this.bottomPadding,
      this.rightPadding,
      this.leftPadding,
      this.color,
      this.textColor,
      this.fontWeight,
      this.title,
      this.fontSize,
      this.onTap,
      this.horizontalPadding,
      this.isFrame, this.borderColor});

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: widget.bottomPadding ?? 8,
          top: widget.topPadding ?? 8,
          left: widget.leftPadding ?? 0,
          right: widget.rightPadding ?? 0,
      ),
      child: InkWell(
        child: Container(
          width: widget.width ?? MediaQuery.of(context).size.width,
          height: widget.height ?? 45,
          padding: EdgeInsets.symmetric(horizontal: widget.horizontalPadding ?? 0),
          decoration: BoxDecoration(
            color: widget.isFrame == true ? Colors.white : (widget.color ?? Theme.of(context).primaryColor),
            borderRadius: BorderRadius.circular(widget.radius ?? 10),
            border: Border.all(
              color: widget.borderColor ?? Theme.of(context).primaryColor
            ),
          ),
          child: Center(
            child: widget.text == null
                ? widget.title
                : Text(
                    widget.text ?? "",
                    style: TextStyle(
                      color: widget.isFrame == true ||
                              widget.color == Colors.white
                          ? (widget.textColor ?? Theme.of(context).primaryColor)
                          : (widget.textColor ?? Colors.white),
                      fontSize: widget.fontSize ?? 15,
                      fontWeight: widget.fontWeight ?? FontWeight.bold,
                      fontFamily: "JannaLT-Bold",
                    ),
                  ),
          ),
        ),
        onTap: widget.onTap,
      ),
    );
  }
}
