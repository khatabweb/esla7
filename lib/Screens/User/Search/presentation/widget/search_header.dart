import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../../../Widgets/Custom_TextFormField.dart';
import '../../data/bloc/cubit.dart';

PreferredSizeWidget? searchHeader({
  required BuildContext context,
  final String? name,
  final String? serviceName,
  final String? image,
  final int? orderNumber,
  final bool centerTitle = false,
  final double? elevation,
  final Color? backgroundColor,
}) {
  final cubit = SearchCubit.get(context);
  return AppBar(
    backgroundColor:
        backgroundColor ?? Theme.of(context).primaryColor.withOpacity(0.5),
    elevation: elevation ?? 0,
    titleSpacing: 0,
    leadingWidth: 50,
    centerTitle: centerTitle,
    leading: InkWell(
      onTap: () => Navigator.pop(context),
      child: Container(
        margin: EdgeInsets.only(
            right: context.locale.languageCode == "ar" ? 15 : 0,
            left: context.locale.languageCode == "ar" ? 0 : 15,
            top: 15,
            bottom: 15),
        child: Icon(
          Icons.arrow_back_ios,
          size: 18,
          color: backgroundColor == Theme.of(context).primaryColor
              ? Colors.white
              : Theme.of(context).primaryColor,
        ),
      ),
    ),
    title: Container(
      child: CustomTextField(
        color: Colors.white,
        label: "search".tr(),
        secureText: false,
        inputType: TextInputType.text,
        labelSize: 14,
        onChanged: (value) {
          cubit.name = value;
          cubit.searchDetails();
        },
      ),
    ),
    actions: [
      SizedBox(width: 15),
    ],
  );
}
