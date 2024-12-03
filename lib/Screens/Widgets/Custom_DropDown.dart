import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class CustomDropDown extends StatelessWidget {
  final String? hint, valueChoose;
  final List<DropdownMenuItem<Object>>? items;
  final double? width, horizontalPadding, verticalPadding, borderRadius, fontSize;
  final Color? dropdownColor, borderColor, color;
  final bool? isExpanded;
  final void Function(Object?)? onChanged;

  CustomDropDown({
      this.hint,
      this.items,
      this.width,
      this.horizontalPadding,
      this.verticalPadding,
      this.borderRadius,
      this.dropdownColor,
      this.borderColor,
      this.isExpanded,
      this.onChanged,
      this.valueChoose,
      this.fontSize,
      this.color,
      });

  final String lang = translator.activeLanguageCode;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? MediaQuery.of(context).size.width / 2.5,
      padding: EdgeInsets.only(right: lang == "ar" ? 20 : 10, left: lang == "ar" ? 10 : 20),
      margin: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 0, vertical: verticalPadding ?? 10),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor ?? Theme.of(context).primaryColor, width: 1),
        borderRadius: BorderRadius.circular(borderRadius ?? 10),
        color: color ?? Colors.white,
      ),
      child: DropdownButton(
        hint: Text(
          hint ?? "",
          style: TextStyle(
            fontSize: fontSize ?? 12,
            color: Theme.of(context).primaryColor,
            fontFamily: "JannaLT-Regular",
          ),
        ),
        iconSize: 20,
        dropdownColor: dropdownColor ?? Colors.white,
        icon: Icon(CupertinoIcons.chevron_down, color: Theme.of(context).primaryColor),
        isExpanded: isExpanded ?? true,
        underline: SizedBox(),
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 15,
          fontFamily: "JannaLT-Regular",
        ),
        value: valueChoose,
        onChanged: onChanged,
        items: items,
      ),
    );
  }
}


// String? valueChoose;
// List itemList =[
//   "مصاعد", "موبايل", "تكييف", "تلاجات", "غسالات",
// ];

// items: itemList.map((item) {
//   return DropdownMenuItem(
//     value: item,
//     child: Text(item),
//   );
// }).toList(),