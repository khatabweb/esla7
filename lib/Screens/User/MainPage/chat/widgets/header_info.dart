import 'package:esla7/Screens/Widgets/Custom_DrawText.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

PreferredSizeWidget? headerInfo({
  required BuildContext context,
  final String? name,
  // final String? serviceName,
  // final String? image,
  // final int? orderNumber,
  final bool centerTitle = false,
  final double? elevation,
  final Color? backgroundColor,
}) {
  final String language = translator.activeLanguageCode;
  return AppBar(
    backgroundColor: backgroundColor ?? Colors.white,
    elevation: elevation ?? 0,
    titleSpacing: 0,
    leadingWidth: 50,
    centerTitle: centerTitle,
    leading: InkWell(
      onTap: () => Navigator.pop(context),
      child: Container(
        margin: EdgeInsets.only(
            right: language == "ar" ? 15 : 0,
            left: language == "ar" ? 0 : 15,
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              // CustomRoundedPhoto(
              //   image: "$image",
              //   radius: 25,
              //   borderWidth: 0,
              // ),

              // SizedBox(width: 10),

              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DrawHeaderText(text: name??"", fontSize: 14),
                  // DrawHeaderText(text: serviceName??"", fontSize: 12),
                ],
              )

            ],
          ),
          // Row(
          //   children: [
          //     DrawHeaderText(text: "order_number".tr(), fontSize: 12),
          //     DrawHeaderText(text: "$orderNumber", fontSize: 12, color: ThemeColor.mainGold,),
          //   ],
          // ),
        ],
      ),
    ),

    // actions: [
    //   Container(
    //     margin: EdgeInsets.symmetric(vertical: 15),
    //     padding: EdgeInsets.symmetric(horizontal: 15),
    //     color: Colors.transparent,
    //     child: CustomPopOver(
    //       child: Image.asset("assets/icons/more.png", color: Theme.of(context).primaryColor, height: 20),
    //       itemList: [
    //         TextButton(onPressed: (){}, child: DrawSingleText(text: "view_order".tr(),)),
    //         TextButton(onPressed: (){}, child: DrawSingleText(text: "calling_provider".tr(),)),
    //         TextButton(onPressed: (){}, child: DrawSingleText(text: "delete_chat".tr(),)),
    //       ],
    //     ),
    //   )
    // ],
  );
}
