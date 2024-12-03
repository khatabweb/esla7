import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final void Function(String?)? onChanged;
  final void Function()? onTab;
  final void Function(String)? onSubmitted;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validate;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double? width;
  final double? height;
  final double? horizontalPadding;
  final double? verticalPadding;
  final double? leftPadding;
  final double? rightPadding;

  final TextInputType? inputType;
  final String? label;
  final String? hint;
  final int? lines;
  final double? labelSize;
  final bool? secureText;
  final double? radius;

  final bool? isEnabled;
  final Color? color;

  final hintColor;

  final TextEditingController? controller;

  const CustomTextField({
    this.onChanged,
    this.validate,
    this.prefixIcon,
    this.suffixIcon,
    this.width,
    this.height,
    this.inputType,
    this.label,
    this.hint,
    this.lines,
    this.labelSize,
    this.secureText,
    this.radius,
    this.onTab,
    this.onSubmitted,
    this.isEnabled = true,
    this.controller,
    this.horizontalPadding,
    this.verticalPadding,
    this.rightPadding,
    this.leftPadding,
    this.color,
    this.hintColor,
    this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: verticalPadding ?? 0, horizontal: horizontalPadding ?? 0),
      child: Container(
        width: width,
        margin: EdgeInsets.only(
            left: leftPadding ?? 0,
            right: rightPadding ?? 0,
            top: 2.0,
            bottom: 2.0),
        height: height,
        child: TextFormField(
          onTapOutside: (event) {
            FocusScope.of(context).unfocus();
          },
          controller: controller != null ? controller : null,
          onFieldSubmitted: onSubmitted,
          onTap: onTab,
          maxLines: lines ?? 1,
          style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 12),
          obscureText: secureText ?? false,
          cursorColor: Theme.of(context).primaryColor,
          keyboardType: inputType ?? TextInputType.multiline,
          validator: validate,
          onSaved: onSaved,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius ?? 10),
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius ?? 10),
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius ?? 10),
              borderSide: BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius ?? 10),
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
            ),
            errorStyle: TextStyle(
              fontSize: 10,
            ),
            errorMaxLines: 4,
            contentPadding:
                EdgeInsets.only(right: 20, top: 10.0, bottom: 10.0, left: 20),
            border: OutlineInputBorder(
              borderRadius: new BorderRadius.circular(radius ?? 10.0),
              borderSide: new BorderSide(
                color: Theme.of(context).primaryColor,
              ),
            ),
            filled: true,
            fillColor: color ?? Color(0xFFEEEEEE),
            prefixIcon: prefixIcon ?? null,
            suffixIcon: suffixIcon ?? null,
            suffixIconConstraints: BoxConstraints(maxHeight: 35, maxWidth: 45),
            labelText: label,
            labelStyle: TextStyle(
              fontSize: labelSize,
              color: Theme.of(context).primaryColor,
            ),
            hintStyle: TextStyle(
                fontSize: 12,
                color: hintColor ?? Theme.of(context).colorScheme.secondary),
            hintText: hint,
          ),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
